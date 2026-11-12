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
  localparam BOFF = 4'b0000;
  localparam B1   = 4'b0001;
  localparam B2   = 4'b0010;
  localparam B3   = 4'b0100;
  localparam B4   = 4'b1000;

  // debounce 'queue'
  reg [3:0] btnq0;
  reg [3:0] btnq1;
  reg [3:0] btnq2;
  reg [3:0] btnq3;

  // last valid button press/current LED pattern
  reg [3:0] latch;
  assign led = latch;

  // crude debounce
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      btnq0 <= BOFF;
      btnq1 <= BOFF;
      btnq2 <= BOFF;
      btnq3 <= BOFF;
    end else begin
      btnq0 <= btnq1;
      btnq1 <= btnq2;
      btnq2 <= btnq3;
      btnq3 <= btn;
    end
  end

  // button press handler
  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      latch <= B1;  // reset_n == 0: default pattern
    end else begin
      // detect exactly one debounced button press and only react to changes
      if (btnq0 == btnq1 == btnq2 == btnq3) begin
        if ((btnq0 == B1) && (B1 != latch)) begin
          latch <= B1;
        end else if ((btnq0 == B2) && (B2 != latch)) begin
          latch <= B2;
        end else if ((btnq0 == B3) && (B3 != latch)) begin
          latch <= B3;
        end else if ((btnq0 == B4) && (B4 != latch)) begin
          latch <= B4;
        end
      end
    end
  end
endmodule
