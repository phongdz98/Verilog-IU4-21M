`timescale 1ns/1ns
`include "msb_32bit.v"
module msb_tb();

reg clk =1;
initial
    forever 
        #5 clk = ~clk;
reg [31:0] input_num;
wire [5:0] output_pos;

msb_32bit msb_32bit (
    .clk(clk),
    .input_num(input_num),
    .output_pos(output_pos)
);

initial 
begin
    $dumpfile("dump_32bit.vcd");
    $dumpvars(0,msb_tb);
    
end;

initial begin
    #10
    input_num = 32'h31003131;
    #20;
    input_num = 32'h00003131;
    #20;
    input_num = 32'h00000001;
    #20;
    $finish();
end

endmodule;