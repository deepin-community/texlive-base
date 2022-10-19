.PS
# TimerSVG.m4
cct_init(svg_font(sans-serif,10.5bp__))

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
  variable(`resistor(,E); llabel(,svg_norm(1 M`'svg_ohm))');
  resistor(,E); llabel(,svg_norm(100 k`'svg_ohm))
  capacitor(,E); llabel(svg_norm(220 svg_micro`'F))
Zero: dot

  dot(at Vs+(elen_*4/3,0))
  resistor(,E); llabel(,svg_norm(33 k`'svg_ohm))
  line to (Here,Zero) chop 0 chop elen_
C2: capacitor; llabel(svg_norm(0.1 svg_micro`'F))
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
  resistor(down_ elen_ from R,E); llabel(,svg_norm(470 svg_ohm))
  diode(to (Here,Zero),LE); {"green" wid 0.4 at last line.c+(elen_*2/3,0)}
  line to Zero chop 0 chop -elen_
  line up_ (Vs.y-Here.y)/3
  battery(up_ (Vs.y-Here.y)/3); rlabel(,,svg_norm(9 V))
  switch(to (Here,Vs),,D)
  line to (R,Vs)
]
Ex01: [
# ex01.m4

linewid = linewid*1.5     # let's make the circuit elements bigger than usual
define(`elen_',linewid)   # but not longer

  del = elen_/4           # a spacing parameter
  move right 0.4
Vin: source(up_ elen_ + 2*del, V); llabel(,v`'svg_sub(s),)

  switch(right_ elen_,,C); rlabel(,t = svg_norm(0),)
  resistor; llabel(,svg_norm(47 ohm),); b_current()
  { "svg_it(i`'svg_sub(R))" at last arrow.end+(0,3bp__) above rjust }

  line right_ elen_/2 then down_ del
  P:parallel_(`L:inductor(,W); llabel(,"L" wid 0.15,); b_current()',
            `capacitor(,C); rlabel(+,v`'svg_sub(C),-); llabel(,,C)')
  { "svg_it(i`'svg_sub(L))" at P.E1.L.start+(2bp__,0) ljust below }
  line to (Here,Vin.start) then to Vin.start

  define(`meshcurrent',`[arc -> cw with .c at (0,0) \
    from (Rect_(`$1',-30)) to (Rect_(`$1',30)) "svg_it(`$2')"]')

  right_
  meshcurrent(del,i`'svg_sub(2)) at last[].C
  meshcurrent(2*del,i`'svg_sub(1)) at Vin.start + (4*del,3*del)
  ] with .sw at Timer.se+(0.5,0)

 command "</g>" # end font
.PE
