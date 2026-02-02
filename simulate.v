`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2026 12:15:54
// Design Name: 
// Module Name: simulate
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


module simulate(

    );
    reg clk;
    reg reset,ped_btn,emergency;
    wire red, yellow, green;
    wire walk, dont_walk;
    traffic_light_fsm dut (.clk(clk),.reset(reset),.ped_btn(ped_btn),.emergency(emergency),.red(red),.yellow(yellow),.green(green),.walk(walk),.dont_walk(dont_walk));
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        ped_btn = 0;
        emergency = 0;
        #30 ped_btn = 1;
        #10 ped_btn = 0;
        #10 reset = 0;
        #40 emergency = 1;
        #20 emergency = 0;
        #200 $finish;
    end
endmodule
