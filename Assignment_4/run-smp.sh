#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: ./simple.exe inputs/io01.smp <rebuild:0|1>"
  exit 1
fi

if [ ! -f $1 ]; then
  echo "Error: run-smp.sh didn't find an smp file."
  exit 1
fi

if [ $2 -eq 1 ]; then
make
fi

echo "**********************************************************"
echo "Test case: $1"
cat $1
echo "**********************************************************"
#./simple-debug.exe < $1
./simple.exe < $1

