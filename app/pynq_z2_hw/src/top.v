// top.v
// Vivado HDL demo: latch single button presses.
// Four buttons select four options, indicated by the corresponding LED.
// The selected LED remains lit after the button is released.

module top (
    input clk,
    input reset_n,
    input [3:0] btn,
    output [3:0] led
);

  // one-hot button/LED patterns
  localparam P1 = 4'b0001;
  localparam P2 = 4'b0010;
  localparam P3 = 4'b0100;
  localparam P4 = 4'b1000;

  reg [3:0] latch = 0;  // last valid one-hot selection LED pattern
  reg [3:0] new_led = 0;  // current detected one-hot selection LED pattern
  reg       is_valid_input = 0;  // exactly one button pressed in this update

  // strictly speaking, edge triggers for each button should be added, but meh...
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      // active-low reset: reset_n == 0 clears the latch
      latch = P1;  // default pattern
    end else begin
      // Detect exactly one button high.
      is_valid_input = 0;
      new_led = 0;

      if (btn == P1) begin
        is_valid_input = 1;
        new_led = P1;
      end else if (btn == P2) begin
        is_valid_input = 1;
        new_led = P2;
      end else if (btn == P3) begin
        is_valid_input = 1;
        new_led = P3;
      end else if (btn == P4) begin
        is_valid_input = 1;
        new_led = P4;
      end

      if (is_valid_input) begin
        latch = new_led;  // latch current one-hot selection
      end
      // btn == 0000 release: press == 0, latch unchanged.
      // multiple buttons: press == 0, latch unchanged.
    end
  end

  assign led = latch;
endmodule
