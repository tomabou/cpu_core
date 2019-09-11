module mod_readdata (readdata,addr,is_auipc,is_lui,moddata);
    input [31:0] readdata;
    input [31:0] addr;
    input is_auipc;
    input is_lui;
    output reg [31:0] moddata;

    always @ (*) begin
        if (is_auipc == 1'b1) 
            moddata<= addr; //auipc
        else if (is_lui == 1'b1)
            moddata <= 32'b0; //lui
        else
            moddata <= readdata;
    end
endmodule 
