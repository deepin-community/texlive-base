.PS
# `ResistorsDPV.m4'
cct_init(svg_font(sans-serif,11pt__))
textwid = 1.5

movewid = 2 pt__
hm = 2.1
vm = 0.28
{
   {resistor ; move ; svgLink(NportDPV.svg,"`resistor'" ljust)}
   move right_ hm
   {resistor(,5,Q) ; move ;"`...(,5,Q) '" ljust}
   move right_ hm
   {resistor(,,V) ; move ;"`...(,,V)'" ljust}
}
   move down vm; right_
{  {resistor(,,ES) ; move ;"`...(,,ES) '" ljust}
   move right_ hm
   {resistor(,4,H) ; move ;"`...(,4,H) '" ljust}
   move right_ hm
   {resistor(,,AC) ; move ;"`...(,,AC)'" ljust}
}
   move down vm; right_
{  {resistor(,,B) ; move ;"`...(,,B)'" ljust}
   move right_ hm
   {resistor(,,F) ; move ;"`...(,,F) '" ljust}
   move right_ hm
   {resistor(,,E) ; move ;"`...(,,E) svg_equiv ebox'" ljust}
}
   move down vm*1.1; right_
{  {ebox(,,,0.9) ; move ;"`ebox(,,,0.9)'" ljust}
   move right_ hm
   {ebox(,wdth=0.2;box=dashed shaded "green";text="X") ; move
   "`ebox(,wdth=0.2;box=dashed shaded \"green\";'" ljust \
     "`text=\"X\")'" ljust}
}

 command "</g>" # end font
.PE
