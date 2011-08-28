#!/bin/bash

DIR=$1
WD=`pwd`

if [[ ! -d $DIR ]]; then
  echo "Usage: make_paper.sh source_dir"
  exit -1
fi

AUTHOR=`basename $DIR`
OUTDIR="output/$AUTHOR"
TEX2PDF="pdflatex paper.tex"

mkdir -p $OUTDIR
cp $DIR/* $OUTDIR
python publisher/build_paper.py $DIR $OUTDIR 
if [ "$?" -ne "0" ]; then
    echo "Error building paper $DIR. Aborting."
    exit 1
fi

cd $OUTDIR
$TEX2PDF > /dev/null && $TEX2PDF | (python $WD/publisher/page_count.py)
