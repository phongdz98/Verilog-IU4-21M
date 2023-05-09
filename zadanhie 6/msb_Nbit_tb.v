`timescale 1ns/1ns
`include "msb_Nbit.v"
module msb_Nbit_tb();
reg clk=1;
initial
    forever 
        #5 clk = ~clk;
reg [63:0] input_num;
wire [7:0] output_pos;
parameter N =64;
msb_Nbit #(N) msb_Nbit (
    .input_num(input_num),
    .output_pos(output_pos),
    .clk(clk)
);

initial 
begin
    $dumpfile("dump_Nbit.vcd");
    $dumpvars(0,msb_Nbit_tb);
    
end;

initial begin
    #10
    input_num = 64'h0000000000003131;
    #20;
    input_num = 64'h3100000000003131;
    #20;
    input_num = 64'h0000000000000001;
    #20;
    $finish();
end

endmodule;