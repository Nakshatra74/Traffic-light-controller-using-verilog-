`timescale 1ns / 1ps
module simulate();
    reg clk;
    reg reset, ped_btn, emergency;
    wire red, yellow, green;
    wire walk, dont_walk;

    traffic_light_fsm dut (
        .clk(clk),
        .reset(reset),
        .ped_btn(ped_btn),
        .emergency(emergency),
        .red(red),
        .yellow(yellow),
        .green(green),
        .walk(walk),
        .dont_walk(dont_walk)
    );

    always #5 clk = ~clk; // 10 time-unit clock period

    initial begin
        // Print output to the console whenever a signal changes
        $monitor("Time=%0t | rst=%b ped=%b emerg=%b | RYG=%b%b%b | walk=%b dwalk=%b", 
                 $time, reset, ped_btn, emergency, red, yellow, green, walk, dont_walk);

        // Initialize
        clk = 0;
        reset = 1;
        ped_btn = 0;
        emergency = 0;

        // 1. Release reset first
        #20 reset = 0; 

        // 2. Wait for the light to turn Green
        #150; 
        
        // 3. Test the Pedestrian Button
        ped_btn = 1;
        #10 ped_btn = 0;
        
        // 4. Wait for it to cycle through Yellow and back to Red
        #100; 

        // 5. Test the Emergency Override
        #40 emergency = 1;
        #20 emergency = 0;

        #200 $finish;
    end
endmodule
