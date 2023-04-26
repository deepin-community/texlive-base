.PS
# `ResistorsDPV.m4'
cct_init(svg_font(sans-serif,11pt__))
textwid = 1.5
movewid = 2 pt__
hm = 2.1
vm = 0.28

hm = 2.05
vm = 0.28
{
   {resistor ; move ; svgLink(NportDPV.svg,"`resistor'" ljust)}
   move right_ hm
   {resistor(,,Q) ; move ; "`resistor(,,Q) '" ljust}
   move right_ hm
   {resistor(,,V) ; move ; "`resistor(,,V) '" ljust}
}
   move down vm; right_
{
   {resistor(,,ES) ; move ; "`resistor(,,ES) '" ljust}
   move right_ hm
   {resistor(,,H) ; move ; "`resistor(,,H) '" ljust}
   move right_ hm
   {resistor(,,AC) ; move ; "`resistor(,,AC) '" ljust}
}
   move down vm; right_
{
   {resistor(,,B) ; move ; "`resistor(,,B) '" ljust}
   move right_ hm
   {resistor(,,E) ; move 
    "`resistor(,,E)'" ljust " svg_equiv `ebox'" ljust}
   move right_ hm
   {ebox(,0.5,0.3) ; move ;"`ebox(,0.5,0.3) '" ljust}
}
   move down vm; right_
{
   {ebox(,,,0.6) ; move ; "`ebox(,,,0.6) '" ljust}
   move right_ hm
   {ebox(,,,,shaded "yellow") ; move ;"`ebox(,,,,shaded \"yellow\") '" ljust}
}
   move down vm; right_
{
   {ebox(,wdth=0.2;box=dashed shaded "green";text="X") ; move
   "`ebox(,wdth=0.2;box=dashed shaded \"green\";text=\"X\")'" ljust}
}

 command "</g>" # end font
.PE
