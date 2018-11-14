`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: 
//
// Create Date: 09/25/2018 01:44:55 PM
// Design Name:
// Module Name: Double_Digit_Counter
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


module Double_Digit_Counter(
    input clk,
    input reset,
    input BUTTON,
    output reg [4:1] ENABLE,
    output reg [7:0] SEGMENT
    );

    reg [12:1] DIVIDER;
    reg [15:0] BCD;
    reg [3:0] DECODE_BCD;
    //reg [3:0] DEBOUNCE_count;

    wire SCAN_clk;
    wire BUTTON_clk;

    //Controls the value of reg 'divider'; if 'reset' is pressed
    //divider is set to zero, and otherwise is incremental on the
    //clock tick.
    always @(negedge clk or posedge reset)
        begin
            if(reset)
                DIVIDER <= 12'h000;
            else
                DIVIDER <= DIVIDER + 1;
        end
   assign SCAN_clk = DIVIDER[12];

   // finite state machine for the debouncing circuit//??????????????????????????????
   db_fsm U1 (.clk(clk), .reset(reset), .sw(BUTTON), .db(BUTTON_clk));

   // 00 to 99 up counter

   //Controls the value of bcd; if 'reset' is pressed, the value
   //is set to zero. Otherwise, the value is incremented on
   //button_clk
   always @(negedge BUTTON_clk or posedge reset)
    begin
        if(reset)
            BCD <= 16'h000;
        else
            begin
                    //BCD <= 16'h000;
                    if(BCD[3:0] == 4'h9)
                        begin
                        if (BCD[7:4] == 4'h9)
                            if (BCD[11:8] == 4'h9)
                                if (BCD[15:12] ==4'h9)
                                    BCD <= 16'h0000;
                                else
                                    begin
                                        BCD[15:12] = BCD[15:12] + 1;
                                        BCD[11:0] = 12'h000;
                                    end
                            else
                                begin
                                    BCD[11:8] <= BCD[11:8] + 1;
                                    BCD[7:0] <= 8'h00;
                                end
                        else
                            begin
                                BCD[7:4] = BCD[7:4] + 1;
                                BCD[3:0] = 4'h0;
                            end
                    end
                else
                    begin
                    BCD[3:0] <= BCD[3:0] + 1;
                    if(BCD == 15'h9999)    
                        BCD <= 15'h0000;
                    end
              end
      end

    //Enable the LED Display
    always @(negedge SCAN_clk or posedge reset)
        begin
            if(reset)
                ENABLE <= 4'b1110;
            else
                ENABLE <= {4'b11,ENABLE[3:1],ENABLE[4]};
        end

    //Data display multiplexer
    always @(ENABLE or BCD)
        begin
            case (ENABLE)
                4'b1110 : DECODE_BCD <= BCD[3:0];
                4'b1101 : DECODE_BCD <= BCD[7:4];
                4'b1011 : DECODE_BCD <= BCD[11:8];
                4'b0111 : DECODE_BCD <= BCD[15:12];
                default : DECODE_BCD <= BCD[15:12];
            endcase
        end


    // BCD to Seven Segment Decoder
    always @(DECODE_BCD)
        begin
            case (DECODE_BCD)
                4'h0    :  SEGMENT = {1'b1, 7'b1000000}; //0
                4'h1    :  SEGMENT = {1'b1, 7'b1111001}; //1
                4'h2    :  SEGMENT = {1'b1, 7'b0100100}; //2
                4'h3    :  SEGMENT = {1'b1, 7'b0110000}; //3
                4'h4    :  SEGMENT = {1'b1, 7'b0011001}; //4
                4'h5    :  SEGMENT = {1'b1, 7'b0010010}; //5
                4'h6    :  SEGMENT = {1'b1, 7'b0000010}; //6
                4'h7    :  SEGMENT = {1'b1, 7'b1111000}; //7
                4'h8    :  SEGMENT = {1'b1, 7'b0000000}; //8
                4'h9    :  SEGMENT = {1'b1, 7'b0010000}; //9
                default :  SEGMENT = {1'b1, 7'b1111111};
            endcase
        end
        
endmodule

