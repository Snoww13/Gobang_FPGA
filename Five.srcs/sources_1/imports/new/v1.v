`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ���а�����ֻ����һ�� ������õ�20MS�������İ������Σ�����Ч
//LED��ʾ��Ӧ�������������ʾLEDֵ
//��Ҫע��Լ���ļ��н�����Ϊ���������Ϊ���룬�б���������û��ʱ����0��
//¬���� 2018.06.18
//////////////////////////////////////////////////////////////////////////////////
//module v1(
//    input clk,
//    input [11:0] sw,
//    input [3:0] col,
//    output [3:0] row,
//    output [11:0] led,
//    input [15:0]key,
//    output [7:0] seg,
//    output [5:0] an, //LEDλѡ,
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
//    );    //���÷�Ƶûģ��

//ScanKey Sk1(//���ð���������IP
//    .ScanClk(clk_ms),
//    .ReadClk(clk_20ms),
//    .Col(col),
//    .Row(row)
//    //,.KeyPressed(key)
// );
   
// endmodule