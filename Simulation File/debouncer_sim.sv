`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2020 05:17:42 PM
// Design Name: 
// Module Name: debouncer_sim
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


module debouncer_sim(

    );
    
    localparam T = 10;//clk period
    
    logic clk, reset, button, db;
    
    //uut
    early_debounce  uut(
        .sw(button), .reset(reset), .clk(clk), 
        .db(db));
        
    //10ns clk
    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    initial
    begin
        reset = 1'b1;
        #(T/2);
        reset = 1'b0;
    end
    
    initial
    begin
    
        #40_000_000;
        
        repeat(4000) @(negedge clk);
        button = 1'b1;
        #2_000_000;
        button = 1'b0;
        #2_000_000;
        button = 1'b1;
        #2_000_000;
        button = 1'b0;
        #2_000_000;
        button = 1'b1;
        #100_000_000;
        
        repeat(4000) @(negedge clk);
        button = 1'b0;
        #2_000_000;
        button = 1'b1;
        #2_000_000;
        button = 1'b0;
        #2_000_000;
        button = 1'b1;
        #2_000_000;
        button = 1'b0;
        #100_000_000;;
        
        
        repeat(4000) @(negedge clk);
        button = 1'b1;
        #5_000_000;
        button = 1'b0;
        #5_000_000;
        button = 1'b1;
        #5_000_000;
        button = 1'b0;
        #5_000_000;
        button = 1'b1;
        #2_000_000;
        button = 1'b0;   
        
        #2_000_000;
        button = 1'b1;
        #5_000_000;
        button = 1'b0;
        #5_000_000;
        button = 1'b1;
        #5_000_000;
        button = 1'b0;
        #5_000_000;
        button = 1'b1;
        
        
        button = 1'b1;
        #5_000_000;
        button = 1'b0;
        #5_000_000;
        button = 1'b1;
        #5_000_000;
        button = 1'b0;
        #5_000_000;
        button = 1'b1;
        #2_000_000;
        button = 1'b0;  
  
        
     end   
        
        
endmodule
