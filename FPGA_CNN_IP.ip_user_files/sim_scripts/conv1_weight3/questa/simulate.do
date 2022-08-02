onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib conv1_weight3_opt

do {wave.do}

view wave
view structure
view signals

do {conv1_weight3.udo}

run -all

quit -force
