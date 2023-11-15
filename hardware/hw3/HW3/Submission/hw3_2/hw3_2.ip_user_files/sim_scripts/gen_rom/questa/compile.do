vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vcom -work xil_defaultlib  -93  \
"../../../../hw3_2.gen/sources_1/ip/gen_rom/gen_rom_sim_netlist.vhdl" \


