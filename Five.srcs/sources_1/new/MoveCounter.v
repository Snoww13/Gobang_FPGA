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
    output [3:0] Data
    //output IsMax,
    //output IsMin
    );

reg [3:0] data = 0; //寄存器输出？
reg isMax, isMin;
//assign IsMax = isMax;
//assign IsMin = isMin;
assign Data = data;

always@(*)
begin
    isMax = data>=Max;  //比较器是否浪费资源了
    isMin = data<=Min;
end
/*
    TODO:这个地方会设计到以触发器简易复位机诸如
    always@( posedge Sub or posedge Reset)
    begin
        if(Reset || Q==9)
            Q=0;
    的RTL机制的探讨问题
*/
always@( posedge (Add|Sub) or negedge Reset)
begin
    if(Reset)
        data = 4'd0;
    else if(Add)
    begin
        if(isMax&CanAcrossScreen)
            data = Min;   //决定是否穿越屏幕
        else if(isMax&~CanAcrossScreen)
            data = Max;
        else
            data = data+1;
    end
        
    else if(Sub)        //即使Add和Sub理论上为窄脉冲不会同时触发
                        //但值得注意的是Add的优先级更大
    begin
        if(isMin&CanAcrossScreen)
            data = Max;
        else if(isMin&~CanAcrossScreen)
            data = Min;
        else
            data = data -1;
    end
    else
        data = data;
end

endmodule
