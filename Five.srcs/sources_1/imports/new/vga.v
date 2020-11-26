`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/U/29 17:12:36
// Design Name: 
// Module Name: v1
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

module vga(
    input Clk,
    input [8:0]kong,
    input [8:0]bit,
    output Hsync,
    output Vsync,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue
    );                                                              
  parameter  
  L=440,R=950,U=50,D=560,   //�ֱ��Ӧ �� �� �� �� �ĸ��߽����ֵ
  b1h=210,l1h=220,  //��һ��������£�y������ֵ�����Ϊ��ֵ
  b2h=390,l2h=400,  //�ڶ���������£�y������ֵ�����Ϊ��ֵ
  b1v=600,l1v=610,  //��һ���������£�x������ֵ�����Ϊ��ֵ
  b2v=780,l2v=790,  //��һ���������£�x������ֵ�����Ϊ��ֵ
  ta=80,tb=b1h,tc=l2v,td=40, //
  te=1056,to=3,tp=21,tq=600,tr=1,ts=624;    //
  
        reg[10:0] x_counter=0;                           
        reg[10:0] y_counter=0;
        reg [2:0] colour;
        wire clk_vga;                            
   /*clk_wiz_0 uut_clk                          
     (
         .clk_in1(Clk),
          .clk_out1(clk_vga)
     );*/
      always @(posedge clk_vga) begin    
          begin
              if(x_counter==te-1)// 1055
              begin
                  x_counter = 0;     
                  if(y_counter == ts-1)
                      y_counter = 0;
                  else
                      y_counter = y_counter + 1;
              end
              else
              begin
                  x_counter = x_counter + 1;
              end
          end
      end   
//Ȧ����ʾ

//ʤ�����棿


     always @(x_counter or y_counter)                                         
      begin
          if ((x_counter<L)&(y_counter<U))  colour<=3'b000;//��ɫ��ɫ
          else if ((x_counter<b1v)&(y_counter<b1h)&(x_counter>L)&(y_counter>U))  //��һ������
          begin
          //��Ȧ���ж��������� 
            if(kong[8]&bit[8])
            begin
                if((((x_counter-(L+b1v)/2)*(x_counter-(L+b1v)/2)+(y_counter-(U+b1h)/2)*(y_counter-(U+b1h)/2))<3600)&(((x_counter-(L+b1v)/2)*(x_counter-(L+b1v)/2)+(y_counter-(U+b1h)/2)*(y_counter-(U+b1h)/2))>2500))
                    colour<=3'b111;//��(001)  circle
                else colour<=3'b011;//����Ϊ���ӵĵ�ɫ
            end
            else if(kong[8]&~bit[8])
            begin    
                //����
                  if (y_counter<((b1h+U)/2-60)) colour<=3'b011;
             else if (y_counter>((b1h+U)/2+60)) colour<=3'b011;
             else if (x_counter<((b1v+L)/2-60)) colour<=3'b011;
             else if (x_counter>((b1v+L)/2+60)) colour<=3'b011;
             else if ((y_counter>((b1h+U)/2-65))&(y_counter<((b1h+U)/2-5))&(y_counter<(x_counter+(((b1h+U)/2-5)-(b1v+L)/2)))&(y_counter<(((b1h+U)/2-5)+(b1v+L)/2-x_counter))) colour<=3'b011;
             else if ((y_counter>((b1h+U)/2+5))&(y_counter<((b1h+U)/2+65))&(y_counter>(x_counter+(((b1h+U)/2+5)-(b1v+L)/2)))&(y_counter>(((b1h+U)/2+5)+(b1v+L)/2-x_counter))) colour<=3'b011;
             else if  ((x_counter>(b1v+L)/2+5)&(x_counter<(b1v+L)/2+65)&(y_counter>(((b1v+L)/2+5)+(b1h+U)/2-x_counter))&(y_counter<(x_counter+(b1h+U)/2)-((b1v+L)/2+5)))  colour<=3'b011;
             else if ((x_counter>(b1v+L)/2-65)&(x_counter<(b1v+L)/2-5)&(y_counter>(x_counter+((b1h+U)/2-((b1v+L)/2-5))))&(y_counter<(((b1h+U)/2+(b1v+L)/2-5)-x_counter)))  colour<=3'b011;
             else    colour<=3'b111;//
             end
             else
               colour<=3'b011;
          end
          else if ((x_counter<b2v)&(y_counter<b1h)&(x_counter>l1v)&(y_counter>U))   //�ڶ�������
          // ��Ȧ
          begin
            if(kong[7]&bit[7])
                if((((x_counter-(l1v+b2v)/2)*(x_counter-(l1v+b2v)/2)+(y_counter-(U+b1h)/2)*(y_counter-(U+b1h)/2))<3600)&(((x_counter-(l1v+b2v)/2)*(x_counter-(l1v+b2v)/2)+(y_counter-(U+b1h)/2)*(y_counter-(U+b1h)/2))>2500))
                    colour<=3'b111;//��(001)  circle
                else colour<=3'b011;//����Ϊ���ӵĵ�ɫ
                
            else if(kong[7]&~bit[7])
            begin    
                //����
             if(y_counter<((b1h+U)/2-60)) colour<=3'b011;
             else if (y_counter>((b1h+U)/2+60)) colour<=3'b011;
             else if (x_counter<((b2v+l1v)/2-60)) colour<=3'b011;
             else if (x_counter>((b2v+l1v)/2+60)) colour<=3'b011;
             else if ((y_counter>((b1h+U)/2-65))&(y_counter<((b1h+U)/2-5))&(y_counter<(x_counter+(((b1h+U)/2-5)-(b2v+l1v)/2)))&(y_counter<(((b1h+U)/2-5)+(b2v+l1v)/2-x_counter))) colour<=3'b011;
             else if ((y_counter>((b1h+U)/2+5))&(y_counter<((b1h+U)/2+65))&(y_counter>(x_counter+(((b1h+U)/2+5)-(b2v+l1v)/2)))&(y_counter>(((b1h+U)/2+5)+(b2v+l1v)/2-x_counter))) colour<=3'b011;
             else if  ((x_counter>(b2v+l1v)/2+5)&(x_counter<(b2v+l1v)/2+65)&(y_counter>(((b2v+l1v)/2+5)+(b1h+U)/2-x_counter))&(y_counter<(x_counter+(b1h+U)/2)-((b2v+l1v)/2+5)))  colour<=3'b011;
             else if ((x_counter>(b2v+l1v)/2-65)&(x_counter<(b2v+l1v)/2-5)&(y_counter>(x_counter+((b1h+U)/2-((b2v+l1v)/2-5))))&(y_counter<(((b1h+U)/2+(b2v+l1v)/2-5)-x_counter)))  colour<=3'b011;
             else    colour<=3'b111;//
            end
            else
                colour<=3'b011;
            end
          else if ((x_counter<R)&(y_counter<b1h)&(x_counter>l2v)&(y_counter>U))   // colour<=3'b011;//����������
          //��Ȧ
          begin
            if(kong[6]&bit[6])
                if((((x_counter-(l2v+R)/2)*(x_counter-(l2v+R)/2)+(y_counter-(U+b1h)/2)*(y_counter-(U+b1h)/2))<3600)&(((x_counter-(l2v+R)/2)*(x_counter-(l2v+R)/2)+(y_counter-(U+b1h)/2)*(y_counter-(U+b1h)/2))>2500))
                    colour<=3'b111;//��(001)  circle
                else colour<=3'b011;//����Ϊ���ӵĵ�ɫ
          
            else if(kong[6]&~bit[6])
            begin
            //����
             if(y_counter<((b1h+U)/2-60)) colour<=3'b011;
             else if (y_counter>((b1h+U)/2+60)) colour<=3'b011;
             else if (x_counter<((R+l2v)/2-60)) colour<=3'b011;
             else if (x_counter>((R+l2v)/2+60)) colour<=3'b011;
             else if ((y_counter>((b1h+U)/2-65))&(y_counter<((b1h+U)/2-5))&(y_counter<(x_counter+(((b1h+U)/2-5)-(R+l2v)/2)))&(y_counter<(((b1h+U)/2-5)+(R+l2v)/2-x_counter))) colour<=3'b011;
             else if ((y_counter>((b1h+U)/2+5))&(y_counter<((b1h+U)/2+65))&(y_counter>(x_counter+(((b1h+U)/2+5)-(R+l2v)/2)))&(y_counter>(((b1h+U)/2+5)+(R+l2v)/2-x_counter))) colour<=3'b011;
             else if  ((x_counter>(R+l2v)/2+5)&(x_counter<(R+l2v)/2+65)&(y_counter>(((R+l2v)/2+5)+(b1h+U)/2-x_counter))&(y_counter<(x_counter+(b1h+U)/2)-((R+l2v)/2+5)))  colour<=3'b011;
             else if ((x_counter>(R+l2v)/2-65)&(x_counter<(R+l2v)/2-5)&(y_counter>(x_counter+((b1h+U)/2-((R+l2v)/2-5))))&(y_counter<(((b1h+U)/2+(R+l2v)/2-5)-x_counter)))  colour<=3'b011;
             else    colour<=3'b111;//
             end
                else
                  colour<=3'b011;
          end
          
          else if ((x_counter<b1v)&(y_counter<b2h)&(x_counter>L)&(y_counter>l1h))    //colour<=3'b011;//���ĸ�����
          //��Ȧ
          begin
           if(kong[5]&bit[5])
                if((((x_counter-(L+b1v)/2)*(x_counter-(L+b1v)/2)+(y_counter-(l1h+b2h)/2)*(y_counter-(l1h+b2h)/2))<3600)&(((x_counter-(L+b1v)/2)*(x_counter-(L+b1v)/2)+(y_counter-(l1h+b2h)/2)*(y_counter-(l1h+b2h)/2))>2500))
                    colour<=3'b111;//��(001)  circle
                else colour<=3'b011;//����Ϊ���ӵĵ�ɫ
          else if(kong[5]&~bit[5])
          begin
          //����
             if (y_counter<((b2h+l1h)/2-60)) colour<=3'b011;
             else if (y_counter>((b2h+l1h)/2+60)) colour<=3'b011;
             else if (x_counter<((b1v+L)/2-60)) colour<=3'b011;
             else if (x_counter>((b1v+L)/2+60)) colour<=3'b011;
             else if ((y_counter>((b2h+l1h)/2-65))&(y_counter<((b2h+l1h)/2-5))&(y_counter<(x_counter+(((b2h+l1h)/2-5)-(b1v+L)/2)))&(y_counter<(((b2h+l1h)/2-5)+(b1v+L)/2-x_counter))) colour<=3'b011;
             else if ((y_counter>((b2h+l1h)/2+5))&(y_counter<((b2h+l1h)/2+65))&(y_counter>(x_counter+(((b2h+l1h)/2+5)-(b1v+L)/2)))&(y_counter>(((b2h+l1h)/2+5)+(b1v+L)/2-x_counter))) colour<=3'b011;
             else if  ((x_counter>(b1v+L)/2+5)&(x_counter<(b1v+L)/2+65)&(y_counter>(((b1v+L)/2+5)+(b2h+l1h)/2-x_counter))&(y_counter<(x_counter+(b2h+l1h)/2)-((b1v+L)/2+5)))  colour<=3'b011;
             else if ((x_counter>(b1v+L)/2-65)&(x_counter<(b1v+L)/2-5)&(y_counter>(x_counter+((b2h+l1h)/2-((b1v+L)/2-5))))&(y_counter<(((b2h+l1h)/2+(b1v+L)/2-5)-x_counter)))  colour<=3'b011;
             else    colour<=3'b111;//
             end
            else    colour<=3'b011;//
          end
          else if ((x_counter<b2v)&(y_counter<b2h)&(x_counter>l1v)&(y_counter>l1h))   // colour<=3'b011;//���������
                // ��Ȧ
          begin
            if(kong[4]&bit[4])
                if((((x_counter-(l1v+b2v)/2)*(x_counter-(l1v+b2v)/2)+(y_counter-(l1h+b2h)/2)*(y_counter-(l1h+b2h)/2))<3600)&(((x_counter-(l1v+b2v)/2)*(x_counter-(l1v+b2v)/2)+(y_counter-(l1h+b2h)/2)*(y_counter-(l1h+b2h)/2))>2500))
                   colour<=3'b111;//��(001)  circle
                else colour<=3'b011;//����Ϊ���ӵĵ�ɫ
             else if(kong[4]&~bit[4])
             begin   
                //  X
                  if (y_counter<((b2h+l1h)/2-60)) colour<=3'b011;
             else if (y_counter>((b2h+l1h)/2+60)) colour<=3'b011;
             else if (x_counter<((b2v+l1v)/2-60)) colour<=3'b011;
             else if (x_counter>((b2v+l1v)/2+60)) colour<=3'b011;
             else if ((y_counter>((b2h+l1h)/2-65))&(y_counter<((b2h+l1h)/2-5))&(y_counter<(x_counter+(((b2h+l1h)/2-5)-(b2v+l1v)/2)))&(y_counter<(((b2h+l1h)/2-5)+(b2v+l1v)/2-x_counter))) colour<=3'b011;
             else if ((y_counter>((b2h+l1h)/2+5))&(y_counter<((b2h+l1h)/2+65))&(y_counter>(x_counter+(((b2h+l1h)/2+5)-(b2v+l1v)/2)))&(y_counter>(((b2h+l1h)/2+5)+(b2v+l1v)/2-x_counter))) colour<=3'b011;
             else if  ((x_counter>(b2v+l1v)/2+5)&(x_counter<(b2v+l1v)/2+65)&(y_counter>(((b2v+l1v)/2+5)+(b2h+l1h)/2-x_counter))&(y_counter<(x_counter+(b2h+l1h)/2)-((b2v+l1v)/2+5)))  colour<=3'b011;
             else if ((x_counter>(b2v+l1v)/2-65)&(x_counter<(b2v+l1v)/2-5)&(y_counter>(x_counter+((b2h+l1h)/2-((b2v+l1v)/2-5))))&(y_counter<(((b2h+l1h)/2+(b2v+l1v)/2-5)-x_counter)))  colour<=3'b011;
             else    colour<=3'b111;//
             end
             else    colour<=3'b011;//
           end
          else if ((x_counter<R)&(y_counter<b2h)&(x_counter>l2v)&(y_counter>l1h))  //  colour<=3'b011;//����������
          begin
          if(kong[3]&bit[3])
          //��Ȧ
          
                if((((x_counter-(l2v+R)/2)*(x_counter-(l2v+R)/2)+(y_counter-(l1h+b2h)/2)*(y_counter-(l1h+b2h)/2))<3600)&(((x_counter-(l2v+R)/2)*(x_counter-(l2v+R)/2)+(y_counter-(l1h+b2h)/2)*(y_counter-(l1h+b2h)/2))>2500))
                    colour<=3'b111;//��(001)  circle
                else colour<=3'b011;//����Ϊ���ӵĵ�ɫ
                
             else if(kong[3]&~bit[3])
             begin    
            //����
             if(y_counter<((b2h+l1h)/2-60)) colour<=3'b011;
             else if (y_counter>((b2h+l1h)/2+60)) colour<=3'b011;
             else if (x_counter<((R+l2v)/2-60)) colour<=3'b011;
             else if (x_counter>((R+l2v)/2+60)) colour<=3'b011;
             else if ((y_counter>((b2h+l1h)/2-65))&(y_counter<((b2h+l1h)/2-5))&(y_counter<(x_counter+(((b2h+l1h)/2-5)-(R+l2v)/2)))&(y_counter<(((b2h+l1h)/2-5)+(R+l2v)/2-x_counter))) colour<=3'b011;
             else if ((y_counter>((b2h+l1h)/2+5))&(y_counter<((b2h+l1h)/2+65))&(y_counter>(x_counter+(((b2h+l1h)/2+5)-(R+l2v)/2)))&(y_counter>(((b2h+l1h)/2+5)+(R+l2v)/2-x_counter))) colour<=3'b011;
             else if  ((x_counter>(R+l2v)/2+5)&(x_counter<(R+l2v)/2+65)&(y_counter>(((R+l2v)/2+5)+(b2h+l1h)/2-x_counter))&(y_counter<(x_counter+(b2h+l1h)/2)-((R+l2v)/2+5)))  colour<=3'b011;
             else if ((x_counter>(R+l2v)/2-65)&(x_counter<(R+l2v)/2-5)&(y_counter>(x_counter+((b2h+l1h)/2-((R+l2v)/2-5))))&(y_counter<(((b2h+l1h)/2+(R+l2v)/2-5)-x_counter)))  colour<=3'b011;
             else    colour<=3'b111;//
             end
           else    colour<=3'b011;//
           end  
          else if ((x_counter<b1v)&(y_counter<D)&(x_counter>L)&(y_counter>l2h))   // colour<=3'b011;//���߸�����
          begin
          if(kong[2]&bit[2])
          //��Ȧ
                if((((x_counter-(L+b1v)/2)*(x_counter-(L+b1v)/2)+(y_counter-(l2h+D)/2)*(y_counter-(l2h+D)/2))<3600)&(((x_counter-(L+b1v)/2)*(x_counter-(L+b1v)/2)+(y_counter-(l2h+D)/2)*(y_counter-(l2h+D)/2))>2500))
                    colour<=3'b111;//��(001)  circle
                else colour<=3'b011;//����Ϊ���ӵĵ�ɫ
          else if(kong[2]&~bit[2])
          begin
          //����
                  if (y_counter<((D+l2h)/2-60)) colour<=3'b011;
             else if (y_counter>((D+l2h)/2+60)) colour<=3'b011;
             else if (x_counter<((b1v+L)/2-60)) colour<=3'b011;
             else if (x_counter>((b1v+L)/2+60)) colour<=3'b011;
             else if ((y_counter>((D+l2h)/2-65))&(y_counter<((D+l2h)/2-5))&(y_counter<(x_counter+(((D+l2h)/2-5)-(b1v+L)/2)))&(y_counter<(((D+l2h)/2-5)+(b1v+L)/2-x_counter))) colour<=3'b011;
             else if ((y_counter>((D+l2h)/2+5))&(y_counter<((D+l2h)/2+65))&(y_counter>(x_counter+(((D+l2h)/2+5)-(b1v+L)/2)))&(y_counter>(((D+l2h)/2+5)+(b1v+L)/2-x_counter))) colour<=3'b011;
             else if  ((x_counter>(b1v+L)/2+5)&(x_counter<(b1v+L)/2+65)&(y_counter>(((b1v+L)/2+5)+(D+l2h)/2-x_counter))&(y_counter<(x_counter+(D+l2h)/2)-((b1v+L)/2+5)))  colour<=3'b011;
             else if ((x_counter>(b1v+L)/2-65)&(x_counter<(b1v+L)/2-5)&(y_counter>(x_counter+((D+l2h)/2-((b1v+L)/2-5))))&(y_counter<(((D+l2h)/2+(b1v+L)/2-5)-x_counter)))  colour<=3'b011;
             else    colour<=3'b111;//
             end
             else colour<=3'b011;
          end
          else if ((x_counter<b2v)&(y_counter<D)&(x_counter>l1v)&(y_counter>l2h))  //  colour<=3'b011;//�ڰ˸�����
          begin
            if(kong[1]&bit[1]) 
          //��Ȧ
                if((((x_counter-(l1v+b2v)/2)*(x_counter-(l1v+b2v)/2)+(y_counter-(l2h+D)/2)*(y_counter-(l2h+D)/2))<3600)&(((x_counter-(l1v+b2v)/2)*(x_counter-(l1v+b2v)/2)+(y_counter-(l2h+D)/2)*(y_counter-(l2h+D)/2))>2500))
                    colour<=3'b111;//��(001)  circle
                else colour<=3'b011;//����Ϊ���ӵĵ�ɫ
                
              else if(kong[1]&~bit[1]) 
              begin 
                 //  X
                if(y_counter<((D+l2h)/2-60)) colour<=3'b011;
             else if (y_counter>((D+l2h)/2+60)) colour<=3'b011;
             else if (x_counter<((b2v+l1v)/2-60)) colour<=3'b011;
             else if (x_counter>((b2v+l1v)/2+60)) colour<=3'b011;
             else if ((y_counter>((D+l2h)/2-65))&(y_counter<((D+l2h)/2-5))&(y_counter<(x_counter+(((D+l2h)/2-5)-(b2v+l1v)/2)))&(y_counter<(((D+l2h)/2-5)+(b2v+l1v)/2-x_counter))) colour<=3'b011;
             else if ((y_counter>((D+l2h)/2+5))&(y_counter<((D+l2h)/2+65))&(y_counter>(x_counter+(((D+l2h)/2+5)-(b2v+l1v)/2)))&(y_counter>(((D+l2h)/2+5)+(b2v+l1v)/2-x_counter))) colour<=3'b011;
             else if  ((x_counter>(b2v+l1v)/2+5)&(x_counter<(b2v+l1v)/2+65)&(y_counter>(((b2v+l1v)/2+5)+(D+l2h)/2-x_counter))&(y_counter<(x_counter+(D+l2h)/2)-((b2v+l1v)/2+5)))  colour<=3'b011;
             else if ((x_counter>(b2v+l1v)/2-65)&(x_counter<(b2v+l1v)/2-5)&(y_counter>(x_counter+((D+l2h)/2-((b2v+l1v)/2-5))))&(y_counter<(((D+l2h)/2+(b2v+l1v)/2-5)-x_counter)))  colour<=3'b011;
             else    colour<=3'b111;//
             end
           else    colour<=3'b011;//
          end
          else if ((x_counter<R)&(y_counter<D)&(x_counter>l2v)&(y_counter>l2h))   // colour<=3'b011;//�ھŸ�����
          //��Ȧ
          begin
            if(kong[0]&bit[0])
                if((((x_counter-(l2v+R)/2)*(x_counter-(l2v+R)/2)+(y_counter-(l2h+D)/2)*(y_counter-(l2h+D)/2))<3600)&(((x_counter-(l2v+R)/2)*(x_counter-(l2v+R)/2)+(y_counter-(l2h+D)/2)*(y_counter-(l2h+D)/2))>2500))
                    colour<=3'b111;//��(001)  circle
                else colour<=3'b011;//����Ϊ���ӵĵ�ɫ
                
           else if(kong[0]&~bit[0])  
           begin   
                //����
             if(y_counter<((D+l2h)/2-60)) colour<=3'b011;
             else if (y_counter>((D+l2h)/2+60)) colour<=3'b011;
             else if (x_counter<((R+l2v)/2-60)) colour<=3'b011;
             else if (x_counter>((R+l2v)/2+60)) colour<=3'b011;
             else if ((y_counter>((D+l2h)/2-65))&(y_counter<((D+l2h)/2-5))&(y_counter<(x_counter+(((D+l2h)/2-5)-(R+l2v)/2)))&(y_counter<(((D+l2h)/2-5)+(R+l2v)/2-x_counter))) colour<=3'b011;
             else if ((y_counter>((D+l2h)/2+5))&(y_counter<((D+l2h)/2+65))&(y_counter>(x_counter+(((D+l2h)/2+5)-(R+l2v)/2)))&(y_counter>(((D+l2h)/2+5)+(R+l2v)/2-x_counter))) colour<=3'b011;
             else if  ((x_counter>(R+l2v)/2+5)&(x_counter<(R+l2v)/2+65)&(y_counter>(((R+l2v)/2+5)+(D+l2h)/2-x_counter))&(y_counter<(x_counter+(D+l2h)/2)-((R+l2v)/2+5)))  colour<=3'b011;
             else if ((x_counter>(R+l2v)/2-65)&(x_counter<(R+l2v)/2-5)&(y_counter>(x_counter+((D+l2h)/2-((R+l2v)/2-5))))&(y_counter<(((D+l2h)/2+(R+l2v)/2-5)-x_counter)))  colour<=3'b011;
             else    colour<=3'b111;//
             end
            else    colour<=3'b011;//
           end     
          else if ((y_counter<l1h)&(y_counter>b1h)&(x_counter>L)&(x_counter<R))    colour<=3'b000;//����Ϊ�ָ���
          else if ((y_counter<l2h)&(y_counter>b2h)&(x_counter>L)&(x_counter<R))    colour<=3'b000;//
          else if ((x_counter<l1v)&(x_counter>b1v)&(y_counter>U)&(y_counter<D))    colour<=3'b000;//
          else if ((x_counter<l2v)&(x_counter>b2v)&(y_counter>U)&(y_counter<D))    colour<=3'b000;//

            //  else if (x_counter<L)    colour<=3'b010; //��
            //  else if (x_counter<540)    colour<=3'b011; //��
            //  else if (x_counter<640)   colour<=3'b100;  //��
            //  else if (x_counter<740)    colour<=3'b101;  //��
            //  else if (x_counter<840)    colour<=3'b110;  //��
            //  else if (x_counter<940)    colour<=3'b111;   //��
              else   colour<=3'b000 ; //��000
          end    
      assign  vgaRed={4{colour[2]}};                                          
      assign  vgaGreen={4{colour[1]}};
      assign  vgaBlue={4{colour[0]}};
      assign Hsync = !(x_counter < ta);                                      
      assign Vsync = !(y_counter < to);   
endmodule   
