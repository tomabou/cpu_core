module mux_writedata (
    alu_res,
    address,
    from_floatreg,
    mem_read,
    is_address,
    is_fromfloat,
    is_memread,
    q);

    input [31:0] alu_res;
    input [31:0] address;
    input [31:0] from_floatreg;
    input [31:0] mem_read;
    input is_address;
    input is_fromfloat;
    input is_memread;
    output reg [31:0] q;

    always @ (*) begin
        if (is_address == 1'b1)
            q <= address;
        else if (is_fromfloat == 1'b1)
            q <= from_floatreg;
        else if (is_memread == 1'b1)
            q <= mem_read;
        else
            q <= alu_res;
    end
endmodule

