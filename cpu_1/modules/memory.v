module memory(
    clk,
    funct3,
    addr_inst,inst_out,
    addr,writedata,readdata,
    writectrl,readctrl,
    empty,full,uart_in,uart_out,wrreq,rdreq,
    seg_io,
    clken,
    fifo_wr_data,
    fifo_wr,
    fifo_wr_addr,
    fifo_wr_full,
    fifo_rd_data,
    fifo_rd,
    fifo_rd_addr,
    fifo_rd_empty);

    input clk;
    input [2:0] funct3;
    input [31:0] addr;
    input [31:0] addr_inst;
    input [31:0] writedata;
    output reg [31:0] readdata;
    output [31:0] inst_out;
    input writectrl;
    input readctrl;
    input empty;
    input full;
    input [7:0] uart_in;
    output [7:0] uart_out;
    output reg wrreq;
    output reg rdreq;
    output reg [15:0] seg_io;
    output clken;

    output [15:0] fifo_wr_data;
    output reg fifo_wr;
    output [24:0] fifo_wr_addr;
    input fifo_wr_full;
    input [15:0] fifo_rd_data;
    output reg fifo_rd;
    output [24:0] fifo_rd_addr;
    input fifo_rd_empty;

    wire [31:0] ram_readdata;
    reg isuart_pre = 1'b0;
    reg isfifo_pre = 1'b0;
    reg empty_pre = 1'b0;
    reg [2:0] funct3_pre = 3'b0;
    reg [1:0] low_addr_pre = 2'b0;

    reg [31:0] mod_readdata;

    reg [31:0] b_data;
    reg [31:0] bu_data;
    reg [31:0] h_data;
    reg [31:0] hu_data;

    reg [3:0] state = 4'd0;
    reg [3:0] pre_state = 4'd0;
    reg [31:0] readdata_pre;
    reg [31:0] writedata_pre;
    reg [31:0] readdata_inst_pre;
    wire [31:0] readdata_inst;
    

    //little endian
    always @ (*) begin
        case (low_addr_pre[1:0])
            2'd0    : bu_data <= {24'b0,ram_readdata[7:0]};
            2'd1    : bu_data <= {24'b0,ram_readdata[15:8]};
            2'd2    : bu_data <= {24'b0,ram_readdata[23:16]};
            default : bu_data <= {24'b0,ram_readdata[31:24]};
        endcase
    end
    
    always @ (*) begin
        case (low_addr_pre[1:0])
            2'd0    : b_data <= {{24{ram_readdata[7]}},ram_readdata[7:0]};
            2'd1    : b_data <= {{24{ram_readdata[15]}},ram_readdata[15:8]};
            2'd2    : b_data <= {{24{ram_readdata[23]}},ram_readdata[23:16]};
            default : b_data <= {{24{ram_readdata[31]}},ram_readdata[31:24]};
        endcase
    end

    always @ (*) begin
        case (low_addr_pre[0])
            1'd0    : hu_data <= {16'b0,ram_readdata[15:0]};
            default : hu_data <= {16'b0,ram_readdata[31:16]};
        endcase
    end

    always @ (*) begin
        case (low_addr_pre[0])
            1'd0    : h_data <= {{16{ram_readdata[15]}},ram_readdata[15:0]};
            default : h_data <= {{16{ram_readdata[31]}},ram_readdata[31:16]};
        endcase
    end
    
    
    always @ (*) begin
        case(funct3_pre)
            3'b000: mod_readdata <= b_data; 
            3'b001: mod_readdata <= h_data;
            3'b010: mod_readdata <= ram_readdata;
            3'b100: mod_readdata <= bu_data;
            default: mod_readdata <= hu_data;
        endcase
    end

    always @ (*) begin
        if (state == 4'd0) begin
            if (isuart_pre) 
                readdata<={24'b0,uart_in};
            else if (isfifo_pre)
                readdata<={16'b0,fifo_rd_data};
            else 
                readdata<=mod_readdata;
        end
        else
            readdata <= readdata_pre;
    end



    assign uart_out = (state == 4'd0) ? writedata[7:0] : writedata_pre[7:0];
    assign fifo_wr_data = (state == 4'd0) ? writedata[15:0] : writedata_pre[15:0];

    always @ (*) begin
        case (state)
            0 : wrreq <= (addr == 32'b100 & writectrl & (~full));
            2 : wrreq <= ~full;
            default : wrreq <= 1'b0;
        endcase
    end

    always @ (*) begin
        case (state)
            0 : rdreq <= (addr == 32'b100 & readctrl & (~empty));
            1 : rdreq <= ~empty;
            default : rdreq <= 1'b0;
        endcase
    end

    always @ (*) begin
        case (state)
            0 : fifo_wr <= (addr[25] == 1'b1 & writectrl & (~fifo_wr_full));
            4 : fifo_wr <= ~fifo_wr_full;
            default : fifo_wr <= 1'b0;
        endcase
    end

    always @ (*) begin
        case (state)
            0 : fifo_rd <= (addr[25] == 1'b1 & readctrl & (~fifo_rd_empty));
            3 : fifo_rd <= ~fifo_rd_empty;
            default : fifo_rd <= 1'b0;
        endcase
    end

    assign clken = (state == 4'd0);
    assign inst_out = (pre_state == 4'd0) ? readdata_inst : readdata_inst_pre;


    ram_2port ram_2port1(
        addr_inst[16:2],
        addr[16:2],
        4'b1111,
        clk,
        32'b0,
        writedata,
        1'b0,
        writectrl & (addr != 32'b000) & (addr != 32'b100) & (~addr[25]),
        readdata_inst,
        ram_readdata);

    always @ (posedge clk) begin
        pre_state <= state;
        if (pre_state == 4'd0)
            readdata_inst_pre <= readdata_inst;
        case (state)
            4'd0 : begin
                if (addr == 32'b100 & readctrl & (empty))
                    state <= 4'd1;
                else if (addr == 32'b100 & writectrl & (full))
                    state <= 4'd2;
                else if (addr[25] & readctrl & fifo_rd_empty)
                    state <= 4'd3;
                else if (addr[25] & writectrl & fifo_wr_full)
                    state <= 4'd4;
                
                if (addr == 32'b0 & writectrl)
                    seg_io <= writedata[15:0];
                isuart_pre <= (addr == 32'b100 & readctrl);
                isfifo_pre <= (addr[25] & readctrl);
                empty_pre <= empty;
                funct3_pre <= funct3;
                low_addr_pre <= addr[1:0];
                readdata_pre <= readdata;
                writedata_pre <= writedata;
            end

            4'd1 : begin 
                if (~empty) 
                    state <= 4'd0;
            end 
            4'd2 : begin
                if (~full)
                    state <= 4'd0;
            end
            4'd3 : begin 
                if (~fifo_rd_empty)
                    state <= 4'd0;
            end
            4'd4 : begin
                if (~fifo_wr_full)
                    state <= 4'd0;
            end
        endcase
    end

endmodule

