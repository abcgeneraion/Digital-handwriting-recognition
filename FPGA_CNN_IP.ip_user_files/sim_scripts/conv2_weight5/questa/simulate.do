onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib conv2_weight5_opt

do {wave.do}

view wave
view structure
view signals

do {conv2_weight5.udo}

run -all

quit -force
