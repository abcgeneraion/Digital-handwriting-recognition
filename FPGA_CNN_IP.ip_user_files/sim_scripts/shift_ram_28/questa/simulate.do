onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib shift_ram_28_opt

do {wave.do}

view wave
view structure
view signals

do {shift_ram_28.udo}

run -all

quit -force
