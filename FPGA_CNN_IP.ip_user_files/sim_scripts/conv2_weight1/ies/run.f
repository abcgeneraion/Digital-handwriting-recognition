-makelib ies_lib/xil_defaultlib -sv \
  "E:/vivado_tools/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "E:/vivado_tools/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_2 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../FPGA_CNN_IP.srcs/sources_1/ip/conv2_weight1/sim/conv2_weight1.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

