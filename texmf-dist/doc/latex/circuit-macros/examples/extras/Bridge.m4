.PS
# Bridge.m4
cct_init
linewid = 1.5
  down_
  AC: source(up_ elen_,S)
  line right_ elen_
  dlen = linewid*2/3
Bridge: [
  N: Here; S: Here+(0,-2*dlen); E: N+(dlen,-dlen); W: N+(-dlen,-dlen)
  diode(from N to E)
  diode(from S to E)
  diode(from W to N)
  diode(from W to S)
  ] at (Here,AC)

  line from Bridge.N to last line.end
  line from Bridge.S to (Bridge.S,AC.start)
  Gr: line to AC.start
  line from Bridge.E right_ dlen
  G: gap(down_ Bridge.ht/2+dimen_/4,1); llabel(+,,-)
  line from Bridge.W left_ dlen/4
  crossover(to (Here,G.end),,Gr)
  line to G.end chop 0 chop dotrad_

  [ L: line right_ linewid/3
    sinusoid( linewid/6,twopi_/linewid*4,-pi_/2,0,linewid/8) with .End at L
    sinusoid( linewid/6,twopi_/linewid*4,-pi_/2,0,linewid/8) with .Start at L
  ] at G
  R: resistor(down_ G.len from G.start+(dimen_/2,0)); llabel(,R)
  arrow wid arrowwid*2 from  R.start to 0.5<R.start,G.start>
  arrow wid arrowwid*2 from  R.end to 0.5<R.end,G.end>


.PE
