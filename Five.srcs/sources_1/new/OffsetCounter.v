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
    input CanAcrossScreen,
    input Reset,
    input Up,
    input Down,
    input Left,
    input Right,
    input IsMaxX,
    input IsMinX,
    input IsMaxY,
    input IsMinY,
    output [11:0] OffsetBcdDebug,
    output reg [7:0] Offset =0
    );
parameter Y = 14, X=1,Y15L=210;

always@(posedge Up|Down|Left|Right or negedge Reset)
begin
    if( Reset )
        Offset = 0;
    else if( Up )
    begin
        if(CanAcrossScreen)
            Offset = IsMinY? Offset+Y15L:Offset-Y;
        else
            Offset = IsMinY? Offset:Offset-Y;
    end
    
    else if( Down )
    begin
        if(CanAcrossScreen)
            Offset = IsMaxY? Offset-Y15L:Offset+Y;
        else
            Offset = IsMaxY? Offset:Offset+Y;
    end
    
    else if( Left )
    begin
        if(CanAcrossScreen)
            Offset = IsMinX? Offset+Y:Offset-1;
        else
            Offset = IsMinX? Offset:Offset-1;
    end
    
    else if( Right )
    begin
        if(CanAcrossScreen)
            Offset = IsMaxX? Offset-Y:Offset+1;
        else
            Offset = IsMaxX? Offset:Offset+1;
    end

end

assign OffsetBcdDebug[11:8] = Offset / 8'd100;
assign OffsetBcdDebug[7:4] = Offset %8'd100 / 8'd10;
assign OffsetBcdDebug[3:0] = Offset % 8'd10;

endmodule
