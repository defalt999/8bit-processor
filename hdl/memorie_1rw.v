module memorie_1rw #(
    parameter ADDR_WIDTH = 8 ,
    parameter MEM_DEPTH = 256 , // MEM_DEPTH <= 2^ADDR_WIDTH
    parameter WORD_BYTES = 8 // latimea casutei 
)( //Memorie read-write cu 1 port 256 memorii a cate 8 biti fiecare

    input clk,
    input rst_n,

    input ce,//chip enable
    input we,//write enable

    input [ADDR_WIDTH-1:0] address,
    input [WORD_BYTES-1:0] write_data,
    
    output[WORD_BYTES-1:0] read_data
    
);

reg[WORD_BYTES-1:0] memory_file[MEM_DEPTH-1:0]; 
integer i;

always @(posedge clk or negedge rst_n)
if(~rst_n) for(i=0;i<MEM_DEPTH;i=i+1) memory_file[i] <= 'd0; else
if(ce & we) memory_file[address] <= write_data;  

assign read_data = ce ? memory_file[address] : 'd0;


 


endmodule