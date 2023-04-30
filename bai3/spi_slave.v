module spi_slave (
    input sclk_m,
    input din, // MOSI
    input  cs,
    output wire sclk_s,
    output reg read_en, // read data in address memory
                        // transmit data from address memory to the master on MISO
    output reg  dout, // MISO
    output [6:0] count_s,
    output reg [7:0] cmd, //cmd for read , write: 8'h55 read: 8'h56
    output reg [23:0] address, // address memory in slave
    output reg [31:0] data,
    output reg [31:0] data_miso
);

reg [6:0] cnt=0;
reg [2:0] state;
reg [31:0] data_r = 32'h88888888; // data from "adress" memory

always@(posedge sclk_m or posedge cs)
begin
    if (cs) begin  
        read_en <=0;
        cnt<=0; 
        cmd<=8'h0;
        address<=24'h0;
        data<=32'h0;
        data_miso <= 32'h0;
        end
    else begin 
        case (state) 
        0:begin
            cnt <=0;
            read_en <=0;
            state <=1;
   
        end
        1: begin
            if (cnt <=7)begin 
                cmd[7-cnt] <= din;
            end
            else if (cnt >=8 && cnt <= 31) address[31-cnt] <= din;
            else if(cmd == 8'h55) data[63-cnt] <= din;
            if ( cmd == 8'h56) read_en<=1;
            if (read_en) begin
                dout<= data_r[63-cnt];
                data_miso[63-cnt] <= data_r[63-cnt];
            end
            state <=2;
            cnt <= cnt + 4'd1; 
        end
        2: begin
            if (cnt > 63)state <=0;
            else state <= 1;
        end
        default:
        state<=0;
        endcase
    end

end


assign count_s =cnt;
assign sclk_s = cs?1:sclk_m;

endmodule