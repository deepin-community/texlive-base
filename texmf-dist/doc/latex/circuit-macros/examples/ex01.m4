.PS
# Timer.m4
cct_init
iflatex(`latexcommand({\small\sf)')

define(`ic555',`[Chip: box ht boxwid wid boxwid "555"
  P7: "7" ljust at 1/6<Chip.sw,Chip.nw>
  P6: "6" ljust at 1/2<Chip.sw,Chip.nw>
  P2: "2" ljust at 5/6<Chip.sw,Chip.nw>
  P4: "4" below at 1/3<Chip.nw,Chip.ne>
  P8: "8" below at 2/3<Chip.nw,Chip.ne>
  P3: "3" rjust at Chip.e
  P1: "1" above at Chip.s
  ]')

Timer: [
  define(`elen_',`linewid')
Vs: dot
  down_
  variable(`resistor(,E); llabel(,\SI{1}{M})')
  resistor(,E); llabel(,\SI{100}{\kilo{}})
  capacitor(,E); llabel(\SI{220}{\micro{}})
Zero: dot

  dot(at Vs+(elen_*4/3,0))
  resistor(,E); llabel(,\SI{33}{\kilo{}})
  line to (Here,Zero) chop 0 chop elen_
C2: capacitor; llabel(\SI{0.1}{\micro{}})
  dot

IC1: ic555 with .P7 at C2.start + (elen_,0)
  line from IC1.P4 to (IC1.P4,Vs); dot
  line from IC1.P8 to (IC1.P8,Vs); dot
  line from IC1.P1 to (IC1.P1,Zero); dot
  line from IC1.P2 to (C2,IC1.P2); dot
  crossover(from IC1.P7 to (Zero,IC1.P7),R,C2); dot
  line from IC1.P6 left elen_/2 then down IC1.P6.y-IC1.P7.y; dot
  line from IC1.P3 right elen_*2/3
R: dot
  line right_ elen_/3
B: buzzer(,,C) with .In3 at Here
  line from B.In1 to (R,B.In1)
  reversed(`diode',to (Here,Vs),LE); "red" at last line.c+(elen_/2,0)
  resistor(down_ elen_ from R,E); llabel(,\num{470})
  diode(to (Here,Zero),LE); {"green" at last line.c+(elen_*2/3,0)}
  line to Zero chop 0 chop -elen_
  line up_ (Vs.y-Here.y)/3
  battery(up_ (Vs.y-Here.y)/3); rlabel(,,\SI{9}{V})
  switch(to (Here,Vs),,D)
  line to (R,Vs)
]
Ex01: [
# ex01.m4
  linewid = linewid*1.5     # let's make the circuit elements bigger than usual
  define(`elen_',linewid)   # but not longer
  del = elen_/4             # a spacing parameter

  Vin: source(up_ elen_ + 2*del); llabel(-,v_s,+)

  switch(right_ elen_,,C); rlabel(,t = 0,)
  resistor; llabel(,47\`,'\Omega,); b_current(i_R\strut,above rjust)

  line right_ elen_/2 then down_ del
  parallel_(`inductor(,W); llabel(,L,); b_current(\>`'i_L)',
            `capacitor(,C); rlabel(+,v_C,-); llabel(,,\;C)')
  line to (Here,Vin.start) then to Vin.start

  arcd(last []+(4pt__,0),del,30,330) <- ; "$i_2$" at last arc
  arcd(Vin.c+(4*del,0),2*del,30,330) <- ; "$i_1$" at last arc

  ] with .sw at Timer.se+(0.5,0)

iflatex(`latexcommand(}%)')
.PE
