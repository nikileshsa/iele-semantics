#!/bin/bash

TEST="$1"
VAL="$2"
VAL2="$3"
OP="$4"

sed 's/\$op/'"$OP"'/g' $TEST > $TEST.tmp
sed 's/\$val2/'"$VAL2"'/g' -i $TEST.tmp
sed 's/\$val/'"$VAL"'/g' -i $TEST.tmp

../../assemble-iele-test $TEST.json > tmp
../../kast-json.py tmp > asm
time ../../.build/standalone/ethereum-kompiled/interpreter ../../.build/standalone/ethereum-kompiled/realdef.cma -c PGM asm textfile -c SCHEDULE  '`DEFAULT_IELE-GAS`(.KList)' text -c MODE '`NORMAL`(.KList)' text --output-file tmp2
