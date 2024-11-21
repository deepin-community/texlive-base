.PS
# ResistorsMan.m4
cct_init

movewid = 2 pt__
hm = 2.05
vm = 0.28
{  {A:resistor ; move ;"`{\tt resistor}'" ljust}
   move right_ hm
   {Q:resistor(,5,Q) ; move ;"`\tt $\ldots$(,5{,}Q) '" ljust}
   move right_ hm
   {V:resistor(,,V) ; move ;"`{\tt $\ldots$(,{,}V)}'" ljust}
}
   move down vm; right_
{  {ES:resistor(,,ES); move ;"`\tt $\ldots$(,{,}ES) '" ljust}
   move right_ hm
   {H:resistor(,4,H) ; move ;"`\tt $\ldots$(,4{,}H) '" ljust}
   move right_ hm
   {AC:resistor(,,AC) ; move ;"`{\tt $\ldots$(,{,}AC)}'" ljust}
}
   move down vm; right_
{  {B:resistor(,,B) ; move ;"`{\tt $\ldots$(,{,}B)}'" ljust}
   move right_ hm
   {F:resistor(,,F) ; move ;"`\tt $\ldots$(,{,}F) '" ljust}
   move right_ hm
   {E:resistor(,,E) ; move ; "`\tt $\ldots$(,{,}E) $\equiv$ ebox'" ljust}
}
   move down vm*1.1; right_
{  {ebox(,,,0.9) ; move ;"`{\tt ebox(,{,},0.9)}'" ljust}
   move right_ hm
   {ebox(,wdth=0.2;box=dashed shaded "green";text="H") ; move
   "`\shortstack[l]{\tt ebox(,wdth=0.2;box=dashed shaded \"green\";\\' \
     `\tt text=\"H\")}'" ljust}
}

.PE
