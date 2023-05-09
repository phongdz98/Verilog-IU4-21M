module msb_8bit(
    input clk,
    input [7:0] input_num,
    output reg [3:0] output_pos
);

integer i;
integer flag ;
always @(posedge clk)begin
    flag = 0;
    output_pos = 4'd0;
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