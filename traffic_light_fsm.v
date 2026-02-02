`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2026 12:05:48
// Design Name: 
// Module Name: traffic_light_fsm
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


module traffic_light_fsm(
    input clk,
    input reset,
    input ped_btn,
    input emergency,
    output reg red,
    output reg yellow,
    output reg green,
    output reg walk,
    output reg dont_walk
    );
    reg [1:0] current_state;
    reg [1:0] next_state;
    reg [4:0] timer;
    parameter red_time    = 10;
    parameter green_time  = 8;
    parameter min_green_time = 5;
    parameter yellow_time = 2;
    parameter s_red    = 2'b00;
    parameter s_green  = 2'b01;
    parameter s_yellow = 2'b10;
    always@(posedge clk)begin
        if(reset)begin   next_state <= s_red;timer <= 0;end
        else begin 
            next_state <= current_state;
            if (current_state != next_state)
                timer <= 0;
            else
                timer <= timer + 1;
            end
    end
    always@(*)begin
        case(current_state)
            s_red : begin 
            if(timer==red_time-1)   next_state = s_green;
            end
            s_yellow : begin 
            if(timer==yellow_time-1)   next_state = s_red;
            end
            s_green : begin 
                if (timer >= min_green_time) begin
                    if (ped_btn)
                        next_state = s_yellow;
                    else if (timer == green_time-1)
                        next_state = s_yellow;
                end
            end
            default : next_state = s_red;
        endcase
    end
    always@(*)begin
        red    = 1'b0;
        yellow = 1'b0;
        green  = 1'b0;
        walk       = 1'b0;
        dont_walk  = 1'b1;
        if (emergency) begin
            green  = 1'b1;
            red    = 1'b0;
            yellow = 1'b0;
            dont_walk = 1'b1;
            walk      = 1'b0;
        end
        else begin
                case(current_state)
                s_red :begin
                    red = 1'b1;
                    walk       = 1'b1;
                    dont_walk  = 1'b0;
                    end
                s_yellow: begin 
                    yellow = 1'b1;
                    dont_walk=1'b1;
                    walk=1'b0;
                    end
                s_green :begin 
                    green = 1'b1;
                    dont_walk=1'b1;
                    walk=1'b0;
                    end
                default: begin
                    red        = 1'b1;
                    dont_walk  = 1'b1;
                    walk=1'b0;
                    end
            endcase
            end
    end    
endmodule
