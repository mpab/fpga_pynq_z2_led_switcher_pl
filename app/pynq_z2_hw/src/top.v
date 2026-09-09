`timescale 1ns / 1ps

module top(input [3:0] btn,
           output [3:0] led);
  // wiring
  assign led = btn;
endmodule
