module cpu(
    // input clk,
    // input rst_n
    // input[31:0] instruction
);

ck_rst_tb #(
    .CK_SEMIPERIOD ('d10)
) i_ck_rst_tb (
    .clk    (clk   ),
    .rst_n  (rst_n )
);

reg[31:0] instruction;
wire[2:0] address_r;
wire[7:0] address_m;

wire mem_we;
wire mem_ce;

wire we;

wire[7:0] memory_data;
wire[7:0] reg_data;
wire[7:0] reg_data2;


wire[2:0] source1;
wire[2:0] source2;
wire[2:0] select;

wire[7:0] alu_out;
wire sel_alu;



control_unit control_unit(
    .clk(clk),
    .rst_n(rst_n),
    .instruction(instruction),

    //LOAD/STORE
    .address_r(address_r),
    .address_m(address_m),
    .we(we),
    .mem_ce(mem_ce),
    .mem_we(mem_we),

    .source1(source1),
    .source2(source2),
    .select(select),
    .sel_alu(sel_alu)



  

);

memorie_1rw memory(
    .clk(clk),
    .rst_n(rst_n),

    .ce(mem_ce),
    .we(mem_we),
    .address(address_m),
    .read_data(memory_data),
    .write_data(reg_data)
);

wire check = (instruction[27:24] == 4'h1) ? 1 : 0;
wire[2:0] address1= check ? address_r : source1;
regfile registre(

    .clk(clk),
    .rst_n(rst_n),

   
    .we(we),
    .write_data(memory_data),
    .write_data_alu(alu_out),
    .sel_alu(sel_alu),
    .write_address(address_r),
    .read_addr1(address1),//Source1
    .read_addr2(source2),
    .out1(reg_data),
    .out2(reg_data2)

);


alu alu(
    .clk(clk),
    .rst_n(rst_n),
    .data1(reg_data),
    .data2(reg_data2),
    .select(select),
    .out(alu_out)
);


initial begin
    @(posedge rst_n);
    memory.memory_file[10]=8'd12; //Incarcare artificiala a memoriei si a registriloc cu niste valori pt testare
    registre.reg_file[4]=8'd15;
    registre.reg_file[5]=8'd9;
    repeat(2) @(posedge clk);
    instruction ={8'h10,8'd1,8'd10,8'd0};//Load in regfile1 din memory10
    @(posedge clk);
    instruction = 'd0;
    repeat(3) @(posedge clk);
    instruction={8'h11,8'd100,8'd1,8'd0};//Store din regfile1 in memory100
    @(posedge clk);
    instruction= 'd0;
    repeat(2) @(posedge clk);
    instruction={8'h02,8'd7,8'd4,8'd5};//Scadere din register 4 si 5 in 7
    repeat(2) @(posedge clk);
    instruction= 'd0;
    repeat(5) @(posedge clk);
    instruction={8'h11,8'd69,8'd7,8'd0};
    @(posedge clk);
    instruction='d0;

    $stop;
end

endmodule