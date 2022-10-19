.PS
# Geometry.m4
gen_init
 scale = 5/4

G: [

 A: Here;               "A" at A above
 B: A+(-1,-3.5);        "B" at B below rjust 
 C: B+(4.6,0);          "C" at C below ljust
 AB: line from A to B
 BC: line from B to C
 CA: line from C to A

 PerpTo(A,BC,L);        "L" at L below
 AL: line from A to L; RightAngle(A,L,C)

 angleLAC = atan2(C.x-L.x,A.y-L.y)
 S: move from A to (sin(angleLAC/2),-cos(angleLAC/2)) 
 AW: line from A to Intersect_(S,BC)
 W: Here;               "W" at W below rjust

 PerpTo(C,AB,N);        "N" at N above rjust
 CN: line from C to N; RightAngle(C,N,B)

 PerpTo(B,CA,M);        "M" at M above
 CM: line from B to M; RightAngle(B,M,C)

 H: Intersect_(CN,AL);  "H" at H +(4bp__,10bp__)

 thinlines_
 Equidist3(B,L,N,CC1,c1rad); C1: circle rad c1rad at CC1
 Equidist3(B,W,N,CC2,c2rad); C2: circle rad c2rad at CC2
 Equidist3(B,C,N,CC3,c3rad); C3: circle rad c3rad at CC3
 Equidist3(W,C,M,CC4,c4rad); C4: circle rad c4rad at CC4
 thicklines_

 Z: LCintersect(AW,CC2,C2.rad);   "Z" at Z+(-5bp__,-5bp__)
 HZ: move from H to Z
 Y: LCintersect(HZ,CC4,C4.rad,R); "Y" at Y above
 X: LCintersect(HZ,CC2,C2.rad);   "X" at X above rjust

 Loopover_(`P',`dot(at P)',X,Y,Z)

 line dashed from X to Y chop -linewid/2
 RightAngle(A,Z,Y)
 ] scaled 0.8
Lyap: [
#.PS
# Lyap.m4
threeD_init
#scale = 1/1.2

viewaz = 30
viewel = 18
setview(viewaz,viewel)

Origin: Project(0,0,0)
#                             Components of view vector W
w1 = view3D1
w2 = view3D2
w3 = view3D3
#                             Shape factor of the ellipse on the xy plane
q = Cos(40)

#                             cost function
h = 0.5
c = 1
#                             The projected ellipse is (x/q)^2 + y^2 = c.
#                             The cost is v = c+h
define(`vs',``$2'*q*cos(`$1'),`$2'*sin(`$1')')
define(`vp',`vs(`$1',`$2'),0')
define(`vx',`sum3D(vp(`$1',`$2'),0,0,h+(`$2')^2)')

#                             The gradient of v is (2x/q, 2y, -1) and the line
#                             separating front and back is W^T * grad(v) = 0
#                             This line intersects the projected ellipse at
#                             x1,y1 and x2,y2
  ap = w2^2*q^2/w1^2+1
  bp = -w2*w3*q^2/w1^2
  cp = w3^2*q^2/4/w1^2-c
  m = sqrt(bp^2-4*ap*cp)
  y1 = (-bp+m)/ap/2 ; x1 = (w3-2*y1*w2)*q/2/w1
  y2 = (-bp-m)/ap/2 ; x2 = (w3-2*y2*w2)*q/2/w1
  t1 = atan2(y1,x1)
  t2 = atan2(y2,x2)
  theta1 = min(t1,t2)
  theta2 = max(t1,t2)

#                             tangent curve
  nT = 11
  for i = 0 to nT do {
    y = y1 + (y2-y1)/nT*i
    theta = atan2(y,(w3-2*y*w2)*q/2/w1)
    r = y/sin(theta)
    T[i]: Project(vx(theta,r))
    }

#                             front and back parts of the top curve
  n = 12
  for i = 0 to n do {
    theta = theta1 + (theta2-theta1)/n*i
    F[i]: Project(vx(theta,c))
    Fp[i]: Project(vp(theta,c))
    }
  for i = 0 to n do {
    theta = theta2 + (theta1+twopi_-theta2)/n*i
    B[i]: Project(vx(theta,c))
    Bp[i]: Project(vp(theta,c))
    }

#                             trajectory
rotations = 1.55
nx = 7
thetas = 75*dtor_
thetaf = thetas - rotations*twopi_
rx = c*0.9
beta = exp(log(.5)/20)

define(`defX',` rx = `$5' ; np = np-1
  ts = `$1' ; tf = `$2'
  for i = 0 to `$3' do {
    tha = ts + (tf-ts)*i/(`$3')
    for thx = tha to -twopi_ by twopi_ do {}
    `$4'[i]: Project(vx(thx,rx))
    Xp[np]: Project(vp(thx,rx))
    np = np+1
    rx = beta*rx
    }')

np = 1
defX(thetas,theta1,nx,X1,rx)
defX(theta1,theta2-twopi_,nx,X2,rx/beta)
defX(theta2-twopi_,theta1-twopi_,nx,X3,rx/beta)
defX(theta1-twopi_,thetaf,5,X4,rx/beta)

#                             First draw the inside back
#                             B is the back curve
#                             T is the outline
ifpstricks(`
\psset{gradbegin=lightgray,gradend=darkgray,gradlines=1000}
\pscustom[fillstyle=gradient,gradmidpoint=0.7]{
  fitcurve(B,n)
  for i = 0 to nT do {TT[i]: T[nT-i] }
  fitcurve(TT,nT)
\relax} ',
` fitcurve(B,n)
  for i = 0 to nT do {TT[i]: T[nT-i] }
  fitcurve(TT,nT) ')

#                             Centre axis
thinlines_
line from Origin to Project(0,0,h)
#                             F[0] is the leftmost point of the front curve
line from F[0] to Fp[0]
#                             F[n] is the rightmost point of the front curve
line from F[n] to Fp[n]
thicklines_

#                             Now draw the outside front
ifpstricks(`
\newgray{gray1}{0.9}%
\newgray{gray2}{0.4}%
\psset{gradbegin=gray1,gradend=gray2,gradlines=1000}
\pscustom[linewidth=0pt,fillstyle=gradient,gradmidpoint=0.99]{
  fitcurve(F,n)
  fitcurve(T,nT)
\relax} ',
` shade(1,fitcurve(F,n)
  fitcurve(T,nT)) ')
#                             T is the limit curve of visibility
  fitcurve(T,nT)
#                             F is the top front
  fitcurve(F,n)
#                             Front and back projections of the top on xy
  fitcurve(Fp,n)
  fitcurve(Bp,n)

#                             The trajectory in pieces, to allow dashed parts
  fitcurve(X1,nx)
  fitcurve(X2,nx,dotted 0.025)
  fitcurve(X3,nx)
  fitcurve(X4,3,dotted 0.015)
  arca(from X4[4] to X4[2],ccw,0.3,<-)

#                             Projected trajectory
  np = np-2
  fitcurve(Xp,np-1)
  arca(from Xp[np] to Xp[np-2],ccw,0.18,<-)
  "svg_it(X(t))" at Xp[np]-(2bp__,0) ljust

#                             Axes and vertical lines
thinlines_
  line from X1[0] to Xp[0]
arrow from Origin to Project(1.5,0,0)
"svg_it(x)`'svg_sub(1)" rjust below
arrow from Origin to Project(0,1.5,0)
"svg_it(x)`'svg_sub(2)" wid 10bp__ ljust
line dashed from Project(0,0,h) to F[n/2] chop 0 chop arrowht/4
arrow from F[n/2] to Project(0,0,2)
"svg_it(v(X))" ljust

"svg_it(0)" at Origin+(0,1 pt__) below
"svg_Omega" at Project(0,0.9*c,0) above
"svg_it(v(X) = c)" at (Project(vp(100*dtor_,c)))+(2bp__,0) above ljust

#.PE
 ] scaled 1.5 with .sw at last [].se+(0.5,0)

.PE
