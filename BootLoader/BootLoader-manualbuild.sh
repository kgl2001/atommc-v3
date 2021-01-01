#!/bin/bash

#SET BIN=C:\UTILS
export MCC=/Applications/microchip/mplabc18/v3.47

rm -f *.cof
rm -f *.hex
rm -f *.lst
rm -rf  intermediate
mkdir intermediate
rm -rf bootloader-bin
mkdir bootloader-bin
./BootLoader-build2.sh 25
