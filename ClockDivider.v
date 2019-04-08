`timescale 1ns / 1ps

module ClockDivider(
    input wire CLK,
    input wire [31:0] clkscale,
    output reg clk_out
    );
    
    reg[31:0] clkq = 0;
    //count up to some max, then flip clock
    //given in notes
    always@(posedge CLK)
    begin
        clkq = clkq + 1;
        if(clkq >= clkscale)
        begin
            clk_out=~clk_out;
            clkq=0;
        end
    end
endmodule
