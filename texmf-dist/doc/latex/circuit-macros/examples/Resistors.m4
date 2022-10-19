.PS
# Resistors.m4
cct_init

movewid = 2 pt__
hm = 2.05
vm = 0.28
{  {resistor ; move ;"`{\tt resistor}'" ljust}
   move right_ hm
   {resistor(,,Q) ; move ;"`\tt resistor(,{,}Q) '" ljust}
   move right_ hm
   {resistor(,,E) ; move 
    "`\shortstack[l]{\tt resistor(,{,}E)\\ {\tt $\equiv$ ebox}}'" ljust}
}
   move down vm; right_
{  {resistor(,,ES) ; move ;"`\tt resistor(,{,}ES) '" ljust}
   move right_ hm
   {resistor(,,H) ; move ;"`\tt resistor(,{,}H) '" ljust}
   move right_ hm
   {ebox(,,,0.5) ; move ;"`{\tt ebox(,{,},0.5)}'" ljust}
}
   move down vm; right_
{  {resistor(,,V) ; move ;"`{\tt resistor(,{,}V)}'" ljust}
   move right_ hm
   {ebox(,0.5,0.3) ; move ;"`{\tt ebox(,0.5,0.3)}'" ljust}
   move right_ hm+4bp__
   {resistor(,,B) ; move movewid-4bp__ ;"`{\tt resistor(,,B)}'" ljust}
}

.PE
