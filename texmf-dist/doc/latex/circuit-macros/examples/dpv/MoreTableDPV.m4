.PS
# MoreTableDPV.m4
cct_init(svg_font(sans-serif,11pt__))

Heater: [
  movewid = 2 pt__
  hm = 2.05
  right_
{
  {lamp(,,shaded "yellow") ; move; "" "`lamp(,,'" ljust \
    "`shaded \"yellow\")'" ljust}
  move right_ 1.5
  {lamp(,T) ; move;"`lamp(,T)'" ljust}
  move right_ 1.25
  {thermocouple ; move;" `thermocouple'" ljust }
  move right_ hm
  {thermocouple(,,,T) ; move; "`thermocouple(,,,T)'" ljust }
  }
  move down 0.4; right_
{
  {heater(,,,,shaded "orangered"); move; "" "`heater(,,,,'" ljust \
    "`shaded \"orangered\")'" ljust}
  move right_ hm
  {heater(,,,,E); move;"`heater(,,,,E)'" ljust}
  move right_ hm+0.4
  {heater(,,,,ET); move;"`heater(,,,,ET)'" ljust}
  }
  ]

More: [
  textwid = 1.5
  movewid = 2 pt__
  hm = 2.1
  vm = 0.28
  
  hm = 2.05
  vm = 0.28
  
  {  {memristor ; move;"`memristor '" ljust}
#    move right_ hm
#    {heater; move;"`heater '" ljust}
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
] with .nw at Heater.sw+(0,-0.2)

 command "</g>" # end font
.PE
