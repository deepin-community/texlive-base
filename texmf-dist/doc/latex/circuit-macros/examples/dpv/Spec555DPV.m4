.PS
# Spec555.m4
# https://tex.stackexchange.com/questions/64801/display-ics-with-circuitikz?rq=1
log_init

define(`spec555',`[ Chip: box wid 8*lg_pinsep ht 10*lg_pinsep fill_(0.9)
  svg_font(sans-serif,8bp__)
  P1: 3/4<Chip.sw,Chip.se>; {"1" below rjust at P1};  "GND" above at P1
  P5: Chip.s;               {"5" below rjust at P5};  "CTRL" above at P5
  P2: 1/8<Chip.sw,Chip.nw>; {"2" above rjust at P2};  "TRG" ljust at P2
  P6: 3/8<Chip.sw,Chip.nw>; {"6" above rjust at P6};  "THR" ljust at P6
  P7: 7/8<Chip.sw,Chip.nw>; {"7" above rjust at P7};  "DIS" ljust at P7
  P3: Chip.e;               {"3" above ljust at P3};  "OUT" rjust at P3
  P4: 3/4<Chip.nw,Chip.ne>; {"4" above rjust at P4};  "svg_emsp`'RESET" below \
    at P4
  P8: Chip.n;               {"8" above rjust at P8};  "Vcc" below at P8
  "NE-555" at Chip.c "TIMER" 
  command "</g>"
  line left dimen_ from P7; X:dot
  { R1:resistor(up_ P7.y-P6.y); rlabel(,68 k`'svg_ohm); dot }
  R2:resistor(down_ P7.y-P6.y); llabel(,68 k`'svg_ohm); dot; {line to P6}
  line to (Here,P2); SW: dot; {line to P2}
  line from P8 to (P8,R1.end); dot ]')

  svg_font(sans-serif,10bp__)
  T1: spec555; "U1" at T1.Chip.nw above ljust
  T2: spec555 with .Chip.w at T1.Chip.e+(2.5*dimen_,0)
   "U2" at T2.Chip.nw above ljust
  {line left_ dimen_/2 from (T1.X,T1.P7); diode(down_ T1.P7.y-T1.P6.y)
     {"D1" wid 15bp__ rjust at last [].w "1N4148" rjust wid 36bp__}
     line to (T1.X,Here); dot}
  capacitor(down_ elen_*1.2 from T1.SW,E+); llabel(,10 uF); dot
  dot(at Here-(dimen_/2,0),,1); G: dot(,,1); "GND" rjust at G.w
  capacitor(from T1.P5 to (T1.P5,G),E+); rlabel(,0.01 nF); dot
  line from T1.P1 to (T1.P1,G); dot
  Vcc: dot(at (G,T1.R1.end),,1); "Vcc" wid 0.3 rjust at Vcc.w 
  dot(at (T1.P4,Vcc)); line to T1.P4
  line right_ dimen_/2 from T1.P3;
  R3: resistor(down_ to (Here,T2.s-(0,dimen_/4))); llabel(,10 k`'svg_ohm)
  line to (T2.P5,Here) then to T2.P5
  dot(at (T2.X,G)); ground
  reversed(`capacitor',up_ to (Here,T2.P5),E+); rlabel(,100 nF)
  line to (Here,T2.P2)
  line from T2.P1 to (T2.P1,G); dot
  line from T2.P4 to (T2.P4,Vcc) then to Vcc chop 0 chop dotrad_
  dot(at (T2.X,T2.R1.end)+(0,dimen_/2),,1); {line to T2.R1.end chop dotrad_}
  "+5 V to +15V" at last [].n above
  capacitor(right_ dimen_ from T2.P3,C); llabel(," 100 uF")
  Pot1: potentiometer(down_ (Here.y-G.y)/2) with .Start at Here
  "Rx" wid 0.2 at Pot1.T1 ljust
  Sp: speaker(R,,,fill_(0.9)) with .In5 at Pot1.End 
  "1" above rjust at Sp.In5; "2" below rjust at Sp.In7
  "E1" at Sp.In2 rjust "Speaker" rjust
  line from Sp.In7 to (Sp.In7,G) then to G chop 0 chop dotrad_
  command "</g>"

.PE
