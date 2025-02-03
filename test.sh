#!/bin/bash

make clean && make
./rx-cc exmpales/example1.cmm
echo "output file:\n"
cat example1.rsk