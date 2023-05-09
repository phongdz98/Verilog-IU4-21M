module msb_32bit(
    input [31:0] input_num,
    output reg [5:0] output_pos
);

integer i;
integer flag =0;
wire [7:0] input_part [3:0];
wire [3:0] part_msb [3:0];

assign input_part[0] = input_num[7:0];
assign input_part[1] = input_num[15:8];
assign input_part[2] = input_num[23:16];
assign input_part[3] = input_num[31:24];

msb_8bit msb_8bit_0(.input_num(input_part[0]),.output_pos(part_msb[0]));
msb_8bit msb_8bit_1(.input_num(input_part[1]),.output_pos(part_msb[1]));
msb_8bit msb_8bit_2(.input_num(input_part[2]),.output_pos(part_msb[2]));
msb_8bit msb_8bit_3(.input_num(input_part[3]),.output_pos(part_msb[3]));

always @*begin

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
module msb_8bit(
    input [7:0] input_num,
    output reg [3:0] output_pos
);

integer i;
integer flag = 0;
always @*begin
    output_pos = 3'd0;
    i = 7;
    while (i >= 0 && flag == 0) begin
        if (input_num[i] == 1'b1) begin
            output_pos =  i +1;
            flag = 1;
        end 
        i = i - 1;
    end
end

endmodule;