#!/bin/bash
for datei in $1????.tex
do
   RUNS=1
   echo "LuaLaTeX-Lauf Nr. $RUNS von $datei ======================================="
   lualatex --interaction=nonstopmode $datei
   MAIN=$(basename -a -s .tex $datei)
   TEST=`grep -c "Label(s) may have changed." $MAIN.log`
   while [ $TEST -gt 0 ]; 
   do
     let RUNS=RUNS+1
     echo "LuaLaTeX-Lauf Nr. $RUNS von $datei ======================================="
     lualatex --interaction=nonstopmode  $datei
     TEST=`grep -c "Label(s) may have changed." $MAIN.log `
     if [ $RUNS -gt 4 ]
     then TEST=0
     fi
   done
   rm -fr $MAIN.aux $MAIN.log $MAIN.out $MAIN.toc $MAIN.lof $MAIN.lot $MAIN.idx 
done
