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
    output [7:0] Offset
    );
parameter Y = 14, X=1,Y15L=210;

reg [8:0] Offset = 0;

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


endmodule
