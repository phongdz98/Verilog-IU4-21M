integer i;
wire [7:0] input_part [3:0];
reg [3:0] part_msb [3:0];

assign input_part[0] = input_num[7:0];
assign input_part[1] = input_num[15:8];
assign input_part[2] = input_num[23:16];
assign input_part[3] = input_num[31:24];

always @* begin
    for (i = 0; i < 4; i = i + 1) begin
        part_msb[i] = get_msb(input_part[i]);
    end
end

function get_msb(input);
    input [7:0] input;
    integer j;
    for (j = 7; j >= 0; j = j - 1) begin
        if (input[j] == 1'b1) begin
            return j;
        end
    end
endfunction