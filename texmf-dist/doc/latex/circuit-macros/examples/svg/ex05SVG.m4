.PS
# ex05SVG.m4
darrow_init

Kalman: [
  fillval = 0.8

  boxht = 0.35
  boxwid = 1.5*boxht
  dx = boxht/5
  circlerad = boxht*3/8
  extlen=4*dx
  indel = boxht/3
  define(`dlthick',dlthick*3/4)

define(`overbar',`line right textht*0.8 \
  with .c at last box.c + ((`$1')*textht,0.7*textht)')

COb: box fill_ "CO"; overbar(0.5)
CO:box fill_ with .nw at last box.se+(dx,-dx) "CO"
CbOb: box fill_ with .nw at last box.se+(dx,-dx) "CO"
  overbar(-0.5); overbar(0.5)
CbO: box fill_ with .nw at last box.se+(dx,-dx) "CO"; overbar(-0.5)

  dline(from CbO.s down_ dx,,t,,!-)
  dright
{Sum: circle invis at (CO,Here)}
  darrow(to Sum.e)

SW: (COb.w,Sum.s)+(-3*dx-extlen/2,-dx)
NE: (CbO.e,COb.n)+(dx,dx)
  right_; 
SB: shadebox(box wid NE.x-SW.x ht NE.y-SW.y with .sw at SW)

U: COb.w-(3*dx+extlen,0)
  {"svg_it(U)" wid 0.1 rjust at U}
  dline(from U right_ extlen+dx,,t,,|-)
TU: dtee(R)
  {darrow(to COb.w,t)}
  dline(to (Here,CO),t,t)
{Dum: circle invis at (Here,Sum)}
  dtee(L)
  {darrow(to CO.w,t)}
{D: box "D" wid boxwid/2 ht boxwid/2 at 0.5<Here,Dum.n>}
  darrow(to D.n,t)
  darrow(from D.s to Dum.n,,,,,,!-)

  dline(up_ from CO.n to (CO,COb)-(0,indel),,t,,!-)
  dleft; darrow(to (COb.e,Here))

  dline(up_ from CbOb.n to (CbOb,COb),,t,,!-)
  dleft; darrow(to COb.e)

  dline(from CbO.n-(indel,0) up_ CbOb.y-CbO.n.y,,t,,!-)
  dleft; darrow(to CbOb.e)

  dline(up_ from CbO.n to (CbO,CO),,t,,!-)
  dleft
  dline(to (CbOb.w,Here)); darrow(to CO.e)

  dline(up_ from CbO.n+(indel,0) to (CbO,COb)+(indel,indel),,t,,!-)
  dleft; darrow(to (COb.e,Here))

  darrow(from CO.s to Sum.n,,,,,,!-)

  darrow(left_ from Sum.w to Dum.e)
  dline(from Dum.w to (SB.w-(0.1,0),Dum)); darrow(to (U,Here))
    {"svg_it(Y)" rjust}
  move left 0.23

  circle at Sum
  circle at Dum
  ]
Coxeter: [
# Coxeter.m4

  customlinethick = 1.5

  linethick = customlinethick
  define(`dotrad_',`(3/2*linethick pt__)')

  Orig: (0,0)
  for i=0 to 4 do { P[i]: dot(at (i*linewid,0)) }
  line from Orig to P[4]
  P[-1]: dot(at (Rect_(linewid, 120))); line to Orig
  P[-2]: dot(at (Rect_(linewid,-120))); line to Orig

 Pa: dot(at P[4]+(linewid,0));         "svg_it(a)" at last [].n above
  arrow from P[4] to Pa chop linewid/4
 Pd: dot(at Pa+(linewid,0));           "svg_it(d)" at last [].w rjust
 Pe: dot(at Pd+(linewid,0));           "svg_it(e)" at last [].n above
 Pf: dot(at Pe+(linewid,0));           "svg_it(f)" at last [].n above
 Pb: dot(at Pd+(Rect_(linewid,120)));  "svg_it(b)" at last [].w rjust
 Pc: dot(at Pd+(Rect_(linewid,-120))); "svg_it(c)" at last [].w rjust
  line from Pb to Pd then to Pc
  line from Pd to Pf

  define(`customarc',
   `pushdef(`dfillcolor',`0.7,0.7,0.7') linethick_(0.4); dnl
    Darc(`$1',linewid, (`$2')*dtor_, (`$3')*dtor_,
      thick=linewid/6; wid=linewid*0.3; ht=linewid/6; ends=<->)dnl
    linethick_(customlinethick); popdef(`dfillcolor')')

  customarc((linewid,-linewid/3), 25,155)
   "svg_it(d)" at (linewid,linewid*2/3)
  customarc((2*linewid,-linewid/3), 25,155)
   "svg_it(e)" at (2*linewid,linewid*2/3)
  customarc((3*linewid,-linewid/3), 25,155)
   "svg_it(f)" at (3*linewid,linewid*2/3)
  customarc(Orig,130,230);                  "svg_it(a)" at (Rect_(linewid,180))
  customarc(Orig, 10,110);                  "svg_it(b)" at (Rect_(linewid, 60))
  customarc(Orig,-110,-10);                 "svg_it(c)" at (Rect_(linewid,-60))

  ] with .sw at Kalman.se+(15bp__,0)
.PE
