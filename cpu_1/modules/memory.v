module memory(
    clk,
    funct3,
    addr_inst,readdata_inst,
    addr,writedata,readdata,
    writectrl,readctrl,
    empty,uart_in,uart_out,wrreq,rdreq,
    seg_io,
    clken);
    input clk;
    input [2:0] funct3;
    input [31:0] addr;
    input [31:0] addr_inst;
    input [31:0] writedata;
    output reg [31:0] readdata;
    output [31:0] readdata_inst;
    input writectrl;
    input readctrl;
    input empty;
    input [7:0] uart_in;
    output [7:0] uart_out;
    output wrreq;
    output reg rdreq;
    output reg [15:0] seg_io;
    output clken;

    wire [31:0] ram_readdata;
    reg isuart_pre = 1'b0;
    reg empty_pre = 1'b0;
    reg [2:0] funct3_pre = 3'b0;
    reg [1:0] low_addr_pre = 2'b0;

    reg [31:0] mod_readdata;

    reg [31:0] b_data;
    reg [31:0] bu_data;
    reg [31:0] h_data;
    reg [31:0] hu_data;

    reg [3:0] state = 4'd0;
    reg [31:0] readdata_pre;

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
            if (~isuart_pre) 
                readdata<=mod_readdata;
            else if (~empty_pre)
                readdata<={24'b0,uart_in};
            else
                readdata<={32{1'b1}};
        end
        else
            readdata <= readdata_pre;
    end



    assign uart_out = writedata[7:0];
    assign wrreq = (addr == 32'b100 & writectrl);

    always @ (*) begin
        case (state)
            0 : rdreq <= (addr == 32'b100 & readctrl & (~empty));
            1 : rdreq <= ~empty;
            default : rdreq <= 1'b0;
        endcase
    end

    assign clken = (state == 4'd0);


    ram_2port ram_2port1(
        addr_inst[16:2],
        addr[16:2],
        4'b1111,
        clk,
        32'b0,
        writedata,
        1'b0,
        writectrl & (addr != 32'b000) & (addr != 32'b100),
        readdata_inst,
        ram_readdata);

    always @ (posedge clk) begin
        case (state)
            4'd0 : begin
                if (addr == 32'b0 & writectrl)
                    seg_io <= writedata[15:0];
                isuart_pre <= (addr == 32'b100 & readctrl);
                empty_pre <= empty;
                funct3_pre <= funct3;
                low_addr_pre <= addr[1:0];
                readdata_pre <= readdata;
            end

            4'd1 : begin 
                if (~empty) 
                    state <= 4'd0;
            end 
        endcase
    end

endmodule

