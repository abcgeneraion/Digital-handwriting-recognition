onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib image28x28_opt

do {wave.do}

view wave
view structure
view signals

do {image28x28.udo}

run -all

quit -force
