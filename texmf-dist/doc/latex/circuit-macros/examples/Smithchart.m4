.PS
# Smithchart.m4
gen_init
#https://utah.instructure.com/courses/684846
#https://www.youtube.com/watch?v=RptPsP8hS4g
#https://www.youtube.com/watch?v=UUk1R01uEoE
##https://www.youtube.com/watch?v=TsXd6GktlYQ

scalefactor = 6.5/2                          # to vary the final chart diameter
#calefactor = 6.5/2*3/4                      # 3/4 scale for svg examples
#                          Basic definitions
define Rac {($1/($1+1),0)*scalefactor}       # centre of const ra circle
define rar {1/abs($1+1)*scalefactor}         # radius
define Xac {(1,1/($1))*scalefactor}          # centre of const xa circle
define xar {1/abs($1)*scalefactor}           # radius
define Rc {CRc[$1*100]}                      # Rc circle indexed by value
define Xc {CXc[$1*100]}                      # Xc circle indexed by value
define grayline {outlined graystring($1)}
define arct {arc thick $1}

#                          `SGamma(ra,xa)   chart location of complex value'
define(`SGamma',`(ifelse(`$2',0,`Rc($1).w',
 `Cintersect(Rac(`$1'),rar(`$1'),Xac(`$2'),xar(`$2'), dnl
  ifelse(substr(`$2',0,1),-,R))'))')
#                          1-piece Ra arc                        
define(`RaArc1',`ifinstr(`$1',to,for ix=`$1' do,ix=`$1';) {
  Rc(ix): arct(`$2') grayline(`$2'g) dnl
    from SGamma(ix,`$3') to SGamma(ix,-(`$3')) with .c at Rac(ix)}')
#                          2-piece Ra arc                        
define(`RaArc2',`ifinstr(`$1',to,for ix=`$1' do,ix=`$1';) {
  Rc(ix): arct(`$2') grayline(`$2'g) dnl
    from SGamma(ix,`$3') to SGamma(ix,`$4') with .c at Rac(ix)
  arct(`$2') grayline(`$2'g) dnl
    from SGamma(ix,-(`$4')) to SGamma(ix,-(`$3')) with .c at Rac(ix)}')
#                          Positive and negative Xa arcs                        
define(`XaArc2',`ifinstr(`$1',to,for ix=`$1' do,ix=`$1';) {
  Xc(ix): arct(`$2') grayline(`$2'g) dnl
    from SGamma(`$3',ix) to SGamma(`$4',ix) with .c at Xac(ix)
  Xc(-ix): arct(`$2') grayline(`$2'g) dnl
    cw from SGamma(`$3',-ix) to SGamma(`$4',-ix) with .c at Xac(-ix)}')

define(`Smithchart',`[
iflatex(s_init(tst))
ifpostscript(,latexcommand({\tiny))
ifsvg(svg_font(sans-serif,10bp__)
  svg_rot_init(SmithchartDPV))

  thk = 1.2                 # width of thick lines (pt)
  thn = 0.4                 # thin lines
  thkg = 0.33               # weight of thick lines
  thkg =0.5 
  thng = 0.4                # weight of thin lines
  thng = 0.6

C: circle thick thk rad rar(0) at (0,0)
  line thick thk grayline(thkg) from C.w to C.e

Rc(50): circle thick thk grayline(thkg) rad rar(50) at Rac(50)
foreach_(`term',`RaArc1(patsubst(term,:,`,'))',
 20:thn:50,
 30 to 40 by 10:thn:50,
 20:thk:20,
 12 to 18 by 2:thn:20,
 10:thn:50,
 10:thk:20,
 6 to 9:thn:10,
 5:thk:10,
 2.2 to 4.81 by 0.2:thn:5,
 4:thn:20,
 4:thk:5,
 3:thn:10,
 3:thk:5,
 2:thn:20,
 2:thk:5,
 1.1 to 1.91 by 0.2:thn:2,
 1.2 to 2.01 by 0.2:thk:2,
 1:thn:10,
 1:thk:5,
 0.2 to 1.81 by 0.2:thn:5,
 0.2 to 0.81 by 0.2:thk:2,
 0.6 to 0.91 by 0.1:thk:1,
 0.55 to 0.951 by 0.1:thn:1,
 0.1 to 0.91 by 0.2:thn:2,
 0.1 to 0.91 by 0.2:thk:1,
 0.22 to 0.481 by 0.02:thn:0.5,
 0.01 to 0.191 by 0.01:thn:0.2,
 0.05 to 0.151 by 0.1:thk:0.2)

foreach_(`term',`RaArc2(patsubst(term,:,`,'))',
 0.05 to 0.451 by 0.1:thn:1:0.5,
 0.02 to 0.181 by 0.02:thn:0.5:0.1)

Xc(50): arct(thk) cw grayline(thkg) from C.e \
  to SGamma(0,50) with .c at Xac(50)
Xc(-50): arct(thk) grayline(thkg) from C.e \
  to SGamma(0,-50) with .c at Xac(-50)

foreach_(`term',`XaArc2(patsubst(term,:,`,'))',
 10 to 20 by 10:thn:0:50,
 7 to 9 by 2:thn:0:10,
 2 to 18 by 2:thn:0:20,
 0.2 to 4.81 by 0.2:thn:0:5,
 1.1 to 1.91 by 0.2:thn:0:2,
 1 to 4:thn:0:10,
 0.1 to 0.91 by 0.2:thn:0:2,
 0.22 to 0.481 by 0.02:thn:0:0.5,
 0.55 to 0.951 by 0.1:thn:0:1,
 10 to 20 by 10:thk:0:20,
 5:thk:0:10,
 1.2 to 1.81 by 0.2:thk:0:2,
 1 to 4:thk:0:5,
 0.2 to 0.81 by 0.2:thk:0:2,
 0.1 to 0.91 by 0.2:thk:0:1)

foreach_(`term',`XaArc2(patsubst(term,:,`,'))',
 0.05 to 0.451 by 0.1:thn:0.5:1,
 0.02 to 0.181 by 0.02:thn:0:0.5,
 0.02 to 0.191 by 0.01:thn:0:0.2, dnl 0.02 should be 0.01
 0.05 to 0.151 by 0.1:thk:0:0.2)
dnl                         these avoid TeX arithmetic overflow:
 line thick thn grayline(thng) from SGamma(0,0.01) to SGamma(0.2,0.01)
 line thick thn grayline(thng) from SGamma(0,-0.01) to SGamma(0.2,-0.01)
 dot(at C,,1,grayline(thkg))

dnl                         Internal labels start here 
  textht = C.wid/120
#                           Horizontal axis
foreach_(`t',`box wid textht ht textht*1.5 colored "white" \
  with .se at Rc(t).w+(-2bp__,2bp__)
  r_text(90,"t",at Rc(t).w+(-textht/3,textht*1.5))',
  0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9, 1,1.2,1.4,1.6,1.8, 2,3,4,5,10,20,50)
#                           Xc=1 labels
foreach_(`tt',
 `define(`m4ta',patsubst(tt,:.*))define(`m4vl',patsubst(tt,.*:))dnl
  X: SGamma(m4vl,1)
  M: move from Rc(m4vl) to X; ax = lin_ang(M)*rtod_-90  #; print ax
  r_text(m4ta,m4vl,at X+(Rect_(textht*2,ax+30)))
  Y: X-Rc(m4vl); X: Rc(m4vl)+(Y.x,-Y.y)
  r_text(-m4ta,m4vl,at X+(Rect_(textht*1.7,-(ax+30)))) ',
  10:0.2, 19:0.4, 26:0.6, 32:0.8, 37:1)
#                           right-side circumference
foreach_(`tt',
 `define(`m4ta',patsubst(tt,:.*))define(`m4vl',patsubst(tt,.*:))dnl
  X: Xc(m4vl).start; ax = atan2(X.y,X.x)*rtod_ ; # print round_(ax)
  r_text(m4ta,m4vl,at X+(Rect_(textht*2,ax-120)))
  if m4vl>=2 then {
    r_text(-m4ta,m4vl,at (X.x,-X.y)+(Rect_(textht*1.5,-ax+135))) }\
  else { r_text(-m4ta,m4vl,at (X.x,-X.y)+(Rect_(textht*2,-ax+150))) } ',
  6:20, 11:10, 23:5, 28:4, 37:3, 53:2, 58:1.8, 64:1.6, 71:1.4, 80:1.2, 90:1)
#                           left-side circumference
foreach_(`tt',
 `X: Xc(m4Lx*0.1).start; # print round_(atan2(X.y,X.x)*rtod_-180)
  r_text(-patsubst(tt,:,`,'),at X+(Rect_(textht*1.7,-m4Lx*11+40)))
  r_text( patsubst(tt,:,`,'),at (X.x,-X.y)+(Rect_(textht*2.1,m4Lx*11-30))) ',
 11:0.1, 23:0.2, 33:0.3, 44:0.4, 53:0.5, 62:0.6, 70:0.7, 77:0.8, 84:0.9)
#                           Ra=1 labels
foreach_(`tt',`X: SGamma(1,m4Lx*0.2)
  M: move from Rac(1) to X; # print round_(lin_ang(M)*rtod_-180)
  r_text(-eval(m4Lx*11),ifelse(m4Lx,5,1,0.eval(m4Lx*2)),
   at X+(Rect_(textht*1.5,-m4Lx*11+40)))
  r_text( eval(m4Lx*11),ifelse(m4Lx,5,1,0.eval(m4Lx*2)),
   at (X.x,-X.y)+(Rect_(textht*2,m4Lx*11-30))) ',
 11:0.2, 23:0.4, 33:0.6, 44:0.8, 53:1)

  textht *=0.9
#                           Wavelength circle and tics
  wvsep = textht*3/2
  wltic = C.wid/120
  circle thick thn grayline(thkg) diam C.diam+wltic/2+wvsep*11 at C
W: circle thick thn grayline(thkg) diam C.diam+wvsep*8 at C
  for tc=0 to 249 do {ax = 180-tc/250*360; line thick thn grayline(thkg) \
   from W+(Rect_(W.rad+wltic/2,ax)) to W+(Rect_(W.rad-wltic/2,ax)) } 
#                           Wavelength circle labels
for_(0,49,1,
 `ifelse(eval(m4x<5),1,,
 `r_text(eval(90-m4x*180/25),ifelse(m4x,0,0,eval(m4x<10),1,0.0`'m4x,0.`'m4x),
    at W+(Rect_(W.rad+wltic/2+textht*0.5,180-m4x*180/25)))')
  ifelse(eval(m4x<47),1,
 `r_text(eval(90-m4x*180/25),ifelse(m4x,0,0,eval(m4x>40),1,0.0`'eval(50-m4x),
   0.`'eval(50-m4x)), at W+(Rect_(W.rad-wltic/2-textht*1.0,180-m4x*180/25)))')')

  circle thick thn grayline(thkg) diam C.diam+wvsep*5 at C
A: circle thick thn grayline(thkg) diam C.diam+wvsep*2.5 at C
  for tc=0 to 359 by 2 do {line thick thn grayline(thkg) \
   from A+(Rect_(A.rad+wltic/2,tc)) to A+(Rect_(A.rad,tc)) } 
for_(20,170,10,
 `r_text(eval(-90+m4x),m4x,at A+(Rect_(A.rad+textht*0.5,m4x)))
  r_text(eval( 90-m4x),-m4x,at A+(Rect_(A.rad+textht*1.2,-m4x)))
 ')
  r_text(90,180,at A-(A.rad+textht/2,0))
foreach_(`rca',
 `r_text(eval(90-(180-rca/10)),eval(m4Lx*5+5),
    at A+(Rect_(A.rad-textht*0.7,rca/10)))
  r_text(eval(-90+(180-rca/10)),eval(-m4Lx*5-5),
    at A+(Rect_(A.rad-textht*0.7,-rca/10))) ',
  195,295,392,490,588,685,782,880,967,1072,
  1165,1260,1352,1438,1518,1598,1645)

#                           Internal labels
  setrgb(thng,thng,thkg)
  "RESISTANCE R/Zo OR CONDUCTANCE G/Yo" at C+SGamma(0.5,0)-(0,C.rad/40) 
  foreach_(`Lttr',`ifelse(Lttr,*,,`r_text(eval(87-m4Lx*86/100),Lttr,
    at W+(Rect_(W.rad+wltic/2+textht*0.5, 177-m4Lx*0.86))) ')',
    W,A,V,E,L,E,N,G,T,H,S,*,T,O,W,A,R,D,*,G,E,N,E,R,A,T,O,R)
  foreach_(`Lttr',`ifelse(Lttr,*,,`r_text(eval(115-m4Lx*86/100),Lttr,
    at W+(Rect_(W.rad-wltic/2-textht*1.0, 204-m4Lx*0.86))) ')',
    W,A,V,E,L,E,N,G,T,H,S,*,T,O,W,A,R,D,*,L,O,A,D)
  foreach_(`Lttr',`ifelse(Lttr,*,,`define(`xa','13-m4Lx*86/100`)
    r_text(eval(xa-90),Lttr,at A+(Rect_(A.rad+textht*0.7, xa))) ')',
    R,E,F,L,E,C,T,I,O,N,*,C,O,E,F,F,I,C,I,E,N,T,*,A,N,G,L,E)
  foreach_(`Lttr',`ifelse(Lttr,*,,`define(`xa','14-m4Lx*86/100`)
    r_text(eval(xa-90),Lttr,at A+(Rect_(A.rad-textht*0.7, xa))) ')',
    T,R,A,N,S,M,I,S,S,I,O,N,*,C,O,E,F,F,I,C,I,E,N,T,*,A,N,G,L,E)
  resetrgb

ifpostscript(,latexcommand(}%))
ifsvg(command "</g>")
] ')

Smithchart at (0,0)

.PE
