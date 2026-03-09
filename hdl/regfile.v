module regfile(
    input   clk,
    input rst_n,
    input    we,//Write enable

    input[2:0] write_address,
    input[7:0] write_data,//Port de write din memoria mare
    input[7:0] write_data_alu,//port de write din alu
    input      sel_alu,

    input[2:0] read_addr1,
    input[2:0] read_addr2,

    output reg[7:0] out1,
    output reg[7:0] out2

);
//Regfile reprezinta memoria interna a procesorului
//Se pot extrage cate 2 valori pentru a intra in ALU
//Se poate scrie doar o valoare inapoi in memorie

reg[7:0] reg_file[7:0]; //Initializam 8 "casute" a cate 8 biti fiecare 8x8 (adresele sunt pe  3 3biti)
integer i;


always @(posedge clk or negedge rst_n)
if(~rst_n) for(i=0;i<8;i=i+1) reg_file[i] <= 'd0; else
case(sel_alu)
 1'b1: if(we) reg_file[write_address] <= write_data_alu;
 1'b0: if(we) reg_file[write_address] <= write_data;
endcase

 


assign out1 = reg_file[read_addr1];
assign out2 = reg_file[read_addr2];



endmodule