`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/19 17:14:24
// Design Name: 
// Module Name: ClkDivision
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
// 第一次编写: 杨汝贵 2019-12-19-17:23
//       内容: 端口1分频为 50M分频 端口2未定
//////////////////////////////////////////////////////////////////////////////////


module ClkDivision(
    input clk_50M,
    output reg clk_ms=0,
    output reg clk_20ms=0,
    output reg clk_s=0
    );
    
    reg [15:0] clk_i = 0;           //30位也许过大
    reg [20:0] clk_j = 0;
    
    always@ ( posedge clk_50M)
    begin 
       if(clk_i == 12499)    // 分频
       //if(clk_i == 1)    // 2分频便于仿真波形使用
        begin
            clk_ms = ~clk_ms;
            clk_i = 0;
        end
        else
            clk_i = clk_i + 1;
    end
    
    always @( posedge clk_50M)
    begin 
       if(clk_j == 499999)    // 
       //if(clk_j == 1)    // 2分频便于仿真波形使用
        begin
            clk_20ms = ~clk_20ms;
            clk_j = 0;
        end
        else
            clk_j = clk_j + 1;
    end
    reg [6:0]clk_k =0;
    always@( posedge clk_20ms)
    begin
      if(clk_k ==24)
      //if(clk_k==1)
        begin
            clk_s = ~clk_s;
            clk_k = 0;
        end
        else
            clk_k = clk_k+1;
    end
endmodule
