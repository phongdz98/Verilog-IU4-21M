`timescale 1ns/1ns
`include "spi_slave.v"
`include "master.v"
module spi_slave_tb();

initial
    forever 
        #5 sclk_m = ~sclk_m;

reg unsigned [7:0] i;

//master
reg reset;
reg [63:0] data_m;
reg sclk_m=0;
reg miso;

wire cs;
wire mosi;
wire [6:0] counter;
// wire [63:0] data_mosi;

// slave
reg din;
wire sclk_s;
wire dout_sig;
wire [6:0] count_s;
wire [7:0] cmd;
wire [23:0] address;
wire [31:0] data;
wire read_en;
wire [31:0] data_miso;


master master(
  .sclk_m(sclk_m),
  .reset(reset),
  .counter(counter),
  .data_m(data_m),
  .cs(cs),
  .mosi(mosi),
  .miso(dout_sig)
);

spi_slave spi_slave_inst(
    .sclk_m(sclk_m),
    .cs(cs),
    .din(mosi),
    .sclk_s(sclk_s),
    .dout(dout_sig),
    .count_s(count_s),
    .cmd(cmd),
    .address(address),
    .data(data),
    .read_en(read_en),
    .data_miso(data_miso)
);

initial 
begin
    $dumpfile("dump.vcd");
    $dumpvars(0,spi_slave_tb);
    
end;


initial begin
    reset =1'b1;
    #10
    reset = 1'b0;
    #10 
    data_m = 64'h55123456E2345678;
    #1350
    reset =1'b1;
    #10
    reset = 1'b0;
    #10 
    data_m[63:56] = 8'h56;
    data_m[55:32] = 24'h121212;
    data_m[31:0] = 32'hxxxxxxxx ;
    #1350
    reset = 1'b1;
    #10
    reset = 1'b0;
    #10
    data_m = 64'h5512345612121212;
    #1350
    reset = 1'b1;
    #10
    $finish();
end

endmodule