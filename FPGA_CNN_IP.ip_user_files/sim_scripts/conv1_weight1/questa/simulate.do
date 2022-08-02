onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib conv1_weight1_opt

do {wave.do}

view wave
view structure
view signals

do {conv1_weight1.udo}

run -all

quit -force
