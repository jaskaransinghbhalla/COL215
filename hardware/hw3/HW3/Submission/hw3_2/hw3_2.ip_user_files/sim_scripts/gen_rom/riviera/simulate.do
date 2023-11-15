transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+gen_rom  -L xil_defaultlib -L secureip -O5 xil_defaultlib.gen_rom

do {gen_rom.udo}

run 1000ns

endsim

quit -force
