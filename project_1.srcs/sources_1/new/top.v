`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jay Runyan
// 
// Create Date: 07/10/2024 11:41:48 PM
// Design Name: Nexys A7 Test
// Module Name: top
// Project Name: project_1
// Target Devices: 
// Tool Versions: 
// Description: Playing with the IO of the Nexys A7
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input wire clk,                   // Board clock
    input wire [15:0] switches,       // 15 switches
    output wire [15:0] led,            // 15 LEDs
    output wire [6:0] seven_seg_ca,   // 7 segments of the display
    output wire [7:0] seven_seg_an    // 8 anodes for digit selection
);

    // Declarations
    wire [19:0] binary_coded_decimal;

    assign led = switches;

    binary_to_bcd converter(
        .binary(switches),
        .binary_coded_decimal(binary_coded_decimal)
    );

    seven_seg_controller display(
        .clk(clk),
        .binary_coded_decimal(binary_coded_decimal),
        .seven_seg_ca(seven_seg_ca),
        .seven_seg_an(seven_seg_an)
    );

endmodule
