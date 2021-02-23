#! /bin/bash
WD=$(dirname "$(readlink -f "$0")")
echo "change directory to $WD"
cd $WD
BUILD=build_linux
[ -d $BUILD ] || mkdir -p $BUILD
cd $BUILD
rm * -rf
cmake ..
make -j $(($(nproc)-1))
