.PS
# controlSVG.m4
gen_init(svg_font(Times,11bp__))
  linewid = linewid*0.8
  circlerad = 0.25/2
  bw = boxwid/2
  bh = boxht/2
  maxpsht = 15

# . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . #

PID: [
  {"svg_it(r(s))" above ljust}
  arrow
S1: circle
  line right "svg_it(e(s))" above
  { arrow right ; box ht bh wid bw "svg_it(K)svg_sub(p)"
    arrow right linewid-circlerad ; S2: circle }
  { line up linewid ; arrow right ; box ht bh wid bw "svg_it(K)svg_sub(D)s"
    line to (S2,Here) ; arrow to S2.n }
  { line down linewid ; arrow right ; box ht bh wid bw "svg_it(K)svg_sub(I)/s"
    line to (S2,Here) ; arrow to S2.s }
  arrow right from S2.e "svg_it(u(s))" above
  box "svg_it(G(s))"
  arrow right ; "svg_it(y(s))" above rjust at Here+(0,2pt__)
  line down boxht*3/2 from last arrow.c then left last arrow.c.x-S1.x
  arrow to S1.s
  "svg_it(-)" rjust at Here+(-2bp__,-2bp__)
]
  "(a) svg_it(PID) control" below ljust at PID.sw+(0,-5pt__)

# . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . #

# https://tex.stackexchange.com/questions/575592/how-to-create-a-controls-system-diagram
Observer: [
  define(`thickarrow',`arrow thick 3 wid 7bp__')
  define(`thickline',`line thick 3')
  fillval = 0.6
  boxwid = 0.3
  boxht = 0.4
  circlerad = 0.1
  {"svg_it(r)" above ljust}
R: arrow
S: circle fill
  {"svg_thinsp`'svg_it(-)" below ljust at S.s
   "svg_it(+)" above rjust at S.w+(2bp__,0)}
{ PLT: box invis fill 0.9 wid 3.1 ht 1.2 with .nw at Here+(0.3,boxht*3/4)
  "svg_it(Plant)" at PLT.sw above ljust }
U: arrow right 0.4
  {"svg_it(u)" at last arrow+(2bp__,0) above }
Bp: box fill "svg_it(B)" 
  thickarrow right 0.4 
Sp: circle fill
  {"svg_thinsp`'svg_it(+)" below ljust at Sp.s
   "+" above rjust at Sp.w+(2bp__,2bp__)}
  thickarrow right 0.4
  {"svg_bf(x)" at last arrow + (0,7bp__); "." at last "".n +(0,textoffset)}
Ip: box fill "svg_it(I/s)"
  thickarrow right 1
  {"svg_bf(x)" at last arrow + (0,7bp__) }
Cp: box fill "svg_it(C)"
# print Cp.e.x - Bp.w.x + 0.2
  thickline right 0.4
Yp: thickarrow
  {"svg_bf(y)" at last arrow + (0,7bp__) }
Ap: box fill "svg_it(A)" with .n at Ip.s+(0,-boxht/2) 
  thickarrow <- from Ap.e right 0.4 then up Ip.y-Ap.y
  thickarrow from Ap.w to (Sp,Ap) then to Sp.s
# print PLT.n.y-Ap.s.y+0.1
#
K: box fill "svg_it(K)" at Ap + (0,-boxht*3/2)
  arrow from K.w to (S,K) then to S.s
  {OBS: box invis fill 0.9 wid 4.3 ht 1.8 with .nw at (S.w,K.s)-(0.1,0.1)
   "svg_it(Observer)" at OBS.sw ljust above } 
Io: box fill "svg_it(I/s)" at K + (0,-boxht*3/2)
  thickarrow <- from Io.w left 0.4
  {"svg_bf(x)" at last arrow + (0,7bp__); "svg_circ" at last "" 
   "." at last "".n above}
Sxo: circle fill
  {"svg_thinsp`'svg_it(+)" below ljust at Sxo.s
   "svg_it(+)" above rjust at Sxo.w+(2bp__,2bp__)}
  thickarrow <- left 0.4
SLo: circle fill
  {"svg_thinsp`'svg_it(+)" below ljust at SLo.s
   "svg_it(+)" above rjust at SLo.w+(2bp__,2bp__)}
  thickarrow <- left 0.4
Bo: box fill "svg_it(B)"
  arrow from 1/4 between U.start and U.end up boxht*3/4 \
    then left 2*boxht then down Bp.y-Bo.y+boxht*3/4 then to Bo.w
Ao: box fill "svg_it(A)" with .n at Io.s+(0,-boxht/2) 
  thickline from Io.e right 0.4
  {thickarrow <-> from K.e to (Here,K.e) then to (Here,Ao) then to Ao.e
   thickarrow from Ao.w to (Sxo,Ao.w) then to Sxo.s }
Xhat: Here
Co: box fill "svg_it(C)" at (Cp,Here)
  thickarrow right 0.4
  {"svg_bf(y)" at last arrow + (0,7bp__); "svg_circ" at last ""}
  { thickarrow from Xhat to Co.w }
  {"svg_it(x)" at last arrow + (0,7bp__); "svg_circ" at last "" }
Syo: circle fill
  {"svg_it(+)" above ljust at Syo.n
   "svg_it(-)" above rjust at Syo.w+(2bp__,2bp__)}
  thickarrow <- from Syo.n to (Syo,Cp)
Lo: box fill "svg_it(L)" with .n at Ao.s+(0,-boxht/2) 
# print Io.n.y+0.1 - (Lo.s.y-0.1)
  thickarrow from Syo.s down Syo.s.y-Lo.y then to Lo.e
  thickarrow from Lo.w to (SLo,Lo.w) then to SLo.s
  ] with .nw at last [].sw+(0,-0.5)

Eqns: [ {"svg_it(r)" above ljust}
  ex = textht*2/3
  define(`DDt',`svg_frac(svg_it(d):1*ex,svg_it(dt):2*ex)')
  arrow
S: circle
  "svg_it(-)" below rjust at S.s
  arrow <- down linewid/2 from S.s
  box ht bh wid bw "svg_it(K)"
  arrow <- down linewid/2
  line right linewid
  {"svg_hat(svg_bf(x))" at last line.c above }
Obs:box wid linewid*5 ht boxht*5/4
  [ DDt; "svg_hat(svg_bf(x)) svg_it(= (A-LC)) svg_hat(svg_bf(x))
   svg_it(+ Bu + L)svg_bf(y)" wid 1.5 ljust ] at Obs
  "svg_it(Observer)" above ljust at Obs.sw
  arrow <- right linewid/2 from 3/4<Obs.se,Obs.ne>
  line to (Here,S)
  {"svg_it(u)" above at Here+(linewid/2,0)}
  arrow from S.e to Here+(linewid,0)
Plant: box wid boxwid*3/2 ht boxht*5/4
  [ DDt; "svg_bf(x) svg_it(= A) svg_bf(x) svg_it(+ Bu)" wid 0.8 ljust
  "svg_bf(y) svg_it( = C) svg_bf(x)" wid 0.6 ljust \
    at last "".w + (0,-textht*2) ] at Plant+(0,0.05)
  "svg_it(Plant)" above ljust at Plant.sw
  arrow right from Plant.e
  "svg_it(y)" above rjust at Here+(0,2pt__)
  move to last arrow.c 
  line to (Here, 1/4<Obs.se,Obs.ne>)
  arrow to (Obs.e,Here)
  ] with .nw at last [].sw+(0,-0.1)
  "(b) Plant with feedback from a full-order observer" \
    below ljust at Eqns.sw+(0,-5pt__)

# . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . #

Multiblock: [
boxht = 0.4
boxwid = boxht

define  summer { circle
  {line from last circle.nw to last circle.se
  line from last circle.sw to last circle.ne
  "svg_it($1)" at 0.6 between last circle and last circle.n
  "svg_it($2)" at 0.6 between last circle and last circle.s
  "svg_it($3)" at 0.6 between last circle and last circle.e
  "svg_it($4)" at 0.6 between last circle and last circle.w }
}

  arrow "svg_it(E`'svg_sub(1))" above
S1: summer(,-,,+)
  linewid = boxwid/2
  arrow "svg_epsilon" above
  [box "svg_it(H)svg_sub(1)"; arrow; box "svg_it(H)svg_sub(2)"]
  arrow
S2: summer(-,,,+)
  arrow
T: [box "svg_it(H)svg_sub(3)"; arrow; box "svg_it(H)svg_sub(4)"]
  line
Y: Here
  arrow
  "svg_it(S)svg_sub(1)" above
R1: box "svg_it(R)svg_sub(1)" at (T.x,T.y+boxht*3/2)
  arrow from Y to (Y,R1) then to R1.e
  arrow from R1.w to (S2,R1) then to S2.n
  "svg_it(n)svg_sub(1)" ljust at S2.n+(0,boxht/2)
  left
Rf: [box "svg_it(R)svg_sub(2)"; arrow; box "svg_it(R)svg_sub(3)"] \
     at ((S1.x+T.x)/2,T.y-boxht*3/2)
  arrow from T to (T,Rf) then to Rf.e
  arrow from Rf.w to (S1,Rf) then to S1.s
  "svg_it(n)svg_sub(2)" at S1.s+(0,-boxht/2) ljust
] with .nw at Eqns.sw + (0,-0.3)
  "(c) A multiblock example" below ljust at Multiblock.sw+(0,-5pt__)

# . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . #

Nonlinear: [boxwid = boxwid*3/2; boxht = boxht*3/2
  thicklines_
  boxwid = boxwid*0.6
  boxht = boxht/2
R: box "reference" "svg_it(R)"
  arrow right linewid*4/3
  {"svg_it(y)svg_sub(c)[ref]" at last arrow+(0,textht/3) above }
Gh: box "\"i`'nverse\"" "of svg_it(G)"
   arrow from Gh.s down "svg_it(y)svg_sub(m)[ref]" ljust
E: circle
   arrow from E.e right "svg_it(e)" above
   box "stabilizer" "svg_it(K)"
   arrow "svg_delta`'u" above
D: circle
   line from Gh.e to (D,Gh.e) "svg_it(u)[ref]" above
   arrow to D.n
   arrow from D.e right "svg_it(u)" above
G: box "plant" "svg_it(G)"
   arrow <- from G.n up boxht/2; "disturbance svg_it(z)" above
   arrow right from G.e + (0,boxht/4); "svg_it(y)svg_sub(c)" wid 0.2 ljust
   arrow right from G.e + (0,-boxht/4); "svg_it(y)svg_sub(m)" ljust
   move to last arrow.c
   arrow down Here.y-G.s.y+boxht*2/3 then left Here.x-E.x then to E.s
   "svg_it(-)" rjust below
   arrow <- down from R.s
   "svg_it(W) control input" at Here - (0,0.1)
UL:R.nw +(-boxht/2,boxht/2)
UR:(D.e,UL) + (0.1,0)
   line dashed from UL to UR then to (UR,G.s+(0,-boxht*3/2))
   line dashed to (Gh.w,Here) "Controller" above
   line dashed to (Here,Gh.s+(0,-boxht/2))
   line dashed to (UL,Here) then to UL
] with .nw at last [].sw + (0,-0.3)
  "(d) Nonlinear feedforward (for performance) and small-signal feedback
     (for stability)" below ljust at Nonlinear.sw+(0,-5pt__)

#print PID.n.y - Nonlinear.s.y
command "</g>"
.PE
