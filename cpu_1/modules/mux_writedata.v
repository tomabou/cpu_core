module mux_writedata (
    alu_res,
    address,
    from_floatreg,
    is_address,
    is_fromfloat
    q);

    input [31:0] alu_res;
    input [31:0] address;
    input [31:0] from_floatreg;
    input is_address;
    input is_fromfloat;
    output reg [31:0] q;

    always @ (*) begin
        if (is_address == 1'b1)
            q <= address;
        else if (is_fromfloat == 1'b1)
            q <= from_floatreg;
        else
            q <= alu_res;
    end
endmodule

