`timescale 1ns / 1ps


module LFSR_counter(
    output wire out,
    input wire clk,
    input wire rst,
    output wire LFSR_out,
    output wire max_tick,
    output wire[13:0] count,
    output wire[3:0] an,
    output wire[7:0] sseg,
    output reg[15:0] LED
    );
    
    localparam CLKSCALE = 5000000;
    wire divclk;
    
    wire[15:0] LED_next;
    
    assign LED_next = {LFSR_out, LED[15:1]};
    
    always@(posedge LFSR_clk)
    begin
        LED <= LED_next;
    end
        
        
    ClockDivider clkd(.CLK(clk), .clkscale(CLKSCALE), .clk_out(divclk));
    
    
    
    wire LFSR_clk;
    assign LFSR_clk =  divclk | (max_tick & count != 14'b0 & !rst);
    wire[3:0] DP = 4'b1111;
    
    wire[3:0] ones, tens, hundreds, thousands;
    assign ones = (count)%10;
    assign tens = ((count)%100)/10;
    assign hundreds = ((count)%1000)/100;
    assign thousands = (count%10000)/1000;
     
    
    LFSR lfsr_mod(.CLK(LFSR_clk), .RST(rst), .out_reg(LFSR_out), .max_tick_reg(max_tick));
    
    Counter cntr(.CLK(LFSR_clk), .RST(rst), .out_reg(count), .EN(out));
    
    CodeDetector cd(.SerialIn(LFSR_out), .CodeDetected_reg(out), .RST(rst), .CLK(LFSR_clk));
    
    disp_hex_mux disp(.clk(clk), .reset(rst), .dp_in(DP), .an(an), .sseg(sseg),
        .hex0(ones), .hex1(tens), .hex2(hundreds), .hex3(thousands));
    
    
    
    
endmodule
