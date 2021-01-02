#!/bin/bash


# OSX c18 compiler here:
# https://github.com/Manouchehri/Microchip-C18-Lite
# download, unpack, install to default location
# add path to compiler bin folder - Applications/microchip/mplabc18/v3.47/bin - to ~/.bashrc
# restart terminal or source ~/.bashrc
MCC=/Applications/microchip/mplabc18/v3.46
PART=18F4525

OUTFW=atommcv3


function compile {
  $MCC/bin/mcc18 -p=$PART -I"./" -I"$MCC/h" -pa=8 $1.c -fo=intermediate/$1.o  --extended -k -O-
  if [[ $? -ne 0 ]]; then
    echo '** compilation of $1.c failed.'
    exit 1
  fi
  export OBJS="$OBJS intermediate/$1.o"
}


function link {
  $MCC/bin/mplink -q $LKR -p$PART -k"." -l"." -l"$MCC/lib" $OBJS -u_CRUNTIME -u_EXTENDEDMODE -z__MPLAB_BUILD=1 -i -m"intermediate/$1.map" -w -o"intermediate/$1.cof"
  if [[ $? -ne 0 ]]; then
    echo '** linking of $NAME.hex failed.'
    exit 1
  fi
}


rm -rf intermediate
mkdir intermediate


buildnum=$(cat buildnumber.h | sed -n "s/^.*,\s*\(\S*\)/\1/p")
typeset -i ibn=$buildnum
ibn=$((ibn+1))
echo "#define BUILDNUMBER movff 0,$ibn" >buildnumber.h


#firmware build

OBJS=
LKR=18f4525_g-atommc.lkr

compile main-atommc
compile atmmccore
compile atmmcwfn
compile diskio
compile mmcio
compile ff
compile wildcard
link $OUTFW

ihexdump intermediate/$OUTFW.hex out=$OUTFW.bin lo=0x1000 > /dev/null
if [[ $? -ne 0 ]]; then
  echo '** binary conversion of $NAME.hex failed.'
  exit 1
fi


# bootloader build

OBJS=
LKR=18f4525_g-bootld.lkr

compile main-bootld
link $OUTFW-bl

mv intermediate/$OUTFW-bl.hex .


echo OK
exit 0
