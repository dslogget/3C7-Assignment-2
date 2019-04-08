`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2019 11:25:53
// Design Name: 
// Module Name: CodeDetector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CodeDetector(
    input SerialIn,
    input CLK, RST,
    output reg CodeDetected_reg
    );
    localparam CODE = 4'b0100;
    localparam  A = 4'b00,
                B = 4'b01,
                C = 4'b11,
                D = 4'b10; //Gray coding
                
    reg CodeDetected_next;
    reg[1:0] state_reg;
    reg[1:0] state_next;
    
    always @*
    begin
        CodeDetected_next = 0;
        if(state_reg == B)
            if(SerialIn)
                state_next = C;
            else
                state_next = A;
        else if(state_reg == C)
            if(SerialIn)
                state_next = B;
            else
                state_next = D;
        else if(state_reg == D)
            if(SerialIn)
                state_next = A;
            else
            begin
                state_next = B;
                CodeDetected_next = 1; 
            end
        else
            if(SerialIn)
                state_next = A;
            else
                state_next = B;
                    
    end  
    
    always @(posedge CLK)
    begin
        if(RST)
        begin
            CodeDetected_reg <= 0;
            state_reg <= 0;
        end
        else
        begin
            state_reg <= state_next;
            CodeDetected_reg <= CodeDetected_next;  
        end
    end
    
    
    
endmodule
