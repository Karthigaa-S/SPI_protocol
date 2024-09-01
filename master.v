`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2024 16:30:51
// Design Name: 
// Module Name: master
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module master(input wire clk,
input wire rst,
output reg mosi,
input wire miso,
output reg sclk,
output reg cs,
input wire [7:0]datain,
output reg [7:0]o_dataout,
input wire start,
output reg done);
reg [1:0]state;
reg [7:0]dataout;
reg [2:0]count=3'b0;
parameter idle=2'b00;
parameter st=2'b01;
parameter transfer=2'b10;
parameter stop=2'b11;
always @(posedge clk)
begin
if(rst==1)
begin
cs=1;
done=0;
count=0;
o_dataout=0;
end
else
begin
case(state)
idle:
begin
cs=1;
done=0;
count=0;
if(start)
state<=st;
end
st:
begin
cs=0;
done=0;
sclk=0;
dataout<=datain;
state<=transfer;
end
transfer:
begin
sclk=~sclk;
if (sclk)
begin
mosi=dataout[7];
dataout={dataout[6:0],mosi};
count=count+1;
if(count>6) begin
mosi=dataout[7];
dataout={dataout[6:0],mosi};
state<=stop;
end
else
state<=transfer;
end
end
stop:begin
done=1;
cs=1;
o_dataout<=dataout;
count=0;

end
default:
state<=idle;
endcase
end
end
endmodule
