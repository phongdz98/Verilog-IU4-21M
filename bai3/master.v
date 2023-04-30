module master (
  input wire sclk_m,
  input wire reset,
  input wire [63:0] data_m,
  output wire cs,
  output wire mosi,
  input miso,
  output [6:0] counter
);
  reg data_mosi;
  reg [63:0] MOSI;
  reg [6:0] count;
  reg cs_l;
  reg [2:0] state;
  always @(posedge sclk_m or posedge reset) 
  if (reset) begin
    data_mosi  <= 64'b0;
    count <= 5'd0;
    cs_l  <= 1'b1;
    // data_mosi = 64'b0;
  end
  else begin
    case (state)
     0 :begin
      count <=0;
      cs_l<=1;
      state <= 1;   

     end 
      1 :begin
      cs_l <= 1'b0;
      data_mosi <= data_m[63-count];
      count <= count +1;
      state <= 2;

     end 
      2 :begin
        if (count > 64) state <=0;
        else state <=1;

      end
     
      default: 
      state <= 0;
    endcase
  end

// D ff
always @(posedge sclk_m) begin
  MOSI<=data_mosi;
end

assign cs = cs_l;
assign mosi = MOSI;
assign counter = count;

endmodule