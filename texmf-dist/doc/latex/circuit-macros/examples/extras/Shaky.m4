.PS
# Shaky.m4
gen_init
NeedDpicTools
divert(-1)
                               `An attempt to draw shaky hand-drawn lines'

                               `shakyline(linespec,type,shake=val,[shakevals])
                                Draw a line with a tremor
                                arg3: shake parameter (default 1)
                                arg4=normal(0,1) perturbations used if given'
define(`shakyline',
`rpoint_(ifelse(`$1',,`to rvec_(linewid,0)',`$1'))
 L_start_: last line.start
 L_end_: last line.end
 [ Start: L_start_
   End: L_end_
   llen = distance(Start,End)
   npts = round_(llen/linewid*4)
   pushkey_(`$3',shake,1)dnl
   sval = m4shake*llen/npts/8
   if "$4"=="" then { randn(d,npts-1,0,sval) }\
   else { for i=1 to npts-1 do { d[i] = $4[i]*sval) }}
   P[0]: Start
   for i=1 to npts-1 do { P[i]: i/npts between Start and End + vec_(0,d[i]) }
   P[npts]: End
   spline ifdpic(ifelse(`$2',,ctension_)) $2 from P[0] to P[1]
   for i=2 to npts do { continue to P[i] } popdef(`m4shake')
 ] with .Start at L_start_; move to L_end_')

                               `shakyarc(arcspec,type,shake=val,[shakevals])
                                Draw an arc with a tremor
                                arg3: s=shake parameter (default 1)
                                arg4=normal(0,1) perturbations used if given'
define(`shakyarc',
`arc invis $1
 A_start_: last arc.start
 A_end_: last arc.end
 A_C_: last arc.c
 [ Start: A_start_
   End: A_end_
   C: A_C_
   as = atan2(Start.y-C.y,Start.x-C.x)
   ae = atan2(End.y-C.y,End.x-C.x)
   ar = distance(Start,C)
   llen = abs(ar*(ae-as))
   npts = round_(llen/linewid*4)
   pushkey_($3,shake,1)dnl
   sval = m4shake*llen/npts/8
   if "$4"=="" then { randn(d,npts-1,0,sval) }\
   else { for i=1 to npts-1 do { d[i] = $4[i]*sval }}
   P[0]: Start
   for i=1 to npts-1 do { P[i]: C + (rect_(ar+d[i],as+i/npts*(ae-as))) }
   P[npts]: End
   spline ifdpic(ifelse(`$2',,ctension_)) $2 from P[0] to P[1]
   for i=2 to npts do { continue to P[i] } popdef(`m4shake')
 ] with .Start at last arc.start; move to last arc.end')

                               `shakyfitcurve(V,n,linetype,
                                  m (default 0),shake=val,[shakevals])
                                Like fitcurve but the control points
                                are perturbed
                                arg5: s=shake parameter (default 1)
                                arg6=normal(0,1) perturbations used if given'
define(`shakyfitcurve',`
  [ m4fn = ifelse(`$2',,2,`$2'); m4fm = ifelse(`$4',,0,`$4')
    pushkey_($5,shake,1)dnl
    if "$6"=="" then { randn(d,2*(m4fn-m4fm-1),0,m4shake) }\
    else { for i=1 to 2*(m4fn-m4fm-1) do { d[i] = $6[i]*m4shake }}
    M4PP_[0]: `$1'[m4fm]
    for i=m4fm+1 to m4fn-1 do { M4PP_[i-m4fm]: `$1'[i] dnl
      +(d[2*(i-m4fm-1)+1],d[2*(i-m4fm-1)+2])\
      *distance(M4PP_[i-m4fm-1],`$1'[i])/16 }
    M4PP_[m4fn-m4fm]: `$1'[m4fn]; End: M4PP_[m4fn-m4fm]
    fitcurve(M4PP_,m4fn-m4fm) popdef(`m4shake')
  ] with .M4PP_[0] at `$1'[ifelse(`$4',,0,`$4')]; move to last [].End ')


divert(0)

P1: [
 linethick = 2.5
 round(,,colored "gray")
 nl = 10
 for i=0 to nl do {
   shakyline(right 6/nl up 2*(2*pmod(i,2)-1),,shake=2)
   {sprintf("%g",2-i/nl*2) at 1/2 between L_start_ and L_end_ }
   round(,,colored "gray") }
 ]

P2: [
 linethick = 2.5
 na = 3
 arcrad = 1
 for i=1 to na do {
   shakyarc(,colored "gray",shake=2)
   }
 ] with .nw at last [].sw +(0,-1)

P3: [
 linethick = 2.5
 na = 3
 arcrad = 2
 for i=1 to na do {
   shakyarc(,colored "gray",shake=2)
   }
 ] with .w at last [].e +(1,0)
P4: [
  n = 0
  for a=0 to 359 by 30 do { V[n]: (Rect_(1,a)); n+=1 }
  V[n]: V[0]
  shakyfitcurve(V,n,,,shake=1)
 ] with .nw at P2.sw + (0,-0.5)

.PE
