`timescale 1ns / 1ps        //11 
//////////////////////////////////////////////////////////////////////////////////
// Module Name: ScanKey
// Description: 实现4行4列的键盘扫描，以获知哪些按键被按下，并做消抖处理。（支持最多16个按键同时按下）
//              本模块实现的功能是，按一下按键，按键值反转一次。
// 扫描原理：在时钟上升沿将某一根行线设为高电平，其他行线为低电平，在时钟下降沿读取所有列线电平，以获知该行中哪些按键被按下。
//           列线应在约束文件中配置为下拉模式，以确保没有按键按下的列线，读到的是低电平。
//           行扫描间隔为1ms，逐行依次扫描，故行扫描的触发时钟采用1KHz的输入时钟信号。
// 消抖原理：通常，按键的机械抖动时长不超过20ms，应间隔20ms读取列线电平，故读取列线的触发时钟采用50Hz的输入时钟信号。
//           如果连续两次读到的是先0后1，则认为按键刚刚被按下。
//           如果连续两次读到的都是1，则认为按键已经被按下。
//           如果连续两次读到的是先1后0，则认为按键刚刚弹起。
//           如果连续两次读到的都是0，则认为按键已经弹起。
//
// Dependencies: 此模块将被顶层模块Key&Display调用
// 
//////////////////////////////////////////////////////////////////////////////////

module ScanKey(
    input ScanClk,      //该输入端口为行扫描的触发时钟，采用DivClk模块产生的1KHz分频时钟信号
    input ReadClk,      //该输入端口为读取列线的触发时钟，采用DivClk模块产生的50Hz分频时钟信号
    input [3:0] Col,    //该输入端口为4x4矩阵键盘的列线，来自主调模块
    output reg [3:0] Row=4'b0001, //该输出端口为4x4矩阵键盘的行线，由于要在过程块中改变其值，故定义为寄存器型，即寄存器输出连接至输出端口，并赋初值
    output reg [15:0] KeyPressed=0   //该输出端口用于存储16个按键值，由于要在过程块中改变其值，故定义为寄存器型，即寄存器输出连接至输出端口，并赋初值0   
    );
    reg [15:0] KeyBufScan = 0;  //用于存储每次行扫描中读到的列线值，每行扫描存4个列线值，2行扫描共存8个列线值，3行扫描共存12个列线值，4行扫描共存16个列线值，即对应4行4列矩阵键盘的4个按键值
    reg [15:0] KeyBuf0 = 0;  //用于每隔20ms存储一次KeyBufScan的16个按键值
    reg [15:0] KeyBuf1 = 0;  //用于每隔20ms存储一次KeyBuf0的16个按键值，相当于移位寄存，使得KeyBuf1是20ms前KeyBuf0的值
    wire [15:0] KeyDown;     //定义一个线网型变量，使其在按键刚刚被按下时为1

    assign  KeyDown = ~KeyBuf1 & KeyBuf0;   //如果间隔20ms读取的按键值是先0后1，则认为按键刚刚被按下，同时避免了按键抖动的影响 
    
    always @ (negedge ReadClk)  //在ReadClk信号（周期20ms）的下降沿时刻执行该过程块，原因是在ReadClk上升沿时刻要读取按键值，可给KeyDown充足的电平转换时间
            //KeyPressed <= KeyPressed ^ KeyDown;     //将16个按键值与KeyDown按位异或，KeyDown为1时KeyPressed反转，即可实现按一下按键,按键值反转一次
            KeyPressed <= KeyDown;
    always @ (posedge ScanClk)  //在ScanClk信号（周期1ms）的上升沿时刻执行行扫描，每根行线交替置1
        begin
            if ( Row[3:0] == 4'b1000 )  
                Row[3:0] = 4'b0001;
            else
                Row[3:0] = Row[3:0]<<1; 
        end

    always @ (negedge ScanClk)  //在ScanClk信号（周期1ms）的下降沿时刻读取列线值，将每行读到的列线值分别存储，即得到4行4列矩阵键盘的16个按键值
        begin
            case (Row[3:0])
                4'b0001:  KeyBufScan[3:0] = Col;
                4'b0010:  KeyBufScan[7:4] = Col;
                4'b0100:  KeyBufScan[11:8] = Col;
                4'b1000: KeyBufScan[15:12] = Col;
            endcase
        end    
          
    always @ (posedge ReadClk)  //在ReadClk信号（周期20ms）的上升沿时刻将行扫描中存储在KeyBufScan的16个按键值，进行移位寄存，使得KeyBuf0和KeyBuf1的按键值相隔20ms
        begin            
            KeyBuf0 <= KeyBufScan;
            KeyBuf1 <= KeyBuf0;
        end       
endmodule