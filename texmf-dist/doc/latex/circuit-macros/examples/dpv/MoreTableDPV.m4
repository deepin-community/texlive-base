.PS
# MoreTableDPV.m4
cct_init(svg_font(sans-serif,11pt__))
textwid = 1.5
movewid = 2 pt__
hm = 2.1
vm = 0.28

hm = 2.05
vm = 0.28

{  {memristor ; move;"`memristor '" ljust}
   move right_ hm
   {heater; move;"`heater '" ljust}
   move right_ hm
   {tline ; move;"`tline '" ljust}
}
   move down 0.25; right_
{ {pvcell ; move;"`pvcell '" ljust}
   move right_ hm
   {reed ; move ;"`reed '" ljust}
   move right_ hm
   {reed(,,,fill_(0.9),CR) ; move ; "`reed(,,,fill_(0.9),CR) '" ljust}
}
   move down 0.25; right_
{  {gap ; move ;"`gap '" ljust}
   move right_ hm
   {gap(,,A) ; move ;"`gap(,,A) '" ljust}
   move right_ hm
  {arrowline ; move;"`arrowline '" ljust}
}
   move down 0.25; right_
{  move down 0.10; right; {lamp ; move;"`lamp '" ljust}
   move right_ hm
   {thermocouple ; move;"`thermocouple '" ljust }
#  move up 0.10 right_ hm
#  {arrester ; move ;"`arrester '" ljust}
   move right_ hm
   {xtal ; move ;"`xtal '" ljust}
}

 command "</g>" # end font
.PE
