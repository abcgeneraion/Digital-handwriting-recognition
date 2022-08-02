onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib conv2_weight2_opt

do {wave.do}

view wave
view structure
view signals

do {conv2_weight2.udo}

run -all

quit -force
