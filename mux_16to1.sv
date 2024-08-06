`timescale 1ns/1ps

/*
* Company: Santa Clara University
* Engineer: Jonathan Trinh
*
* Create Date: 10/14/2019 12:18:17 PM
* Design Name:
* Module Name: mux_16to1
* Project Name: Delay-based Physical Unclonable Function Implementation
* Target Devices: Digilent S7-25, S7-50 (Xilinx Spartan 7)
* Tool Versions:
* Description: The mux_16to1 is a multiplexer that selects between 16 inputs
*              and passes through only one. It follows that the select line
*              is a 4-bit bus.
*
* Dependencies:
*
* Revision:
* Revision 0.01 - File Created
* Additional Comments:
*
*/

module mux_16to1(
  input [15:0] in,
  input [3:0] sel,
  output reg out);

  always_comb begin
    unique case (sel)
      4'b0000: out = in[0];
      4'b0001: out = in[1];
      4'b0010: out = in[2];
      4'b0011: out = in[3];
      4'b0100: out = in[4];
      4'b0101: out = in[5];
      4'b0110: out = in[6];
      4'b0111: out = in[7];
      4'b1000: out = in[8];
      4'b1001: out = in[9];
      4'b1010: out = in[10];
      4'b1011: out = in[11];
      4'b1100: out = in[12];
      4'b1101: out = in[13];
      4'b1110: out = in[14];
      4'b1111: out = in[15];
    endcase
  end

endmodule

