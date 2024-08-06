`timescale 1ns / 1ps

/*
* Company: Santa Clara University
* Engineer: Jonathan Trinh
*
* Create Date: 02/13/2020 10:26:48 PM
* Design Name:
* Module Name: puf_serial
* Project Name: Delay-based Physical Unclonable Function Implementation
* Target Devices: Digilent S7-25, S7-50 (Xilinx Spartan 7)
* Tool Versions:
* Description: Serialized PUF scheme. It takes in an 8-bit input, scrambles it giving
*              two random ring oscillators to compare outputting a bit. The bit is
*              stored into a buffer. When this is repeated 7 more times. An 8-bit
*              bus is ready to be read.
*
* Dependencies: scrambler_lfsr, ring_osc, mux_16to1, post_mux_counter, race_arbiter, smart_buffer
*
* Revision:
* Revision 0.01 - File Created
* Additional Comments:
*
*/

module puf_serial(
    output[7:0] response,
    output done,
    input [7:0] challenge,
    input [31:0] enable,
    input clock, reset
);

   logic out, bit_done, local_counter_reset, increment, arbiter_reset;
   logic [3:0] buffer_count;
   logic buffer_full, buffer_empty;
   logic [7:0] scrambler_out;
   logic [31:0] ro_out;
   logic first_mux_out, second_mux_out;
   logic fin1, fin2;
   logic [22:0] pmc1_out, pmc2_out;


   scrambler_lfsr scrambler (
    .challenge  (challenge),
    .scrambler_out (scrambler_out),
    .clock (clock),
    .reset (reset),
    .increment(increment));

   ring_osc first_ro[15:0] (
    .enable (enable[15:0]),
    .out (ro_out[15:0])); // An array of ring oscillators

   ring_osc second_ro[15:0] (
    .enable (enable[31:16]),
    .out (ro_out[31:16])); // An array of ring oscillators

   mux_16to1 first_mux (
    .in (ro_out[15:0]),
    .sel (scrambler_out[3:0]),
    .out (first_mux_out));

   mux_16to1 second_mux (
    .in (ro_out[31:16]),
    .sel (scrambler_out[7:4]),
    .out (second_mux_out));

   post_mux_counter pmc1 (
    .out (pmc1_out),
    .finished (fin1),
    .enable (enable[0]),
    .clk(first_mux_out),
    .reset (local_counter_reset));

   post_mux_counter pmc2 (
    .out (pmc2_out),
    .finished (fin2),
    .enable (enable[0]),
    .clk (second_mux_out),
    .reset (local_counter_reset));

   race_arbiter arb (
    .fin1 (fin1),
    .fin2 (fin2),
    .reset (arbiter_reset),
    .out (out),
    .done (bit_done));

   smart_buffer buff (
    .clock (clock),
    .dataIn (out),
    .bit_done (bit_done),
    .dataOut (response),
    .count (buffer_count),
    .full (buffer_full),
    .empty (buffer_empty),
    .computer_ack_reset (reset),
    .scrambler_reset (increment),
    .arbiter_reset (arbiter_reset),
    .counter_reset (local_counter_reset),
    .ready_to_read (done));

endmodule

