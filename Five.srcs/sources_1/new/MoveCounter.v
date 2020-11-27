`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/23 17:11:23
// Design Name: 
// Module Name: MoveCounter
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


module MoveCounter(
    input CanAcrossScreen,
    input Reset,
    input Add,
    input Sub,
    input [3:0] Max,
    input [3:0] Min,
    output [3:0] Data,
    output IsMax,
    output IsMin
    );

reg [3:0] data = 0;

assign IsMax = isMax;
assign IsMin = isMin;
assign Data = data;

reg isMax, isMin;
always@(*)
begin
    isMax = data>=Max;  //比较器是否浪费资源了
    isMin = data<=Min;
end
/*
    这个地方会设计到以触发器简易复位机诸如
    always@( posedge Sub or posedge Reset)
    begin
        if(Reset || Q==9)
            Q=0;
    的RTL机制的探讨问题
*/
always@( posedge Sub or posedge Add or negedge Reset)
begin
    if(Reset)
        data = 4'd0;
    else if(IsMax & Add)
        data = CanAcrossScreen? Min:data;   //决定是否穿越屏幕
    else if(IsMin & Sub)
        data = CanAcrossScreen? Max:data;
    else if(Add)
        data = data + 1;    //即使Add和Sub理论上为窄脉冲不会同时触发
    else if(Sub)            //但值得注意的是Add的优先级更大
        data = data - 1;
    else
        data = data;
end

endmodule
