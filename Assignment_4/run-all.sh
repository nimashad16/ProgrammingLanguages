#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: ./run-all.sh <inputdir>"
  exit 1
fi

if [ ! -d $1 ]; then
  echo "Directory given does not exist"
  exit 1
fi

inputdir=$1

make
for tc in `ls $inputdir/*.smp`; do
  echo "#############################################################################"
  echo "Showing input test case: $tc"
  cat $tc
  ./simple.exe < $tc
done

