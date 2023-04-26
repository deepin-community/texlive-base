.PS
# slddiagsDPV.m4
cct_init(svg_font(sans-serif,10bp__))
include(libSLD.m4)

Pic1: [
define(`TrDeltaWye',
 `sl_transformer(down_ elen_ `$1',type=S)
  { Deltasymbol(at last [].M1); Ysymbol(at 2nd last [].M2,,D) } ')

 T: dot
 switch(up_ elen_); {"Public supply" above}
 Bus1: sl_busbar(right_ 5*dimen_,6,port=D) with .c at T
 {"svg_small(20 kV)" at Bus1.Start above ljust}
 S1: switch(from Bus1.P1-(0,elen_) up_ elen_)
 S2: switch(from Bus1.P2-(0,elen_) up_ elen_)
 TRF1: TrDeltaWye(from Bus1.P3); arrow down_ dimen_/3
 TRF2: TrDeltaWye(from Bus1.P4); arrow down_ dimen_/3
 TRF3: TrDeltaWye(from Bus1.P5); arrow down_ dimen_/3
 S3: switch(from Bus1.P6-(0,elen_) up_ elen_)
 Bus2: sl_busbar(right_ 1.5*dimen_,3,port=D) with .c at Bus1.P1+(0,-dimen_*3)
 {"svg_small(20 kV)" at Bus2.Start above ljust}
 {"svg_small(1.25 MVA)" at Bus2.P2 below}
 S4: switch(from Bus2.P2 to S1.start)
 TRF4: TrDeltaWye(from Bus2.P1)
 S4: switch(from Bus2.P3+(0,-elen_) to Bus2.P3)
]

Pic2: [
# https://tex.stackexchange.com/questions/597643/draw-a-power-system-network
 B1: sl_busbar(up_ dimen_*4/3,3)
 sl_transformer(right_ 2*dimen_ from last [].P2,
  type=S;body=shaded "lightgray"); variable(,,,dimen_*3/2)
 B2: sl_busbar(up_ dimen_*4/3,3)
  { line left_ dimen_/2 from B2.P1
    C1: capacitor(down_ dimen_/2); ground(,T) }
  line right_ dimen_/2
  { line to (Here,C1.start); C2: capacitor(to (Here,C1.end)); ground(,T) }
  ebox(right_ 3.5*dimen_, 2.5*dimen_, dimen_/5, 0.75)
  { line to (Here,C1.start); C3: capacitor(to (Here,C1.end)); ground(,T) }
  line right_ dimen_/2
 B3: sl_busbar(up_ dimen_*4.5,6)
  line right_ dimen_*3/4 from B3.P1; box wid dimen_*3 ht dimen_*.6 \
    shaded "Goldenrod" "Static Load"
  line right_ dimen_*3/4 from B3.P2; box wid dimen_*3 ht dimen_*.6 \
    shaded rgbstring(0.99*0.8, 0.74*0.8, 0.71*0.8) "Electronic Load"
  sl_disk(right_ dimen_ from B3.P3,
   text="A/C";circle=shaded ```rgbstring(.2,.8,.2)''';diam=dimen_*3/4)
  sl_disk(right_ dimen_ from B3.P4,
   text="M";circle=shaded ```rgbstring(.21,.47,.86)''';diam=dimen_*3/4)
  sl_disk(right_ dimen_ from B3.P5,
   text="M";circle=shaded ```rgbstring(.2,.6,.8)''';diam=dimen_*3/4)
  sl_disk(right_ dimen_ from B3.P6,
   text="M";circle=shaded ```rgbstring(.2,.63,.8)''';diam=dimen_*3/4)
  sl_disk(left_ dimen_ from 1/2 between B3.P1 and B3.P2,
   text="svg_small(DER_A)";\
   circle=shaded ```rgbstring(0.78,0.36,0.3)''';diam=dimen_*3/4)
] with .nw at last [].sw + (100bp__,120bp__)

Pic3: [
define(`shadedb',`shaded "CornflowerBlue"')
Loopover_(`LR',                     # loop to take advantage of symmetry
 `define(`opposite',`ifelse(LR,left,right,left)')dnl
  ifelse(LR,left,L,R)`'side: [
    sl_generator(LR dimen_/2,type=B;name=G1;circle=shadedb,box=shadedb)
    T1: sl_transformer(opposite dimen_*3/2)
    Bus1: sl_busbar(up_ dimen_*3/2,3,) with .P2 at Here
    Br1: sl_breaker(from Bus1.P3 opposite elen_,box=shadedb)
    line opposite dimen_
    Br2: sl_breaker(from Bus1.P1 opposite elen_,box=shadedb)
    Br3: sl_breaker(down_ dimen_,box=shadedb)
    Bus2: sl_busbar(opposite dimen_,3) with .P2 at Here
    T2: sl_transformer(down_ dimen_ from Bus2.P2,name=X2)
    sl_disk(down_ dimen_/2,type=B;text="SM";name=SM1;circle=shadedb,box=shadedb)
    ground(at last circle.s,dimen_/2)
    ]',
  left,right)
 "Bus 1" at Lside.Bus1.top above
 "Bus 2" at Rside.Bus1.top above
 "Bus 3" at Lside.Bus2.w above
 "Bus 4" at Rside.Bus2.e above
 "TL`'svg_sub(1) 50 km 69 kV" at 1/2 between Lside.Br1 and Rside.Br1 above
 "TL`'svg_sub(2) 30 km" ljust "69 kV" ljust at Lside.Br2.end + (-18bp__,12bp__)
 "TL`'svg_sub(2) 20 km" ljust "69 kV" ljust at Rside.Br2.end + (-18bp__,12bp__)
 "G`'svg_sub(1) 50 MVA" ljust "13.8 kV" ljust at Lside.G1.w+(0,-28bp__)
 "G`'svg_sub(2) 30 MVA" ljust "13.8 kV" ljust at Rside.G1.w+(0,-28bp__)
 "T`'svg_sub(1) 50 MVA" ljust "13.8/69 kV svg_Delta/Y" ljust \
   at Lside.T1.start+(0,-37bp__)
 "T`'svg_sub(2) 30 MVA" ljust "69/13.8 kV Y/svg_Delta" ljust \
   at Rside.T1.end+(5bp__,-33bp__)
 "T`'svg_sub(3) 50 MVA" rjust "13.8/69 kV Y/svg_Delta" rjust \
  at Lside.X2.w+(-4bp__,0)
 "T`'svg_sub(4) 20 MVA" ljust "69/6.9 kV Y/svg_Delta" ljust \
  at Rside.X2.e+(4bp__,0)
 "SM`'svg_sub(1) 30 MVA" rjust "13.8 kV" rjust at Lside.SM1.w+(-4bp__,0)
 "SM`'svg_sub(2) 20 MVA" ljust "6.9 kV" ljust at Rside.SM1.e+( 4bp__,0)
] with .nw at (Pic1.w,last [].sw + (0,-15bp__))

command "</g>"
.PE
