`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2024 17:55:59
// Design Name: 
// Module Name: spi_tb
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

module tb_spi;

    // Signals for master
    reg clk;
    reg rst;
    reg start;
    reg [7:0] master_data_in;
    wire sclk;
    wire mosi;
    wire ss;
    wire [7:0] master_data_out;
    wire master_done;
    

    // Signals for slave
    wire miso;
       reg [7:0] slave_data_in;
       wire [7:0] slave_data_out;


    // Instantiate SPI Master
    master ms(
        .clk(clk),
        .rst(rst),
        .datain(master_data_in),
        .start(start),
        .sclk(sclk),
        .mosi(mosi),
        .miso(miso),
        .cs(ss),
        .done(master_done),
        .o_dataout(master_data_out)
    );

    // Instantiate SPI Slave
     slave sl (
           .clk(clk),
           .rst(rst),
           .sclk(sclk),
           .mosi(mosi),
           .miso(miso),
           .cs(ss),
           .dataout(slave_data_out),
           .datain(slave_data_in)
       );
    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        start = 0;
        master_data_in = 8'hA5;
        slave_data_in=8'h5A;  // Example data to send from master
          // Example data to send from slave

        // Release reset
        #10 rst = 0;

        // Start SPI communication
        #10 start = 1;
        #10 start = 0;

        // Wait for SPI transaction to complete
        wait(master_done);

       
        #20;
        $finish;
    end
endmodule

