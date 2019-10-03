module uart(
    slow_clk,
    rxd,
    txd,
    clk,
    wrreq,
    write_data,
    rdreq,
    read_data,
    empty,
    wrfull);

    input slow_clk;
    input rxd;
    output txd;
    input clk;
    input wrreq;
    input [7:0] write_data;
    input rdreq;
    output [7:0] read_data;
    output empty;
    output wrfull;

    wire is_send;
    wire from_cpu_empty;
    wire [7:0] rcv_data;
    wire [7:0] from_cpu;
    wire rcv;
    reg send_enable;
    reg rd_fromcpu;
    uart_rcv uart_rcv1(slow_clk,rxd,rcv_data,rcv);
    uart_send uart_send1(slow_clk,from_cpu,send_enable,txd,is_send);

    wire fifo_full;
    fifo fifo_tocpu(
        rcv_data,
        clk,
        rdreq,
        slow_clk,
        rcv,
        read_data,
        empty,
        fifo_full);
    fifo fifo_fromcpu(
        write_data,
        slow_clk,
        rd_fromcpu,
        clk,
        wrreq,
        from_cpu,
        from_cpu_empty,
        wrfull);

    always @ (posedge slow_clk) begin
        if (~is_send & ~from_cpu_empty &(~rd_fromcpu) & ~send_enable)
            rd_fromcpu <= 1'b1;
        else
            rd_fromcpu <= 1'b0;

        if (rd_fromcpu)
            send_enable <= 1'b1;
        else
            send_enable <= 1'b0;
    end


endmodule
