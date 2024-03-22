.PS
# ClassDAmp.m4
# Adapted and redrawn from Maxim Engineering Journal Vol. Fifty-Nine:
# https://pdfserv.maximintegrated.com/en/ej/EJ59.pdf
log_init

define(`String',`[
Q1: mosfet(down_ dimen_*5/4,R,TFSDdPyQdB)
  dot(at Q1.S)
  { line up_ dimen_/4
    dot(,,1); "ifsvg(`svg_it(V)svg_sub(DD)',`$V_{\hbox{\scriptsize DD}}$')" \
      at last [].n+(0,0.05) above }
  line left_ dimen_*2/3
SW: switch(left_ dimen_,`$1',D); ifelse(`$1',,`rlabel(,SW1)',`llabel(,SW2)')
Q2: mosfet(up_ dimen_*5/4,,TFSDPyQuB) with .D at Q1.D
  ground(at Q2.S,T,S)
Out: dot(at Q1.D)
  line from Q1.G to Q2.G chop -lthick/2
  G: dot(at last line.c)
  dot(at (SW.end,Here)); { line to SW.end }
  line from G left_ dimen_*2.5
Rc: resistor(left_ dimen_)
T: dot; right_
  Comp: opamp(,,,,ifelse(`$1',R,,R)) with .Out at Here
  [line left_ dimen_/12 then down_ dimen_/4 then left_ dimen_/12] \
    with .e at Comp.C
  ]')

S1: String
S2: String(R) with .Q1.S at S1.Q2.D+(0,-2*elen_)
I1: line left_ dimen_/2 from S1.Comp.In1
  sinusoid(dimen_/4,twopi_/(dimen_/2),-pi_/2,0,dimen_/2) \
    with .Start at I1.end-(textoffset,0)
I2: line left_ dimen_/2 from S2.Comp.In2
  sinusoid(dimen_/4,twopi_/(dimen_/2),pi_/2,0,dimen_/2) \
    with .Start at I2.end-(textoffset,0)
  line from S1.Comp.In2 left I1.len
  continue to (Here,S2.Comp.In1) then to S2.Comp.In1
  dot(at 1/2 between I1.end and I2.end)
  line left_ dimen_/2; move left_ textoffset then down_ dimen_/4
  line up dimen_/2 then down dimen_/2 left_ dimen_/4 \
    for_(1,3,1,`then up dimen_/2 then down dimen_/2 left_ dimen_/4 \') 

  right_
N: NOR_gate with .Out at (1/2 between S1.Rc.start and S2.Rc.start)
  line from S1.T to (S1.T,N.In1) then to N.In1
  line from S2.T to (S2.T,N.In2) then to N.In2
NO: dot(at N.Out+(dimen_/12,0))
  resistor(right_ dimen_ from N.Out)
  rlabel(,iflatex(R_{\hbox{\scriptsize On}},ifsvg(svg_it(R)`'svg_sub(On))))
  dot
  { line up_ dimen_/2; diode(to (NO,Here),Z); line to NO }
  { capacitor(down_ dimen_); ground(,T,S)
  llabel(,iflatex(C_{\hbox{\scriptsize On}},ifsvg(svg_it(R)`'svg_sub(On)))) }
  line dashed to (S1.SW,Here)
  arrow <-> dashed from S1.SW to S2.SW chop dimen_/4

  line right_ dimen_ from S1.Out "Out-" above
  line down_ (Here.y-S2.Out.y)/2-dimen_; ifsvg({move right_ 3*textht})
  inductor(down_ dimen_)
  llabel(,iflatex(L_{\hbox{\scriptsize E}},ifsvg(L`'svg_sub(E))))
  resistor(down_ dimen_)
  llabel(,iflatex(R_{\hbox{\scriptsize E}},ifsvg(R`'svg_sub(E))))
  line to (Here,S2.Out) then to S2.Out "Out+" above

.PE
