#!/bin/bash

make clean && make
./rx-cc examples/example1.cmm
echo "output file:"
cat example1.rsk