`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/23 17:11:23
// Design Name: 
// Module Name: OffsetCounter
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


module OffsetCounter(
    /*input CanAcrossScreen,
    input Reset,
    input Up,
    input Down,
    input Left,
    input Right,
    input IsMaxX,
    input IsMinX,
    input IsMaxY,
    input IsMinY,*/
    input [3:0]x,
    input [3:0]y,
    output reg [11:0] OffsetBcdDebug,
    output reg [15:0] Offset =0
    );

//parameter Y = 14, X=1,Y15L=210;
/*always@(posedge Up|Down|Left|Right or negedge Reset)
begin
    if( Reset )
        Offset = 0;
    else if( Up )
    begin
        if(IsMinY&CanAcrossScreen)
            Offset =Offset + Y15L;   
        else if(IsMinY&~CanAcrossScreen)
            Offset =Offset; 
        else
            Offset = Offset - Y;
    end
    
    else if( Down )
    begin
        if(IsMaxY&CanAcrossScreen)
            Offset =Offset - Y15L;   
        else if(IsMaxY&~CanAcrossScreen)
            Offset =Offset; 
        else
            Offset = Offset + Y;
    end
    
    else if( Left )
    begin
        if(IsMinX&CanAcrossScreen)
            Offset =Offset + Y;   
        else if(IsMinX&~CanAcrossScreen)
            Offset =Offset; 
        else
            Offset = Offset - 1;
    end
    
    else if( Right )
    begin
        if(IsMaxX&CanAcrossScreen)
            Offset =Offset - Y;   
        else if(IsMaxX&~CanAcrossScreen)
            Offset =Offset; 
        else
            Offset = Offset + 1;
    end
end*/

always@(*)
begin
    Offset = 16'd14*{12'd0,y}+{12'd0,x};    //如果写成 15*y+x会(x y无响应)
    //Offset <= Offset1 +y; //但是值得好奇的是 这个模块的代码没有理由会影响x 和y才对   

    OffsetBcdDebug[11:8] = Offset / 8'd100;
    OffsetBcdDebug[7:4] = Offset %8'd100 / 8'd10;
    OffsetBcdDebug[3:0] = Offset % 8'd10;
end

endmodule
