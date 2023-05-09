`timescale 1ns/1ns
`include "msb_32bit.v"
module msb_tb();

reg [31:0] input_num;
wire [5:0] output_pos;

msb_32bit msb_32bit (
    .input_num(input_num),
    .output_pos(output_pos)
);

initial 
begin
    $dumpfile("dump_32bit.vcd");
    $dumpvars(0,msb_tb);
    
end;

initial begin
    input_num = 32'h00003131;
    #10;
    $finish();
end

endmodule;