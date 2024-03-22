.PS
# Views.m4
threeD_init

sinclude(Lettering.m4def)
sinclude(../Lettering.m4def)
Letter_init

define(`textwidth',5.5)

`# Perspective transformations
#        mult4( matrix, vector, vector )
 define mult4 { for i=1 to 4 do {
                   $3[i] = 0
                   for j=1 to 4 do { $3[i] = $3[i] + $1[(j-1)*4+i]*$2[j] }}}
#        eye4 make unit matrix
 define eye4 { for i=1 to 4 do { for j=1 to 4 do { $1[(j-1)*4+i] = 0 }}}
#        rotx4( theta, vector, vector )
 define rotx4 { $3[1] = $2[1]
                 $3[2] = cos($1)*$2[2]-sin($1)*$2[3]
                 $3[3] = sin($1)*$2[2]+cos($1)*$2[3]
                 $3[4] = $2[4] }
#        roty4( theta, vector, vector )
 define roty4 { $3[1] = cos($1)*$2[1]-sin($1)*$2[3]
                 $3[2] = $2[2]
                 $3[3] = sin($1)*$2[1]+cos($1)*$2[3]
                 $3[4] = $2[4] }
#        rotz4( theta, vector, vector )
 define rotz4 { $3[1] = cos($1)*$2[1]-sin($1)*$2[2]
                 $3[2] = sin($1)*$2[1]+cos($1)*$2[2]
                 $3[3] = $2[3]
                 $3[4] = $2[4] }
#        add4( vector, vector, vector )
 define add4 {
    if (($1[4]==0) && ($2[4]==0)) then {
           for i=1 to 4 do { $3[i] = $1[i]+$2[i] } } \
    else { if $1[4]==0 then { for i=1 to 4 do { $3[i] = $1[i] } } \
    else { if $2[4]==0 then { for i=1 to 4 do { $3[i] = $2[i] } } \
    else { for i=1 to 3 do { $3[i] = $1[i]/$1[4]+$2[i]/$2[4] }; $3[4] = 1 }
    } } }

#        vec4( x,y,z, vector )
 define vec4  { $4[1] = $1; $4[2] = $2; $4[3] = $3; $4[4] = 1 }
#        copy4( vector, vector )
 define copy4 { $2[1] = $1[1]; $2[2] = $1[2]; $2[3] = $1[3]; $2[4] = $1[4] }
#        pr4( vector, label ) # projected vector (see pr below)
 define pr4 { if $1[4]==0 then { print "Divide by zero" } \
              else { $2: pr($1[1]/$1[4],$1[2]/$1[4],$1[3]/$1[4]) }}

 define print4 { print sprintf("%g,%g,%g,%g",$1[1],$1[2],$1[3],$1[4]) }
'
# Basic dimensions
  u = 1*27/28.7*0.7 ifdef(`xsnotes',`*1.14')
  a = 2*u
  b = 1*u
  c = 1.2*u
  d = c*1/2
  e = c/3
  f = u*1/4
  r = c/3

  visibleth = 1.2
  dimensionth = 0.4
  hiddenth = dimensionth
  linethick_(visibleth)

#   Iso diagram viewing angle
dazim = 45
delev = -30
setview(dazim,delev)

define(`pr',`(project(`$3',`$1',`$2'))')
define(`xpnd',$1)

  define(`X0', `0,0,0')
  define(`X1', `0,b,0')
  define(`X2', `a,b,0')
  define(`X3', `a,0,0')
  define(`X4', `0,0,c')
  define(`X5', `0,b,c')
  define(`X6', `a,b,c')
  define(`X7', `a,0,c')
  define(`X8', `-e,0,c/2-f/2')
  define(`X9', `-e,d,c/2-f/2')
  define(`X10',`0,d,c/2-f/2')
  define(`X11',`0,0,c/2-f/2')
  define(`X12',`-e,0,c/2+f/2')
  define(`X13',`-e,d,c/2+f/2')
  define(`X14',`0,d,c/2+f/2')
  define(`X15',`0,0,c/2+f/2')
  define(`X16',`0,b*1.25,c')
  define(`X17',`a/4,b*1.25,c')
  define(`X18',`a/4,b,c')
  define(`X19',`0,b,c/2')
  define(`X20',`a/4,b,c/2')
  define(`xn',20)

  define(`ncirc',18)
  dt = 360/ncirc
  tx = a*2/3; ty = b; tz = c/2
  define(`TR',`tx,ty,tz')

define(`loopX',`ifelse(eval(`$1'>=0),1,
  `define(`X'eval(`$1'+xn+1),`tx+r*cosd(`$1'*dt),ty,tz+r*sind(`$1'*dt)')
  loopX(eval($1-1))')')

  loopX(ncirc)

define(`loopTT',`ifelse(eval(`$1'>=0),1,
 `TT[`$1']: ifelse(`$3',0,`pr(X$2)',`Y$2')
  loopTT(eval(`$1'-1),eval(`$2'-1),`$3')')')

define(`drawobj',`
  line from pr(xpnd(`$1'0)) to pr(xpnd(`$1'1)) to pr(xpnd(`$1'2))
  line to pr(xpnd(`$1'3)) to pr(xpnd(`$1'0))
  line from pr(xpnd(`$1'0)) to pr(xpnd(`$1'11)) to pr(xpnd(`$1'8)) \
    to pr(xpnd(`$1'12)) to pr(xpnd(`$1'13))
  line to pr(xpnd(`$1'9)) to pr(xpnd(`$1'8))
  line from pr(xpnd(`$1'13)) to pr(xpnd(`$1'14)) to pr(xpnd(`$1'10))
  line to pr(xpnd(`$1'9))
  line from pr(xpnd(`$1'10)) to pr(xpnd(`$1'11))
  ifelse(`$2',0,
   `shade(0.92,line width 0 from pr(xpnd(`$1'1)) to pr(xpnd(`$1'5)) \
      to pr(xpnd(`$1'6)) to pr(xpnd(`$1'2)) to pr(xpnd(`$1'1)))
    perspective(X1,Z)
    ellipse fill_(0.7) ht 2*r*tmx[2]/tmx[4]/b wid 2*r at pr(TR)
    shade(1,line width 0 from pr(xpnd(`$1'19)) to pr(xpnd(`$1'16)) \
      to pr(xpnd(`$1'17)) to pr(xpnd(`$1'20)) to pr(xpnd(`$1'19)))
    shade(0.7,line width 0 from pr(xpnd(`$1'0)) to pr(xpnd(`$1'1)) \
      to pr(xpnd(`$1'2)) to pr(xpnd(`$1'3)) to pr(xpnd(`$1'0)))
    shade(0.6,line width 0 from pr(xpnd(`$1'0)) to pr(xpnd(`$1'1)) \
      to pr(xpnd(`$1'19)) to pr(xpnd(`$1'16)) to pr(xpnd(`$1'4)) \
      to pr(xpnd(`$1'0)))
    shade(0.9,line width 0 from pr(xpnd(`$1'13)) to pr(xpnd(`$1'14)) \
      to pr(xpnd(`$1'10)) to pr(xpnd(`$1'9)) to pr(xpnd(`$1'13)))
    shade(0.7,line width 0 from pr(xpnd(`$1'8)) to pr(xpnd(`$1'9)) \
      to pr(xpnd(`$1'10)) to pr(xpnd(`$1'11)) to pr(xpnd(`$1'8)))
    shade(0.6,line width 0 from pr(xpnd(`$1'8)) to pr(xpnd(`$1'9)) \
      to pr(xpnd(`$1'13)) to pr(xpnd(`$1'12)) to pr(xpnd(`$1'8)))
    A: line invis from pr(xpnd(`$1'4)) to pr(xpnd(`$1'0))
    B: line invis from pr(xpnd(`$1'12)) to pr(xpnd(`$1'13))
    line from Intersect_(A,B) to pr(xpnd(`$1'4))
    line from pr(xpnd(`$1'4)) to pr(xpnd(`$1'16))',

   `A: line invis from pr(xpnd(`$1'4)) to pr(xpnd(`$1'16))
    B: line invis from pr(xpnd(`$1'14)) to pr(xpnd(`$1'13))
    line from Intersect_(A,B) to pr(xpnd(`$1'16))
    line thick dimensionth from pr(xpnd(`$1'2)) to -0.5 between \
       pr(xpnd(`$1'2)) and pr(xpnd(`$1'1)) chop 0.05
    line thick dimensionth from pr(xpnd(`$1'3)) to -0.5 between \
       pr(xpnd(`$1'3)) and pr(xpnd(`$1'0)) chop 0.05
    line thick dimensionth from pr(xpnd(`$1'5)) to -1.0 between \
       pr(xpnd(`$1'5)) and pr(xpnd(`$1'1)) chop 0.05
    line thick dimensionth from pr(xpnd(`$1'4)) to -1.0 between \
       pr(xpnd(`$1'4)) and pr(xpnd(`$1'0)) chop .1 chop 0.05
    loopTT(ncirc,eval(xn+ncirc+1),`$2')
    fitcurve(TT,ncirc)
    ')
  line from pr(xpnd(`$1'16)) to pr(xpnd(`$1'19)) \
    to pr(xpnd(`$1'20)) to pr(xpnd(`$1'17)) to pr(xpnd(`$1'16))
  line from pr(xpnd(`$1'19)) to pr(xpnd(`$1'1))
  A: line invis from pr(xpnd(`$1'5)) to pr(xpnd(`$1'6))
  B: line invis from pr(xpnd(`$1'17)) to pr(xpnd(`$1'20))
  line from Intersect_(A,B) to pr(xpnd(`$1'6))
  line from pr(xpnd(`$1'6)) to pr(xpnd(`$1'2))
  ')

  dp = 1.0*a
  s4f = 1.6
  fth = 180*dtor_

#        perspective(x,y,z,position)
`define perspective {
   vec4($3,$1,$2,tmp)
   roty4(180*dtor_,tmp,tmx)
   rotz4(90*dtor_,tmx,tmp)
   rotx4(-90*dtor_,tmp,tmx)
   roty4(-45*dtor_,tmx,tmp)
   tmp[4] = tmp[3]/dp+tmp[4]
   rotx4(55*dtor_,tmp,tmx)
   $4: (tmx[1]/tmx[4],tmx[2]/tmx[4])
   }
'
lu = 0.1/6 * 0.8

#        Handle forward referencing of lettering guide line lengths
  nguides = 0
  sh "touch Views.dms"
  for i=1 to 10 do { w[i] = 1 }
  copy "Views.dms"
  sh "rm -f Views.dms"

define(`guideletter',`[ nguides += 1
  line thick grthick from (0,0) right w[nguides]*lu outlined "lightgridgray"
  line thick grthick from (0,-6*lu) right w[nguides]*lu outlined "lightgridgray"
  T: $1 with .nw at (0,0)
  print sprintf("w[%g]=%g",nguides,T.wid/lu) >> "Views.dms"
]')

define(`pfront',`(`$1',`$2')')
define(`ptop',`(`$1',`$3')')
define(`pside',`(-(`$3'),`$2')')
  sep = 0.6*u
define(`centreline',`rpoint_(ifelse(`$1',,`to rvec_(linewid,0)',`$1'))
  line thick dimensionth to rvec_(rp_len/2-.08,0)
  move to rvec_(.03,0)
  line thick dimensionth to rvec_(.1,0)
  move to rvec_(.03,0)
  line thick dimensionth to rvec_(rp_len/2-.08,0)')

Orthographics: [
Top: [
  line from ptop(X1) to ptop(X5) to ptop(X6) to ptop(X2) to ptop(X1)
  line from ptop(X17) to ptop(X20) to ptop(X19)
  line from ptop(X10) to ptop(X9) to ptop(X13) to ptop(X14)
  circle rad r at ptop(TR)
  centreline(from ptop(TR)+(0,r) down 2*r chop -.1)
  centreline(from ptop(TR)+(-r,0) right 2*r chop -.1)
  W: ptop(X9)
  E: ptop(X2)
  ]
Front: [
  line from pfront(X0) to pfront(X1) to pfront(X2) to pfront(X3) to pfront(X0)
  line from pfront(X0) to pfront(X8) to pfront(X9) to pfront(X10)
  line from pfront(X19) to pfront(X16) to pfront(X17) to pfront(X20)
  line thick hiddenth dashed from pfront(TR)+(-r,0) down b
  line thick hiddenth dashed from pfront(TR)+( r,0) down b
  centreline(from pfront(TR) down b chop -.1)
  W: pfront(X9)
  E: pfront(X2)
  N: pfront(X16)
  S: pfront(X8)
  ] with .nw at Top.sw+(0,-sep)

Side: [
  line from pside(X0) to pside(X4) to pside(X16) to pside(X19) to pside(X1) \
    to pside(X0) to pside(X4)
  line from pside(X12) to pside(X13) to pside(X9) to pside(X8)
  line thick hiddenth dashed from pside(X5) to pside(X19)
  line thick hiddenth dashed from pside(TR)+(-r,0) down b
  line thick hiddenth dashed from pside(TR)+( r,0) down b
  centreline(from pside(TR) down b chop -.1)
  N: pside(X16)
  S: pside(X0)
  ] with .ne at Front.nw+(-sep,0)

if 1 then {
  linethick_(0.8)
  guideletter([Letters(`F R O N T8V I5E1W')]) with .n at Front.s+(0,-.05)
  guideletter([Letters(`S4I5D4E8V I5E1W')]) with .n at Side.s+(0,-.05)
  guideletter([Letters(`T O4P8V I5E1W')]) with .n at Top.s+(0,-.10)
  linethick_(visibleth)
}

  line thick dimensionth from Side.N to Front.N chop 0.05
  line thick dimensionth from Side.S to Front.S chop 0.05
  line thick dimensionth from Top.W to Front.W chop 0.05
  line thick dimensionth from Top.E to Front.E chop 0.05

 ] # End Orthographics

define(`looppersp',`ifelse(eval(`$1'>=0),1,`perspective(xpnd(X`$1'),Z`$1')
  Y`$1': (cos(fth)*Z`$1'.x-sin(fth)*Z`$1'.y,\
          sin(fth)*Z`$1'.x+cos(fth)*Z`$1'.y)*s4f
  looppersp(eval($1-1))')')

if 1 then {
Perspective: [
  pushdef(`pr',`$1')
  right_
    looppersp(eval(xn+ncirc+1))
    drawobj(Y,1)
  popdef(`pr')
# ] with .sw at Isometric.ne+(-3.5*sep,0)
  ] with .se at Orthographics.sw+(-1.5*sep,0)

  linethick_(0.8)
  guideletter([[Letters(T2W O)]; move right lu; line right 4*lu; move right lu
   [Letters(P O4I5N T8P E R S P E C T I V E)]])\
   with .w at Perspective.s+(.2*u,0)
  linethick_(visibleth)
}

if 1 then {
# Pictorials:
Isometric: [
  drawobj(X,0)
# command "{\small"
# define(`loopprt',`ifelse(eval(`$1'>=0),1,`"`$1'" at pr(X$1)
#   loopprt(eval($1-1))')')
# loopprt(xn)
# for i=0 to ncirc do { sprintf("%g",i) at TT[i] }
# command "}%"
#] with .sw at (Orthographics.e+(-textwidth,0),Orthographics.Side.sw+(0,0.1))
#] at Orthographics.nw
 ] with .s at Perspective.n+(0,0.2)

  linethick_(0.8)
  guideletter([Letters(`S4H2A2D E D8I S O M5E2T2R5I C8V I5E1W')])\
    with .w at Isometric.s+(.2*u,0) #(0,-.2)
  linethick_(visibleth)
}

.PE
