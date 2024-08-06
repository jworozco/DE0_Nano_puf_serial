`timescale 1ns/1ps

/*
* Company: Santa Clara University
* Engineer: Jonathan Trinh
*
* Create Date: 10/10/2019 03:22:41 PM
* Design Name:
* Module Name: ring_osc
* Project Name: Delay-based Physical Unclonable Function Implementation
* Target Devices: Digilent S7-25, S7-50 (Xilinx Spartan 7)
* Tool Versions:
* Description: The ring_osc module is a ring oscillator with 14 inverters that loop
*              back into the Nand Gate effectively making 15 inverters in total.
*
* Dependencies:
*
* Revision:
* Revision 0.01 - File Created
* Additional Comments:
*
*/

module ring_osc(
  output out,
  input enable);

   logic w1 /* synthesis keep */;
   logic w2 /* synthesis keep */;
   logic w3 /* synthesis keep */;
   logic w4 /* synthesis keep */;
   logic w5 /* synthesis keep */;
   logic w6 /* synthesis keep */;
   logic w7 /* synthesis keep */;
   logic w8 /* synthesis keep */;
   logic w9 /* synthesis keep */;
   logic w10 /* synthesis keep */;
   logic w11 /* synthesis keep */;
   logic w12 /* synthesis keep */;
   logic w13 /* synthesis keep */;
   logic w14 /* synthesis keep */;
   logic w15 /* synthesis keep */;

  assign w15 = ~(enable & w14);
  assign w14 = ~ w13;             // w14 is the output we are interested in
  assign w13 = ~ w12;
  assign w12 = ~ w11;
  assign w11 = ~ w10;
  assign w10 = ~ w9;
  assign w9 = ~ w8;
  assign w8 = ~ w7;
  assign w7 = ~ w6;
  assign w6 = ~ w5;
  assign w5 = ~ w4;
  assign w4 = ~ w3;
  assign w3 = ~ w2;
  assign w2 = ~ w1;
  assign w1 = ~ w15;

  assign out = w14;

endmodule
