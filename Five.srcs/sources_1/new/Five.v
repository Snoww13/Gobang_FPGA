`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/23 20:13:12
// Design Name: 
// Module Name: Five
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


module Five(
    input clk,
    input [11:0] sw,
    input [3:0] col,
    output [3:0] row,
    output [11:0] led,
    input [15:0]keyDebug,
    output [7:0] seg,
    output [5:0] an //LED位选,
//        ,output Hsync,
//    output Vsync,
//    output [3:0] vgaRed,
//    output [3:0] vgaGreen,
//    output [3:0] vgaBlue
    );

reg DEBUG = 0;

wire clk_ms,clk_20ms,clk_s;

wire[15:0] key;
wire [15:0] button;
assign button = DEBUG?keyDebug:key;

wire up = button[14];
wire down = button[6];
wire left = button[11];
wire right = button[9];

wire isMaxX,isMinX,isMaxY,isMinY;
wire [3:0] x,y;
wire [7:0] offset;
wire [11:0] offsetBcdDebug;


ip_disp dis1(
    .clk(clk),
    .rst(0),
    .dispdata({x[3:0],4'd0,offsetBcdDebug,y[3:0]}),
    .seg(seg),
    .an(an)
    );
 ClkDivision clkD1(
    .clk_50M(clk),
    .clk_ms(clk_ms),
    .clk_20ms(clk_20ms),
    .clk_s(clk_s)
    );    //调用分频模块

ScanKey Sk1(//调用按键消抖动IP
    .ScanClk(clk_ms),
    .ReadClk(clk_20ms),
    .Col(col),
    .Row(row)
    ,.KeyPressed(key)
 );

MoveCounter Xc1(
    .CanAcrossScreen( sw[0] ),
    .Reset( sw[2] ),
    .Add( down ),
    .Sub( up ),
    .Max( 4'd14 ),
    .Min( 4'd0 ),
    .Data( x ),
    .IsMax( isMaxX ),
    .IsMin( isMinX )
    );

MoveCounter Yc1(
    .CanAcrossScreen( sw[0] ),
    .Reset( sw[2] ),
    .Add( right ),
    .Sub( left ),
    .Max( 4'd14 ),
    .Min( 4'd0 ),
    .Data( y ),
    .IsMax( isMaxY ),
    .IsMin( isMinY )
    );

OffsetCounter Oc1(
    .CanAcrossScreen( sw[0] ),
    .Reset( sw[2] ),
    .Up( up ),
    .Down( down ),
    .Left( left ),
    .Right( right ),
    .IsMaxX( isMaxX ),
    .IsMinX( isMinX ),
    .IsMaxY( isMaxY ),
    .IsMinY( isMinY ),
    .OffsetBcdDebug(offsetBcdDebug),
    .Offset(offset)
    );

assign led[11]=isMinX;
assign led[10]=isMaxX;
assign led[9:6] = x[3:0];
assign led[5]=isMinY;
assign led[4]=isMaxY;
//assign led[3:0] = {up,down,left,right};
assign led[3:0] = y[3:0];
endmodule
