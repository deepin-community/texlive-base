.PS
#.PS 3.5
# csc.m4
# This file includes AntiqueClock and works for PSTricks, Tikz, and SVG
gen_init
NeedDpicTools

skale = 0.878
circlerad=1.91*skale
hubrad=0.10*skale
s=0.5*skale

define(`midnight',`0.1, 0.1, 0.44')
define(`white',`1, 1, 1')
define(`spokewidth',0.1)
define(`spoke',`dnl
  {line from rvec_(0,hubrad-spokewidth/2) to rvec_(circlerad-0.05,0)}
  {line from rvec_(0,-(hubrad-spokewidth/2)) to rvec_(circlerad-0.05,0)}')
define(`lwid',1)
define(`coord',`(s*(`$1'),s*(`$2'))')

#                               Circle and spokes
CSC: [
rgbdraw(midnight,
  linethick=`0.'eval(lwid*15)/(1pt__)
  {circle with .c at Here
   circle invis diam last circle.diam + linethick pt__ at last circle }
  linethick=spokewidth/(1pt__)
  for angle = 0 to 330 by 30 do {
    Point_(angle)
    {spoke}
    }
  )

#                               Whiten where the hull will be
  linethick=`0.'eval(lwid*20)/(1pt__)
  rgbdraw(white,
    Point_(-60){line to rvec_(circlerad*0.72,0)} 
    Point_(-90){line to rvec_(circlerad*0.72,0)} 
    Point_(-120){line to rvec_(circlerad*0.72,0)} 
  
    linethick=`0.'eval(lwid*15)/(1pt__)
    {move to coord(1.8,-2.3)+(0,0.025)
    spline to Here+coord(-0.8,-0.3) then to Here+coord(-1.8,-0.3) \
      then to Here+coord(-2.18,-0.27) \
      then to Here+coord(-3.93,-0.1)}
    )

#                               Sail
  thinlines_
  rgbfill(midnight,
    line from coord(0.44,3.38) to coord(0.44,2.6) \
      then to coord(2.1,-1.75) \
      then to coord(1.22,-1.53) \
      then to coord(0.62,-1.4) \
      then to coord(0.55,-1.6) \
      then to coord(-2.2,-1.6) \
      then to coord(-2.35,-1.5)
    spline to coord(-2.14,-0.78) \
      then to coord(-1.74,0.22) \
      then to coord(-1.42,0.89) \
      then to coord(-0.92,1.73) \
      then to coord(0,2.9) \
      then to coord(0.44,3.38)
    )

#                               Hull
   rgbfill(midnight,
     spline from coord(2.1,-1.75) to coord(1.9,-2.2) \
       then to coord(1.85,-2.3) then to coord(1.8,-2.33) \
       then to coord(1,-2.5) then to coord(0,-2.6) then to coord(-0.38,-2.57) \
       then to coord(-2.13,-2.4)
     line to coord(-2.2,-2.05) then to coord(2.1,-1.75)
     spline to coord(-1,-2.08) then to coord(0.55,-1.77)
     )
  ]

Clock: [
# PSTricks, tikz, or svg only:
ifelse(ifpstricks(T)`'ifpgf(T)`'ifsvg(T),T,`
#.PS
# AntiqueClock.m4
#gen_init
#NeedDpicTools

iflatex(`latexcommand({\sf)')
ifsvg(svg_font(font-family="sans-serif" font-stretch="condensed")
        svg_rot_init(test))

# https://tex.stackexchange.com/questions/236923/generate-analog-clock-with-numbered-face-add-seconds-roman-numerals

#                          `hms2deg(hr,min,sec)  hr:min:sec to degrees
#                           blank arg1: degrees for minute hand
#                           blank arg1 and arg2: degrees for second hand'
define(`hms2deg',`ifelse(`$1',,
 `ifelse(`$2',,
   `(90-pmod(ifelse(`$3',,0,`$3'),60)/60*360)',
   `(90-(pmod(`$2',60)/60 + pmod(ifelse(`$3',,0,`$3'),60)/60/60)*360)')',
 `(90-(pmod(`$1',12) + pmod(ifelse(`$2',,0,`$2'),60)/60 + dnl
     pmod(ifelse(`$3',,0,`$3'),60)/3600)/12*360)')')

#                          `SecondHand(length,hr,min,sec)'
define(`SecondHand',`[ shsf = (`$1')/3.2
  C: Here
  { L: rpoint_(to (Rect_(`$1',hms2deg(,,`$4')))) }
  line thick 8*shsf to rvec_(`$1',0)
  ]')

#                          `AntiqueMinuteHand(length,hr,min,sec)'
define(`AntiqueMinuteHand',`[ mhsf = (`$1')/2.84
  L: rpoint_(to (Rect_(`$1',hms2deg(,`$3',`$4'))))
  C: circle fill_(0) diam 0.47*mhsf at L.start
  move to C
  spline from rvec_(0,0.047*mhsf) \
   to rvec_(1.65*mhsf,0.11*mhsf) \
   then to rvec_(`$1',0.018*mhsf) \
   then to rvec_(`$1',-0.018*mhsf) \
   then to rvec_(1.65*mhsf,-0.11*mhsf) \
   then to rvec_(0,-0.047*mhsf) \
   shaded rgbstring(0,0,0)
  ]')

#                          `AntiqueHourHand(length,hr,min,sec)'
define(`AntiqueHourHand',`[ hhsf = (`$1')/2.2
  L: rpoint_(to (Rect_(`$1',hms2deg(`$2',`$3',`$4'))))
  C: circle fill_(0) diam 0.6*hhsf at L.start
  move to C
  v = 0.25*hhsf
  { line to rvec_(1.1*hhsf,0) thick 0.15/(1bp__)*hhsf }
  C1: rvec_(1.25*hhsf,0)
  d = `$1'-1.25*hhsf
  q = 1bp__*hhsf
  r1 = (d^2 + q^2 - v^2)/(v-q)/2
  tang = atan2((r1+q),d)
  for i=0 to 3 do {
    X[i]: C1+vec_(rect_(v, pi_+i/3*( tang-pi_)))
    Y[i]: C1+vec_(rect_(v,-pi_+i/3*(-tang+pi_)))
    }
  n = 3
  for i=1 to 4 do { aa = -pi_+tang + i/4*(pi_/2-tang)
    XX: (d,r1+q)+(rect_(r1,aa))
    n+=1;
    X[n]: C1+vec_(XX.x, XX.y)
    Y[n]: C1+vec_(XX.x,-XX.y)
    }
  m = n
  for i= 0 to m do { n+=1; X[n]: Y[m-i] }
  fitcurve(X,n,shaded rgbstring(0,0,0))
  ]')


define(`AntiqueClock',`[    # h,m,s,diam
#                           Clock size parameters:
  hour = ifelse(`$1',,3,`$1')
  minute = ifelse(`$2',,41,`$2')
  second = ifelse(`$3',,51,`$3')
                            # outer radius
  ifelse(`$4',,`skale=0.5; r1=2',`r1=(`$4')/2; skale=r1/4')
  r2 = r1-0.5*skale
  r3 = r2-0.14*skale
  r4 = r3 - 0.35*skale
  r5 = r4 - 0.17*skale
  r6 = r5 - 0.63*skale
  r7 = r6 - 0.17*skale
  shadelinethick = 1.0

C: circle thick 0.2 rad r1

define shadeline {
  s = 1-($`'1)*2
  v = r*s
  h = sqrt(r^2-v^2)
  t = 1-abs(s)
  line from (vrot_(-h,v,cost,sint)) to (vrot_(h,v,cost,sint)) \
    thick shadelinethick outlined rgbstring(t,t,t)
  }

  r = r1                    # Bezel outer
  nlines = int(2*r/(shadelinethick pt__)*1.1)
  cost = cosd(10); sint = sind(10); 
  ShadeObject(shadeline,nlines, 0, 0,0,0, 0.5, 1,1,1, 1, 0,0,0 ) at C

  r = r2                    # Bezel inner
  nlines = int(2*r/(shadelinethick pt__)*1.1)
  cost = cosd(-10); sint = sind(-10); 
  ShadeObject(shadeline,nlines, 0, 0,0,0, 0.25, 0.8,0.8,0.8, 0.5, 1,1,1,
                             0.75, 0.8,0.8,0.8, 1, 0,0,0 ) at C

#                           Clock face
Face: circle thick 0 fill_(1) rad r3 at C
  circle rad r4 at C
  circle rad r5 at C
  circle rad r6 at C
  circle rad r7 at C

#                           Ad hoc shift of rotated SVG text
  ifsvg(`define adj {+(-cosd($`'1)*textht*0.5*sign(180-($`'1)),\
   (0.25+0.25*cosd(2*($`'1)))*textht) }',
   `define adj {}')

#                           Outer numbers
  iflatex(`command sprintf("\font\outerfont=cmss12 at %4.2fin",r3-r4)')
  ifsvg(`textht = (r3-r4)*0.6')
  for_(-15,15,5,`aa=90-(m4x)*6
    r_text(eval(-(m4x)*6),eval((m4x+60)%60),
     at C+(Rect_((r3+r4)/2,aa)) adj(aa))')
  for_(20,40,5,`aa=450-(m4x)*6
    r_text(eval(180-m4x*6),m4x,at C+(Rect_((r3+r4)/2,aa)) adj(aa))')
#                           Outer tics
  for mn = 1 to 60 do { t = 90-mn/60*360
    line from C+(Rect_(r5,t)) to C+(Rect_(r4,t)) }

#                           Inner numbers
  iflatex(`command sprintf("\font\innerfont=cmss12 at %4.2fin",r5-r6)')
  ifsvg(`textht = (r5-r6)*0.6')
  Loopover_(`mx',`aa=180-(m4Lx-1)*30
    r_text(eval(120-m4Lx*30),iflatex({\innerfont mx},mx),
    at C+(Rect_((r5+r6)/2,aa)) adj(aa))',
    IX,X,XI,XII,I,II,III)
  Loopover_(`mx',`aa=360-m4Lx*30
    r_text(eval(90-m4Lx*30), iflatex({\innerfont mx},mx),
    at C+(Rect_((r5+r6)/2,aa)) adj(aa))',
    IV,V,VI,VII,VIII)

#                           Inner tics
  for mn = 5 to 60 by 5 do { t = 90-mn/60*360
    line from C+(Rect_(r7,t)) to C+(Rect_(r6,t)) }

#                           Hands
  AntiqueHourHand(r6,hour,minute,second) with .C at C
  AntiqueMinuteHand(r5,hour,minute,second) with .C at C
  SecondHand((r3+r4)/2,hour,minute,second) with .C at C

#                           Center
  dot(at C,0.1/4*r1,1)
 ]') `# AntiqueClock'

  Clock1: AntiqueClock(,,,3.5)
# Clock2: AntiqueClock(4,50,07,2) at Clock1.e+(1.5,0)

  iflatex(`latexcommand(}%)')
  ifsvg(`command "</g>"')

#.PE
',` "AntiqueClock.m4 requires" "PSTricks, Tikz-pgf, or SVG" ')
  ] with .sw at last [].se+(0.25,0)
.PE
