.PS
# ResistorsMan.m4
cct_init

movewid = 2 pt__
hm = 2.05
vm = 0.28
{  {resistor ; move ;"`{\tt resistor}'" ljust}
   move right_ hm
   {resistor(,,Q) ; move ;"`\tt resistor(,{,}Q) '" ljust}
   move right_ hm
   {resistor(,,V) ; move ;"`{\tt resistor(,{,}V)}'" ljust}
}
   move down vm; right_
{  {resistor(,,ES) ; move ;"`\tt resistor(,{,}ES) '" ljust}
   move right_ hm
   {resistor(,,H) ; move ;"`\tt resistor(,{,}H) '" ljust}
   move right_ hm
   {resistor(,,AC) ; move ;"`{\tt resistor(,{,}AC)}'" ljust}
}
   move down vm; right_
{  {resistor(,5,B) ; move ;"`{\tt resistor(,5,B)}'" ljust}
   move right_ hm
   {resistor(,,E) ; move 
    "`\shortstack[l]{\tt resistor(,{,}E)\\ {\tt $\equiv$ ebox}}'" ljust}
   move right_ hm
   {ebox(,0.5,0.3) ; move ;"`{\tt ebox(,0.5,0.3)}'" ljust}
}
   move down vm; right_
{  {ebox(,,,0.9) ; move ;"`{\tt ebox(,{,},0.9)}'" ljust}
   move right_ hm
   {ebox(,,,,shaded "green") ; move
     "`{\tt ebox(,{,},{,}shaded \"green\")}'" ljust}
}
   move down vm; right_
{  {ebox(,wdth=0.2;box=dashed shaded "green";text="X") ; move
   "`{\tt ebox(,wdth=0.2;box=dashed shaded \"green\";text=\"X\")}'" ljust}
}

.PE
