`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2020 01:58:08 PM
// Design Name: 
// Module Name: early_debounce
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


module early_debounce(
        input logic sw,
        input logic reset,
        input logic clk, 
        output logic db
    );

    // 10 ms m_tick generator
    logic m_tick;
    mod_m_counter #(.M(1_000_000)) tick_gen (
                    .clk(clk),
                    .reset(reset),  
                    .count(),
                    .max_tick(m_tick)
    );
    
    
    typedef enum {zero, wait1_1, wait1_2, wait1_3, one, wait0_1, wait0_2, wait0_3} state_type;
    
    // signals for current state and next state
    state_type state_reg, state_next;
    
    // state register
    always_ff @(posedge clk, posedge reset)
        if(reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
            
    
    // next-state logic
    always_comb
    begin
        case(state_reg)
            zero:
                    if(sw)
                        state_next = wait1_1;
                    else
                        state_next = zero;
            wait1_1:
                    if(m_tick)
                         state_next = wait1_2;
                        else
                         state_next = wait1_1;
            wait1_2:
                    if(m_tick)
                         state_next = wait1_3;
                    else
                         state_next = wait1_2;                  
            wait1_3:
                    if(m_tick)
                         state_next = one;
                    else 
                         state_next = wait1_3;  
            one:
                    if(~sw)
                        state_next = wait0_1;
                    else
                        state_next = one;
            wait0_1:
                    if(m_tick)
                        state_next = wait0_2;
                    else
                        state_next = wait0_1;
            wait0_2:
                    if(m_tick)
                         state_next = wait0_3;
                    else 
                         state_next = wait0_2;               
            wait0_3:
                    if(m_tick)
                         state_next = zero;
                    else
                         state_next = wait0_3; 
            default: state_next = zero;
        endcase
    end
    
    // Moore output logic
    assign db = (   (state_reg == one) || 
                    (state_reg == wait1_1) || 
                    (state_reg == wait1_2) || 
                    (state_reg == wait1_3));
endmodule

