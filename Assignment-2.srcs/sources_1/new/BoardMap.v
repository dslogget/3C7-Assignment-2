`timescale 1ns / 1ps

module BoardMap(
    input clk,
    input rst,
    output [3:0] an,
    output [7:0] sseg,
    output [15:0] LED
    );
    
    
    LFSR_counter lc(.clk(clk), .rst(rst), .an(an), .sseg(sseg), .LFSR_out(LFSR_out), .LED(LED));
    
    
endmodule
