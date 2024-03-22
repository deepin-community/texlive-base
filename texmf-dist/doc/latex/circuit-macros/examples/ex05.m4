.PS
# ex05.m4
darrow_init
ifelse(ifpstricks(T)`'ifpgf(T)`'ifsvg(T)`'ifmpost(T),T,`

Kalman: [
  fillval = 0.8              # environmental variable
  linethick = 1              # slightly thicker for better screen pdf

  dx = boxht/5               # diagram parameters wrt scaled env variables
  circlerad = boxht*3/8
  extlen=4*dx
  indel = boxht/3

# Replacement for \bar, see
# https://tex.stackexchange.com/questions/22100/the-bar-and-overline-commands
latexcommand(\newcommand{\ols}[1]{%
\mskip.5\thinmuskip\overline{\mskip-.5\thinmuskip {#1} \mskip-.5\thinmuskip}%
\mskip.5\thinmuskip})

COb: box fill_ "C$\ols{\mbox{O}}$"
CO:box fill_ with .nw at last box.se+(dx,-dx) "CO"
CbOb: box fill_ with .nw at last box.se+(dx,-dx) \
  "$\ols{\mbox{C}}$$\ols{\mbox{O}}$"
CbO: box fill_ with .nw at last box.se+(dx,-dx) "$\ols{\mbox{C}}$O"

  dline(from CbO.s down_ dx,,t,,!-)
  dright
{Sum: circle invis at (CO,Here)}
  darrow(to Sum.e)

SW: (COb.w,Sum.s)+(-3*dx-extlen/2,-dx)
NE: (CbO.e,COb.n)+(dx,dx)
  right_; shadebox(box wid NE.x-SW.x ht NE.y-SW.y with .sw at SW)

U: "\bf u$\,$" rjust at COb.w-(3*dx+extlen,0)
  dline(right_ extlen+dx,,t,,|-)
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
  darrow(to CO.e)

  dline(up_ from CbO.n+(indel,0) to (CbO,COb)+(indel,indel),,t,,!-)
  dleft; darrow(to (COb.e,Here))

  darrow(from CO.s to Sum.n,,,,,,!-)

  darrow(left_ from Sum.w to Dum.e)
  darrow(from Dum.w to (U,Dum))
    {"{\bf y$\,$}" rjust}
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

 Pa: dot(at P[4]+(linewid,0));         "$a$" at last [].n above
  arrow from P[4] to Pa chop linewid/4
 Pd: dot(at P[0]+(0,-2*linewid));      "$d$" at last [].w rjust
 Pe: dot(at Pd+(linewid,0));           "$e$" at last [].n above
 Pf: dot(at Pe+(linewid,0));           "$f$" at last [].n above
 Pb: dot(at Pd+(Rect_(linewid,120)));  "$b$" at last [].w rjust
 Pc: dot(at Pd+(Rect_(linewid,-120))); "$c$" at last [].w rjust
  line from Pb to Pd then to Pc
  line from Pd to Pf

  define(`customarc',
   `pushdef(`dfillcolor',`0.7,0.7,0.7') linethick_(0.4); dnl
#   Darc(`$1',linewid, (`$2')*dtor_, (`$3')*dtor_,
#     thick=linewid/6; wid=linewid*0.3; ht=linewid/6; ends=<->)dnl
    Darc(,centre=`$1';rad=linewid;startdeg= (`$2');enddeg=(`$3');
      thick=linewid/6; wid=linewid*0.3; ht=linewid/6; ends=<->)
    linethick_(customlinethick); popdef(`dfillcolor')')

  customarc((linewid,-linewid/3), 25,155)
   "$d$" at (linewid,linewid*2/3)
  customarc((2*linewid,-linewid/3), 25,155)
   "$e$" at (2*linewid,linewid*2/3)
  customarc((3*linewid,-linewid/3), 25,155)
   "$f$" at (3*linewid,linewid*2/3)
  customarc(Orig,130,230);                  "$a$" at (Rect_(linewid,180))
  customarc(Orig, 10,110);                  "$b$" at (Rect_(linewid, 60))
  customarc(Orig,-110,-10);                 "$c$" at (Rect_(linewid,-60))

  ] with .sw at Kalman.se+(15bp__,0)
[
  linethick = 5
  Darrow(right_ Coxeter.wid,
    thick=0.3;wid=0.55;ht=0.55;ends=<->; innershade=(0,1,1);outline=(0,0,1))
  ] with .sw at Coxeter.nw+(0,0.3)

',` "This diagram requires LaTex" ')
.PE
