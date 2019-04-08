`timescale 1ns / 1ps


module ClockTestBench(

    );
    
    reg CLK;
    reg RST;
    wire out;
    wire LFSR_out;
    wire max_tick;
    wire[13:0] count;
    
    LFSR_counter UUT(.clk(CLK), .rst(RST), .out(out), .LFSR_out(LFSR_out), .max_tick(max_tick), .count(count));
    
    initial
    begin
        RST = 1'b1;
    end
    
    
    always
    begin
        CLK = 1'b0;
        #1;
        CLK = 1'b1;
        #1;
    end
    
    initial
    begin
        #20;
        RST = 1'b0;
    end
    
    
    
    always@*
    begin
        if(max_tick)
            $stop;
    end 
endmodule
