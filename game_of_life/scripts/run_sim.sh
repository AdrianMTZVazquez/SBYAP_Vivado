#!/bin/bash
# Simula los testbenches del Juego de la Vida con xsim, sin abrir Vivado.
#   tb_tmds_encoder : decodifica los simbolos TMDS y revisa el balance DC
#   tb_life_core    : 100 generaciones desde el patron y 100 desde un llenado
#                     aleatorio, comparadas contra check_life.py
# Uso: ./run_sim.sh   (los archivos de simulacion quedan en scripts/sim_out/)
set -e

XILINX_SETTINGS=${XILINX_SETTINGS:-/opt/Xilinx/2026.1/Vivado/settings64.sh}
source "$XILINX_SETTINGS" > /dev/null

HERE=$(cd "$(dirname "$0")" && pwd)
SRCS="$HERE/../game_of_life.srcs"
OUT="$HERE/sim_out"
mkdir -p "$OUT" && cd "$OUT"

xvhdl "$SRCS"/sources_1/new/life_core.vhd \
      "$SRCS"/sources_1/new/tmds_encoder.vhd \
      "$SRCS"/sim_1/new/tb_life_core.vhd \
      "$SRCS"/sim_1/new/tb_tmds_encoder.vhd > /dev/null

xelab -debug off tb_tmds_encoder -s tmds_sim > /dev/null
xsim tmds_sim -R | grep -E 'Note|Error|Failure'

xelab -debug off tb_life_core -s life_sim > /dev/null
xsim life_sim -R | grep -E 'Note|Error|Failure'
python3 "$HERE/check_life.py" life_dump.txt 100
