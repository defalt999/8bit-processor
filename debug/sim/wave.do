onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider <NULL>
add wave -noupdate /cpu/clk
add wave -noupdate /cpu/rst_n
add wave -noupdate -divider <NULL>
add wave -noupdate -divider -height 30 LOAD
add wave -noupdate -radix hexadecimal /cpu/instruction
add wave -noupdate -divider {MEMORY READ}
add wave -noupdate /cpu/mem_ce
add wave -noupdate /cpu/mem_we
add wave -noupdate -radix decimal /cpu/address_m
add wave -noupdate -radix decimal /cpu/memory_data
add wave -noupdate -divider -height 25 <NULL>
add wave -noupdate -divider {LOAD TO REGISTER}
add wave -noupdate /cpu/we
add wave -noupdate /cpu/address_r
add wave -noupdate -radix decimal /cpu/memory_data
add wave -noupdate -divider <NULL>
add wave -noupdate -divider -height 30 {LOAD DONE}
add wave -noupdate -divider OPERATION
add wave -noupdate -radix hexadecimal /cpu/instruction
add wave -noupdate -radix decimal /cpu/alu/data1
add wave -noupdate -radix decimal /cpu/alu/data2
add wave -noupdate /cpu/alu/select
add wave -noupdate -radix decimal /cpu/alu/out
add wave -noupdate -divider <NULL>
add wave -noupdate -divider -height 30 STORE
add wave -noupdate -radix hexadecimal /cpu/instruction
add wave -noupdate -divider {REGISTER READ}
add wave -noupdate /cpu/address_r
add wave -noupdate -radix decimal /cpu/reg_data
add wave -noupdate -divider -height 25 <NULL>
add wave -noupdate -divider {MEMORY STORE}
add wave -noupdate /cpu/mem_ce
add wave -noupdate /cpu/mem_we
add wave -noupdate -radix hexadecimal /cpu/instruction
add wave -noupdate -radix binary /cpu/address_m
add wave -noupdate -radix decimal /cpu/reg_data
add wave -noupdate -divider -height 30 {STORE DONE}
add wave -noupdate -divider <NULL>
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider -height 20 <NULL>
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 7} {92 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
configure wave -valuecolwidth 88
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {63 ps} {275 ps}
