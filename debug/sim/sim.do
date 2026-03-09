vlib work
vmap work work



vlog  ../hdl/ck_rst_tb.v
vlog  ../hdl/cpu.v
vlog  ../../hdl/alu.v
vlog  ../../hdl/regfile.v
vlog  ../../hdl/memorie_1rw.v
vlog  ../../hdl/control_unit.v



vsim  work.cpu
do wave.do

add log -r /*
run -all

