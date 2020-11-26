`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 12:46:07
// Design Name: 
// Module Name: Five_tb
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


module Five_tb(
    );

reg clk=0;
reg [11:0]sw=12'd1;
wire [15:0]key;

Five tb(
.clk(clk),
.sw(sw),
.keyDebug(key)
);

always
    # 1 clk=~clk;

reg up=0,down=0,left=0,right=0;
//assign key[14]=up;
//assign key[6]=down;
//assign  key[11]=left ;
//assign key[9] = right;
assign key = {1'b0,up,2'b0,left,1'b0,right,2'b0,down,6'b0};

initial
begin
#2 up =1;#1 up=0;
#2 down =1;#1 down=0;
#2 right =1;#1 right=0;
#2 $stop; left =1;#1 left=0;
#2 down =1;#1 down=0;
#2 down =1;#1 down=0;
#10 $finish;
end


endmodule
