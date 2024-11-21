.PS
# Spec555.m4
# https://tex.stackexchange.com/questions/64801/display-ics-with-circuitikz?rq=1
log_init

define(`spec555',`[ Chip: box wid 8*lg_pinsep ht 10*lg_pinsep fill_(0.9)
  command "{\scriptsize\sf"
  P1: "1" at 3/4<Chip.sw,Chip.se> below rjust;   "GND" above
  P5: "5" at Chip.s below rjust              ;   "CTRL" above
  P2: "2" at 1/8<Chip.sw,Chip.nw> above rjust;   "TRG" ljust
  P6: "6" at 3/8<Chip.sw,Chip.nw> above rjust;   "THR" ljust
  P7: "7" at 7/8<Chip.sw,Chip.nw> above rjust;   "DIS" ljust
  P3: "3" at Chip.e above ljust              ;   "OUT" rjust
  P4: "4" at 3/4<Chip.nw,Chip.ne> above rjust;   "\phantom{M}RESET" below
  P8: "8" at Chip.n above rjust              ;   "Vcc" below
  "NE-555" at Chip.c "TIMER" 
  command "}%"
  line left dimen_ from P7; X:dot
  { R1:resistor(up_ P7.y-P6.y); rlabel(,\SI{68}{\kilo\ohm}); dot }
  R2:resistor(down_ P7.y-P6.y); llabel(,\SI{68}{\kilo\ohm}); dot; {line to P6}
  line to (Here,P2); SW: dot; {line to P2}
  line from P8 to (P8,R1.end); dot ]')

  command "{\small\sf"
  T1: spec555; "U1" at T1.Chip.nw above ljust
  T2: spec555 with .Chip.w at T1.Chip.e+(2.5*dimen_,0)
   "U2" at T2.Chip.nw above ljust
  {line left_ dimen_/2 from (T1.X,T1.P7); diode(down_ T1.P7.y-T1.P6.y)
     rlabel(,\shortstack{D1\\1N4148})
     line to (T1.X,Here); dot}
  capacitor(down_ elen_ from T1.SW,E+); llabel(,\SI{10}{\micro\farad}); dot
  dot(at Here-(dimen_/2,0),,1); G: dot(,,1); "GND" rjust at G.w
  capacitor(from T1.P5 to (T1.P5,G),E+); rlabel(,\SI{0.01}{\nano\farad}); dot
  line from T1.P1 to (T1.P1,G); dot
  Vcc: dot(at (G,T1.R1.end),,1); "Vcc" rjust at Vcc.w 
  dot(at (T1.P4,Vcc)); line to T1.P4
  line right_ dimen_/2 from T1.P3;
  R3: resistor(down_ to (Here,T2.s-(0,dimen_/4))); llabel(,\SI{10}{\kilo\ohm})
  line to (T2.P5,Here) then to T2.P5
  dot(at (T2.X,G)); ground
  reversed(`capacitor',up_ to (Here,T2.P5),E+); rlabel(,\SI{100}{\nano\farad})
  line to (Here,T2.P2)
  line from T2.P1 to (T2.P1,G); dot
  line from T2.P4 to (T2.P4,Vcc) then to Vcc chop 0 chop dotrad_
  dot(at (T2.X,T2.R1.end)+(0,dimen_/2),,1); {line to T2.R1.end chop dotrad_}
  "$+$\SI{5}{\volt} to $+$\SI{15}{\volt}" at last [].n above
  capacitor(right_ dimen_ from T2.P3,C); llabel(,\SI{100}{\micro\farad})
  Pot1: potentiometer(down_ (Here.y-G.y)/2) with .Start at Here
  "Rx" at Pot1.T1 ljust
  Sp: speaker(R,,,fill_(0.9)) with .In5 at Pot1.End 
  "1" above rjust at Sp.In5; "2" below rjust at Sp.In7
  "\shortstack{E1\\Speaker}" at Sp.In2 rjust
  line from Sp.In7 to (Sp.In7,G) then to G chop 0 chop dotrad_
  command "}%"

.PE
