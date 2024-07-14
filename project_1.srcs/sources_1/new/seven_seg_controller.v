`timescale 1ns / 1ps

module seven_seg_controller(
    input wire clk,
    input wire [19:0] binary_coded_decimal,
    output reg [6:0] seven_seg_ca,
    output reg [7:0] seven_seg_an
);

    reg [3:0] digit_select = 0;
    reg [10:0] refresh_counter = 0;

    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
        if (refresh_counter == 0)
            digit_select <= digit_select + 1;
    end

    always @* begin
        case (digit_select)
            4'd0: begin seven_seg_an = 8'b11111110; seven_seg_ca = decode(binary_coded_decimal[3:0]); end
            4'd1: begin seven_seg_an = 8'b11111101; seven_seg_ca = decode(binary_coded_decimal[7:4]); end
            4'd2: begin seven_seg_an = 8'b11111011; seven_seg_ca = decode(binary_coded_decimal[11:8]); end
            4'd3: begin seven_seg_an = 8'b11110111; seven_seg_ca = decode(binary_coded_decimal[15:12]); end
            4'd4: begin seven_seg_an = 8'b11101111; seven_seg_ca = decode(binary_coded_decimal[19:16]); end
            4'd5: begin seven_seg_an = 8'b11011111; seven_seg_ca = 7'b1111111; end
            4'd6: begin seven_seg_an = 8'b10111111; seven_seg_ca = 7'b1111111; end
            4'd7: begin seven_seg_an = 8'b01111111; seven_seg_ca = 7'b1111111; end
            default: begin seven_seg_an = 8'b11111111; seven_seg_ca = 7'b1111111; end
        endcase
    end

    function [6:0] decode;
        input [3:0] number;
        begin
            case (number)
                4'h0: decode = 7'b1000000;
                4'h1: decode = 7'b1111001;
                4'h2: decode = 7'b0100100;
                4'h3: decode = 7'b0110000;
                4'h4: decode = 7'b0011001;
                4'h5: decode = 7'b0010010;
                4'h6: decode = 7'b0000010;
                4'h7: decode = 7'b1111000;
                4'h8: decode = 7'b0000000;
                4'h9: decode = 7'b0010000;
                default: decode = 7'b1111111;
            endcase
        end
    endfunction

endmodule