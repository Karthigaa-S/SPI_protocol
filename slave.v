`timescale 1ns/1ps
module slave(
input wire mosi,
input wire clk,
input wire rst,
input wire cs,
output reg miso,
input wire [7:0]datain,
output reg [7:0]dataout,
input wire sclk);
reg [2:0]
count=3'b0;
reg [7:0]o_dataout;
always @(posedge clk)
begin
if (rst==1)
begin
miso=0;
dataout=0;
o_dataout=0;
end
else
if(!cs)
begin
if (sclk)
begin
o_dataout<=datain;

end
end
else begin
miso<=o_dataout[7];
o_dataout<={o_dataout[6:0],miso};
end
dataout<=o_dataout;
end

endmodule



