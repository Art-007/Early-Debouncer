`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/1/2020 01:36:16 PM
// Design Name: 
// Module Name: mod_m_counter
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


module mod_m_counter
    #(parameter M = 10)// amount counted to
    (
        input logic clk, reset,
        output logic [N - 1:0] count,
        output logic max_tick
    );
        
    localparam N = $clog2(M); // N is a constant for the amount of bits in count
    
    // signals
    logic [N - 1:0] reg_next, cur_reg; //next register and current register
    
    //1. Register 
    always_ff @(posedge clk, posedge reset)
    begin
        if(reset)
            cur_reg <= 0;//reset to 0
        else
            cur_reg <= reg_next;
    end
    
    //2. next-state logic
    assign reg_next = (cur_reg == (M - 1))? 0: cur_reg + 1;
    
    //3.output logic 
    assign count = cur_reg;    
    
    assign max_tick = (cur_reg == M - 1) ? 1'b1: 1'b0; //check to see at max count
    
endmodule
