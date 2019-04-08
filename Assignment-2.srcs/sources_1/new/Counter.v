`timescale 1ns / 1ps

module Counter(
    input EN,
    output reg [13:0] out_reg,
    input CLK,
    input RST
    );
    
    wire[13:0] out_next;
    assign out_next = out_reg + 1;
    
    always@(posedge CLK)
    begin
        if(RST)
            out_reg <= 0;
        else if(EN)
            out_reg <= out_next;
        else
            out_reg <= out_reg;
    end
    
    
endmodule
