.PS
# control.m4
gen_init
  linewid = linewid*0.8
  circlerad = 0.35/2
  bw = boxwid/2
  bh = boxht/2

# . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . #

PID: [
  {"$r(s)$" above ljust}
  arrow
S1: circle
  line right "$e(s)$" above
  { arrow right ; box ht bh wid bw "$K_P$"
    arrow right linewid-circlerad ; S2: circle }
  { arrow up linewid then right ; box ht bh wid bw "$K_D s$"
    arrow to (S2,Here) then to S2.n }
  { arrow down linewid then right ; box ht bh wid bw "$K_I/s$"
    arrow to (S2,Here) then to S2.s }
  arrow right from S2.e "$u(s)$" above
  box "$G(s)$"
  arrow right ; "$y(s)$" above rjust at Here+(0,2pt__)
  arrow down boxht*5/4 from last arrow.c then left last arrow.c.x-S1.x \
    then to S1.s
  "$-\;$" below rjust
]
  "(a) $PID$ control" below ljust at PID.sw+(0,-5pt__)

# . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . #

# https://tex.stackexchange.com/questions/575592/how-to-create-a-controls-system-diagram
Observer: [
  define(`thickarrow',`arrow thick 3 wid 7bp__')
  define(`thickline',`line thick 3')
  fillval = 0.6
  boxwid = 0.3
  boxht = 0.4
  circlerad = 0.1
  {"$r$" above ljust}
R: arrow
S: circle fill
  {"$-$" below ljust at S.s; "$+$" above rjust at S.w+(2bp__,0)}
{ OLP: box invis fill 0.9 wid 3.1 ht 1.4 with .nw at Here+(0.3,boxht*5/4)
  "\sf plant" at OLP.sw above ljust }
U: arrow right 0.4
  {"$u$" at last arrow+(2bp__,0) above }
Bp: box fill "$B$" 
  thickarrow right 0.4 
Sp: circle fill
  {"$\;+$" below ljust at Sp.s; "$+$" above rjust at Sp.w+(2bp__,2bp__)}
  thickarrow right 0.4
  {"`$\dot{\mathbf x}$'" at last arrow + (0,7bp__)} 
Ip: box fill "$I/s$"
  thickarrow right 1
  {"$\mathbf x$" at last arrow + (0,7bp__) }
Cp: box fill "$C$"
# print Cp.e.x - Bp.w.x + 0.2
  thickline right 0.4
Yp: thickarrow
  {"$\mathbf y$" at last arrow + (0,7bp__) }
Ap: box fill "$A$" with .n at Ip.s+(0,-boxht/2) 
  thickarrow <- from Ap.e right 0.4 then up Ip.y-Ap.y
  thickarrow from Ap.w to (Sp,Ap) then to Sp.s
# print OLP.n.y-Ap.s.y+0.1
#
K: box fill "$K$" at Ap + (0,-boxht*3/2)
  arrow from K.w to (S,K) then to S.s
  {OBS: box invis fill 0.9 wid 4.3 ht 1.8 with .nw at (S.w,K.s)-(0.1,0.1)
   "\sf observer" at OBS.sw ljust above } 
Io: box fill "$I/s$" at K + (0,-boxht*3/2)
  thickarrow <- from Io.w left 0.4
  {"`$\dot{\hat{\mathbf x}}$'" at last arrow + (0,7bp__)} 
Sxo: circle fill
  {"$\;+$" below ljust at Sxo.s; "$+$" above rjust at Sxo.w+(2bp__,2bp__)}
  thickarrow <- left 0.4
SLo: circle fill
  {"$\;+$" below ljust at SLo.s; "$+$" above rjust at SLo.w+(2bp__,2bp__)}
  thickarrow <- left 0.4
Bo: box fill "$B$"
  arrow from 1/4 between U.start and U.end up boxht \
    then left 2*boxht then down Bp.y-Bo.y+boxht then to Bo.w
Ao: box fill "$A$" with .n at Io.s+(0,-boxht/2) 
  thickline from Io.e right 0.4
  {thickarrow <-> from K.e to (Here,K.e) then to (Here,Ao) then to Ao.e
   thickarrow from Ao.w to (Sxo,Ao.w) then to Sxo.s }
Xhat: Here
Co: box fill "$C$" at (Cp,Here)
  thickarrow right 0.4
  {"$\hat{\mathbf y}$" at last arrow + (0,7bp__) }
  { thickarrow from Xhat to Co.w }
  {"$\hat{\mathbf x}$" at last arrow + (0,7bp__) }
Syo: circle fill
  {"$\;+$" above ljust at Syo.n; "$-$" below rjust at Syo.w+(2bp__,-2bp__)}
  thickarrow <- from Syo.n to (Syo,Cp)
Lo: box fill "$L$" with .n at Ao.s+(0,-boxht/2) 
# print Io.n.y+0.1 - (Lo.s.y-0.1)
  thickarrow from Syo.s down Syo.s.y-Lo.y then to Lo.e
  thickarrow from Lo.w to (SLo,Lo.w) then to SLo.s
] with .nw at last [].sw+(0,-0.3)
  "(b) Single-input plant with feedback from a full-order observer" \
    below ljust at Observer.sw+(0,-5pt__)

# . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . #

ifelse(0,1,`
Observer: [ {"$r$" above ljust}
  arrow
S: circle
  "$-\;$" below rjust at S.s
  arrow <- down linewid/2 from S.s
  box ht bh wid bw "$K$"
  arrow <- down linewid/2
  line right linewid "$\hat x$" above
Obs:box wid linewid*5 ht boxht*5/4 \
    "$\frac{d}{dt}\hat x = (A{-}LC)\hat x + B u + L y$" 
  "\sl Observer" above ljust at Obs.sw
  arrow <- right linewid/2 from 3/4<Obs.se,Obs.ne>
  line to (Here,S)
  {"$u$" above at Here+(linewid/2,0)}
  arrow from S.e to Here+(linewid,0)
Plant: box wid boxwid*3/2 ht boxht*5/4 \
    "$\frac{d}{dt} x=Ax+Bu$" "$\quad y=Cx$\hfill\hbox{}"
  "\sl Plant" above ljust at Plant.sw
  arrow right from Plant.e
  "$y$" above rjust at Here+(0,2pt__)
  move to last arrow.c 
  line to (Here, 1/4<Obs.se,Obs.ne>)
  arrow to (Obs.e,Here)
] with .nw at last [].sw+(0,-0.5)
')

# . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . #

ifelse(1,1,`
Multiblock: [
boxht = 0.4
boxwid = boxht
circlerad = boxht*0.4

define  summer { [ C: circle
  line from C.nw to C.se
  line from C.sw to C.ne
  "$$1$" at C.n+(0,1bp__) below
  "$$2$" at C.s-(0,1bp__) above
  "$$3$" at C.e+(1bp__,0) rjust
  "$$4$" at C.w-(1bp__,0) ljust ]
}
define doublebox {[box "$$1$"; arrow; box "$$2$"]}

  arrow "$E_1$" above
S1: summer(,-,,+)
  linewid = boxwid/2
  arrow "$\epsilon$" above
  doublebox(H_1,H_2)
  arrow
S2: summer(-,,,+)
  arrow
T: doublebox(H_3,H_4)
  line
Y: Here
  arrow
  "$S_1$" above
R1: box "$R_1$" at (T.x,T.y+boxht*5/4)
  arrow from Y to (Y,R1) then to R1.e
  arrow from R1.w to (S2,R1) then to S2.n
  "$n_1$" ljust at S2.n+(0,boxht/2)
  left
Rf: doublebox(R_2,R_3) at ((S1.x+T.x)/2,T.y-boxht*5/4)
  arrow from T to (T,Rf) then to Rf.e
  arrow from Rf.w to (S1,Rf) then to S1.s
  "$n_2$" at S1.s+(0,-boxht/2) ljust
] with .nw at Observer.sw + (0,-0.3)
  "(c) A multiblock example" below ljust at Multiblock.sw+(0,-3pt__)
')

# . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . #

Nonlinear: [boxwid = boxwid*3/2; boxht = boxht*3/2
  thicklines_
  scale = 0.8
  circlerad = 0.3/2
R: box "reference" "$R$"
   arrow right linewid*4/3 "${y_c}_{\hbox{\scriptsize ref}}$" above
Gh: box "```inverse'''" "$\hat G$"
   arrow from Gh.s down "${y_m}_{\hbox{\scriptsize ref}}$" ljust
E: circle
   arrow from E.e right "$e$" above
   box "stabilizer" "$K$"
   arrow "$\delta u$" above
D: circle
   line from Gh.e to (D,Gh.e) "$u_{\hbox{\scriptsize ref}}$" above; corner
   arrow to D.n
   arrow from D.e right "$u$" above
G: box "plant" "$G$"
   arrow <- from G.n up boxht/2 
   "disturbance $z$" above
   arrow right from G.e + (0,boxht/4)
   "$y_c$" ljust
   arrow right from G.e + (0,-boxht/4)
   "$y_m$" ljust
   move to last arrow.c
   arrow down Here.y-G.s.y+boxht*2/3 then left Here.x-E.x then to E.s
   "$-$" at Here + (-0.15,-0.1)
   arrow <- down from R.s
   "$W$ control input" at Here - (0,0.1)
UL:R.nw +(-boxht/2,boxht/2)
UR:(D.e,UL) + (0.1,0)
   line dashed from UL to UR then to (UR,G.s+(0,-boxht*3/2))
   line dashed to (Gh.w,Here) "Controller" above
   line dashed to (Here,Gh.s+(0,-boxht/2))
   line dashed to (UL,Here) then to UL
] with .nw at last [].sw + (0,-0.2)
  "(d) Nonlinear feedforward (for performance) and small-signal feedback
     (for stability)" below ljust at Nonlinear.sw+(0,-5pt__)

#print PID.n.y - Nonlinear.s.y
.PE
