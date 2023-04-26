.PS
# EyeDPV.m4
gen_init

define(`eye',`[ u = $1; v = 0.47*u; w = 0.25*u
  shade(1,
    arc thick 0 from (u/2,0) to (-u/2,0) with .c at (0,-u/3)
    arc thick 0 to (u/2,0) with .c at (0,u/3) )
  circle diam v fill_(0.24) at (0,0)
  circle diam w fill_(0) at (0,0)
  circle thick 0 diam last circle.diam/2 fill_(1) at last circle.nw
  circle diam last circle.diam-lthick at last circle outlined graystring(0.9)
  ] ')

  skale = 2/3
  Bx: box wid 11*skale ht 8.5*skale fill_(0) at (0,0)
  C[0]: Bx.se; C[1]: Bx.nw
  d[5] = 0.92*Bx.ht
  d[4] = 0.78*Bx.ht
  d[3] = 0.62*Bx.ht
  d[2] = 0.40*Bx.ht
  d[1] = 0.25*Bx.ht
  ane = atan2(Bx.ht,Bx.wid)*rtod_
  dax = 360/64
  da = 1
  for a=-int(ane/dax)*dax to 180-ane by dax do {
    T1: intersect_(Bx.ne,C[(a>ane)],Bx,(Rect_(1,a+da)))
    T2: intersect_(Bx.ne,C[(a>ane)],Bx,(Rect_(1,a)))
    line outlined "white" shaded "white" from Bx to T1 then to T2 then to Bx
    line outlined "white" shaded "white" from Bx to T1*(-1) \
      then to T2*(-1) then to Bx
    }
  for i=5 to 2 by -1 do {
    C[i]: circle diam d[i] fill_(0) at Bx
    for a=0 to 359 by dax do {
      T1: Rect_(d[i]/2,a)
      T2: Rect_(d[i]/2,a-da*2)
      nx = int(distance(T1,T2)/lthick*1.5+0.5)
      for h = 1 to nx-1 do {
        spline 0.55 outlined "white" from h/nx between T1 and T2 \
          to 0.8 between Bx and T2 then to (Rect_(d[i]/4,a+31)) }
      }
    }
  C[1]: circle thick 2 diam d[1] at Bx fill_(0.1)
  eye(d[1]-4bp__) at (0,0)
  for a=0 to 359 by dax do {
    T1: (Rect_(d[1]/2-1bp__,a))
    T2: (Rect_(d[1]/2-1bp__,a+dax/2))
    line thick 0.4 from T1 to T2 then to 0.5 between Bx and T2 \
      then to 0.5 between Bx and T1 then to T1 shaded "white"
    }

.PE
