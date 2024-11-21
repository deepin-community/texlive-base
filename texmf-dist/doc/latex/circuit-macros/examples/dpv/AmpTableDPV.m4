.PS
# `AmptableDPV.m4'
cct_init(svg_font(sans-serif,11bp__))

  textwid = 0.7
  movewid = 2pt__
{
   {amp ; move ; "`amp'" ljust}
   move right_ 2.0
   {amp(,5mm__) ; move ; "`amp(,5mm__)'" ljust}
   move right_ 2.0
   {integrator ; move ; "`integrator'" ljust}
  }
   move down 0.5; right_
{
   {delay(,,fill_(0.9)) ; move ;
    "`delay(,,'" ljust "`fill_(0.9))'" ljust}
   move right_ 2.0
   {delay(,,type=S;body=shaded rgbstring(0.75,0.75,1)); move
   "`delay(,,type=S;" ljust "body=shaded rgbstring(0.75,0.75,1)')" ljust}
  }

 command "</g>" # end font
.PE
