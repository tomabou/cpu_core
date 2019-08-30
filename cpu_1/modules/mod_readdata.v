module mod_readdata (readdata,addr,ctrl,moddata);
    input [31:0] readdata;
    input [31:0] addr;
    input [1:0] ctrl;
    output reg [31:0] moddata;

    always @ (*) begin
        if (ctrl == 2'b10) 
            moddata<= addr;
        else if (ctrl == 2'b01)
            moddata <= 32'b0;
        else
            moddata <= readdata;
    end
endmodule 
