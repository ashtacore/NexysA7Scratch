`timescale 1ns / 1ps

module binary_to_bcd(
    input wire [15:0] binary,
    output reg [19:0] binary_coded_decimal
    );

    integer i;
    reg [4:0] offset;
    
    always @(binary) begin
        // There are several ways to to do a BCD conversion, this is the Double Dabble Algo
        binary_coded_decimal = 0;
        for (i = 0; i < 16; i = i + 1) begin
            if (binary_coded_decimal[3:0] >= 5)
                binary_coded_decimal[3:0] = binary_coded_decimal[3:0] + 3;

            if (binary_coded_decimal[7:4] >= 5)
                binary_coded_decimal[7:4] = binary_coded_decimal[7:4] + 3;

            if (binary_coded_decimal[11:8] >= 5)
                binary_coded_decimal[11:8] = binary_coded_decimal[11:8] + 3;

            if (binary_coded_decimal[15:12] >= 5)
                binary_coded_decimal[15:12] = binary_coded_decimal[15:12] + 3;

            if (binary_coded_decimal[19:16] >= 5)
                binary_coded_decimal[19:16] = binary_coded_decimal[19:16] + 3;
            
            binary_coded_decimal = {binary_coded_decimal[18:0], binary[15-i]};
        end

        // Convert any leading 0000 to 1111. This will turn off the leading parts of the display

        /* This bit of code doesn't work becuase you can't use a variable when doing bit selection
        offset = 0;
        for (i = 0; i < 5; i = i + 1) begin
            offset = 19 - (i * 4);
            case (binary_coded_decimal[offset:offset-4])
                4'b0000: binary_coded_decimal[offset:offset-4] = 4'b1111;
                default: i = 5;
            endcase
        end
        */ 

        if (binary_coded_decimal[19:16] == 4'b0000) begin
            binary_coded_decimal[19:16] = 4'b1111;
            if (binary_coded_decimal[15:12] == 4'b0000) begin
                binary_coded_decimal[15:12] = 4'b1111;
                if (binary_coded_decimal[11:8] == 4'b0000) begin
                    binary_coded_decimal[11:8] = 4'b1111;
                    if (binary_coded_decimal[7:4] == 4'b0000) begin
                        binary_coded_decimal[7:4] = 4'b1111;
                    end
                end
            end
        end
    end

endmodule
