`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 行列按键，只是用一行 消抖后得到20MS整数倍的按键波形，高有效
//LED显示对应按键，数码管显示LED值
//需要注意约束文件中将行作为输出，列作为输入，列必须下拉（没按时读到0）
//卢有亮 2018.06.18
//////////////////////////////////////////////////////////////////////////////////
//module v1(
//    input clk,
//    input [11:0] sw,
//    input [3:0] col,
//    output [3:0] row,
//    output [11:0] led,
//    input [15:0]key,
//    output [7:0] seg,
//    output [5:0] an, //LED位选,
//        output Hsync,
//    output Vsync,
//    output [3:0] vgaRed,
//    output [3:0] vgaGreen,
//    output [3:0] vgaBlue
//    );
// wire clk_ms,clk_20ms,clk_s;
// wire [15:0] btnout;
// assign btnout = key;

//ip_disp a(
//     .clk(clk),
//    .rst(0),
//    .dispdata(showdat),
//    .seg(seg),
//    .an(an)
//    );
// ClkDivision clkD1(
//    .clk_50M(clk),
//    .clk_ms(clk_ms),
//    .clk_20ms(clk_20ms),
//    .clk_s(clk_s)
//    );    //调用分频没模块

//ScanKey Sk1(//调用按键消抖动IP
//    .ScanClk(clk_ms),
//    .ReadClk(clk_20ms),
//    .Col(col),
//    .Row(row)
//    //,.KeyPressed(key)
// );
   
// endmodule