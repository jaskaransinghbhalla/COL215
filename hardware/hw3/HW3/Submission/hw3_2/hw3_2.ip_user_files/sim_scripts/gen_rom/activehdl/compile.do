transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {D:/col215/hw3_2/hw3_2.cache/compile_simlib/activehdl}
vlib activehdl/xil_defaultlib

vcom -work xil_defaultlib -93  \
"../../../../hw3_2.gen/sources_1/ip/gen_rom/gen_rom_sim_netlist.vhdl" \


