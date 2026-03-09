module control_unit(
    input clk,
    input rst_n,

    input[31:0] instruction,

    output reg[7:0] address_m,//adresa memorie 
    output reg[2:0] address_r,//adresa registre interne

    output reg we,//Write enable pentru registre

    //Write si chip enable pentru memorie
    output reg mem_we,
    output reg mem_ce,

    //Alu
    output reg[2:0] source1,
    output reg[2:0] source2,
    output reg[2:0] select,
    output reg sel_alu

);

always @(posedge clk or negedge rst_n)
if(~rst_n) sel_alu <= 1'b0; else
case(instruction[31:24])
 8'h01, // ADD
 8'h02, // SUB
 8'h03, // AND
 8'h04, // OR
 8'h05, // SHIFR  //SHIFL
 8'h06:   sel_alu <= 1'b1;
 default: sel_alu <= 1'b0;

endcase

always @(posedge clk or negedge rst_n)
if(~rst_n) address_m <= 'd0 ; else
case(instruction[31:24])
 8'h10:   address_m <= instruction[15:8];
 8'h11:   address_m <= instruction[23:16]; 
 default: address_m <= 'd0;
endcase

always @(posedge clk or negedge rst_n)
if(~rst_n) address_r <= 'd0 ; else
case(instruction[31:24])
 8'h01, // ADD
 8'h02, // SUB
 8'h03, // AND
 8'h04, // OR
 8'h05, // SHIFR
 8'h06, //SHIFL
 8'h10:   address_r <= instruction[23:16];
 8'h11:   address_r <= instruction[15:8];
 default: address_r <= 'd0;
endcase

always @(posedge clk or negedge rst_n)
if(~rst_n) select <= 'd0; else
case(instruction[31:24])
 8'h01:   select <= 3'b001; //ADD
 8'h02:   select <= 3'b010; //SUB

 8'h03:   select <= 3'b100; //AND
 8'h04:   select <= 3'b101; //OR

 8'h05:   select <= 3'b110; //SHIFR
 8'h06:   select <= 3'b111; //SHIFL

 8'h10:   select <= 3'b000; // Load
 8'h11:   select <= 3'b000; // Store

 default: select <= 3'b000;
endcase





always @(posedge clk or negedge rst_n)
if(~rst_n)             source1 <=               'd0; else
if(instruction != 'd0) source1 <= instruction[15:8]; else
                       source1 <=               'd0;

always @(posedge clk or negedge rst_n)
if(~rst_n)             source2 <=              'd0; else
if(instruction != 'd0) source2 <= instruction[7:0]; else
                       source2 <=              'd0;

always @(posedge clk or negedge rst_n)
if(~rst_n) we <= 'd0; else
case(instruction[31:24])
 8'h01, // ADD
 8'h02, // SUB
 8'h03, // AND
 8'h04, // OR
 8'h05, // SHIFR
 8'h06,  // SHIFL
 8'h10:  //LOAD
          we <= 1'b1;

 8'h11:   we <= 1'b0; //Store
 default: we <= 1'b0;
endcase





always @(posedge clk or negedge rst_n)
if(~rst_n) mem_ce <= 'd0; else
case(instruction[31:24])
 8'h10,
 8'h11:   mem_ce <= 'd1;
 default: mem_ce <= 'd0;
endcase


always @(posedge clk or negedge rst_n)
if(~rst_n) mem_we <= 'd0; else
case(instruction[31:24])
 8'h11:    mem_we <= 'd1;
 default:  mem_we <= 'd0;
 
endcase


endmodule