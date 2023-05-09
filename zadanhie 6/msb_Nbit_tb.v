`timescale 1ns/1ns
`include "msb_Nbit.v"
module msb_Nbit_tb();

reg [63:0] input_num;
wire [7:0] output_pos;
parameter N =64;
msb_Nbit #(N) msb_Nbit (
    .input_num(input_num),
    .output_pos(output_pos)
);

initial 
begin
    $dumpfile("dump_Nbit.vcd");
    $dumpvars(0,msb_Nbit_tb);
    
end;

initial begin
    input_num = 64'h4100000000003131;
    #10;
    $finish();
end

endmodule;