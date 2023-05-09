`include "msb_8bit.v"

// b) вход N бита
module msb_Nbit 
#(parameter N =32) 
(
    input clk,
    input [N-1:0] input_num,
    output reg [7:0] output_pos
);

integer i;
genvar j;
integer flag;
wire [7:0] input_part [(N/8)-1:0];
wire [3:0] part_msb [(N/8)-1:0];

generate
    for (j = 0; j<N/8; j=j+1) begin
        assign input_part[j] = input_num[j*8+7:j*8];
        msb_8bit msb_8bit(.input_num(input_part[j]),.output_pos(part_msb[j]), .clk(clk));
    end   
endgenerate

always @(posedge clk)begin
    flag = 0;
    output_pos = 6'd0;
    i = N/8 - 1;
    while (i >= 0 && flag == 0) begin
        if(part_msb[i]!=4'b0) begin
            output_pos = (i*8) + part_msb[i];
            flag =1;
        end
        i = i-1;
    end
end

endmodule