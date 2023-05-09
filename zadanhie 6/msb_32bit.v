`include "msb_8bit.v"

//a) вход 32 бита
module msb_32bit(
    input clk,
    input [31:0] input_num,
    output reg [5:0] output_pos
);

integer i;
integer flag ;
wire [7:0] input_part [3:0];
wire [3:0] part_msb [3:0];

assign input_part[0] = input_num[7:0];
assign input_part[1] = input_num[15:8];
assign input_part[2] = input_num[23:16];
assign input_part[3] = input_num[31:24];

msb_8bit msb_8bit_0(.input_num(input_part[0]),.output_pos(part_msb[0]), .clk(clk));
msb_8bit msb_8bit_1(.input_num(input_part[1]),.output_pos(part_msb[1]),.clk(clk));
msb_8bit msb_8bit_2(.input_num(input_part[2]),.output_pos(part_msb[2]),.clk(clk));
msb_8bit msb_8bit_3(.input_num(input_part[3]),.output_pos(part_msb[3]),.clk(clk));

always @(posedge clk)begin
    flag = 0;
    output_pos = 6'd0;
    i = 3;
    while (i >= 0 && flag == 0) begin
        if(part_msb[i]!=4'b0) begin
            output_pos = (i*8) + part_msb[i];
            flag =1;
        end
        i = i-1;

    end

end

endmodule
