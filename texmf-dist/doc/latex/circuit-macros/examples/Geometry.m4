.PS
# Geometry.m4
gen_init

Fig1: [ ls = 2/3       # local scale
 A: Here;              "A" at A above
 B: A+(-1*ls,-3.5*ls); "B" at B below rjust 
 C: B+(4.6*ls,0);      "C" at C below ljust
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
 ]

Fig2: [ ls = 3/4 # local scale
# https://tex.stackexchange.com/questions/593272/drawing-complex-geometry
 P: dot(at Here);               "P" at P.s below
 N: dot(at P+(3.5*ls,1.5*ls));  "N" at N.se ljust below
 O: dot(at (N,P));              "O" at O.s below
 R: dot(at 1/3 between O and P);"R" at R.s below
 M: dot(at (R,N));              "M" at M.se ljust below
 Q: dot(at (M.x,M.y+distance(M,N)/distance(N,O)*distance(P,O)));"Q" at Q.e ljust
 line from P to Q then to N then to O
 B: line to P chop -0.3
 line from M to N
 Pu: line from R to Q chop 0 chop -0.3
 H: line from P to N chop 0 chop -0.3
 X: dot(at Intersect_(Pu,H));   "X" at X.se ljust below
 thinlines_
 RightAngle(Q,M,N)
 RightAngle(Q,N,H.end)
 RightAngle(N,O,B.start)
 ArcAngle(N,P,Q,0.4);           "$\beta$" at last arc.ne above ljust
 ArcAngle(O,P,N,0.5);           "$\alpha$" at last arc.start+(5bp__,8bp__)
 ArcAngle(R,Q,N,0.5);           "$\alpha$" at last arc.start+(8bp__,-5bp__)
 ] with .w at Fig1.e+(-0.4,0)

.PE
