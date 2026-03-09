module alu( 
    input          clk,
    input        rst_n,

    input [7:0]  data1,
    input [7:0]  data2,
    input [2:0] select,
    output reg[7:0]    out
);


parameter ADD = 3'b001; 
parameter SUB = 3'b010;

parameter AND = 3'b100; 
parameter  OR = 3'b101;

parameter SHIFR = 3'b110;
parameter SHIFL = 3'b111; 





always@(posedge clk or negedge rst_n)
if(~rst_n) out <= 'd0 ; else
case(select)
 ADD:      out <= data1+data2;
 SUB:      out <= data1-data2;
 
 AND:      out <= data1&data2;
  OR:      out <= data1|data2;
  
 SHIFR:    out <= data1 >> data2;
 SHIFL:    out <= data1 << data2;
 default:  out <= 'd0;


endcase




endmodule
