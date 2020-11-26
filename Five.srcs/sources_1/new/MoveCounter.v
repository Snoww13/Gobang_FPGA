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

assign IsMax = data == Max; // >= or == or ^~(同或)
assign IsMin = data == Min;
//always@( posedge Add|Sub|Reset )    //
always@( posedge Sub|Add or negedge Reset)
begin
    if(Reset)
        data = 0;
    else if( Add & ~IsMax)
        data = data + 1;
    else if( Sub & ~IsMin)
        data = data - 1;

    else if(Add & IsMax)
        data = CanAcrossScreen? Min:data;
    else if(Sub & IsMin)
        data = CanAcrossScreen? Max:data;
    else
        data = data;

end

endmodule
