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
  reg [3:0] latch;  // holds valid button presses

  // strictly speaking, edge triggers for each button should be added, but meh...
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      latch <= P1;  // reset_n == 0: default pattern
    end else begin
      // Detect exactly one button high.
      case (btn)
        P1: latch <= P1;
        P2: latch <= P2;
        P3: latch <= P3;
        P4: latch <= P4;
        default:  /* btn == 0000 or not one-hot: latch unchanged */;
      endcase
    end
  end

  assign led = latch;
endmodule
