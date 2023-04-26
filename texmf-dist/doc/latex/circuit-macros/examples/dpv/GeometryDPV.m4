.PS
# GeometryDPV.m4
# Some constructions from https://tex.stackexchange.com/
gen_init
maxpswid = 10

Fig1: [
# FourbarDPV.m4
# https://tex.stackexchange.com/questions/563831/how-to-draw-four-bar-linkage-with-center-of-mass
ls = 1/25.4            # local scale

 a = 18*ls
 b = 73*ls
 c = 47*ls
 d = 72*ls
 A0: Here
 B0: A0+(d,0)
 circlerad = 1*ls

define(`pivot',`[
 C: circle
 line down_ 4*ls from C+(2*ls,0)
 arc from last line.start to C+(-2*ls,0) with .c at C
 line down_ 4*ls
 B: line thick 1.6 right 7*ls with .c at (C,Here)
 thinlines_
 sep = 0.9*ls
 nhash = B.len/sep
 for i=0 to nhash do { line down sep left sep from B.end-(i/nhash*B.len,0) }
 thicklines_
 ]')

 pivot with .C at A0;              "A`'svg_sub(0)" at A0-(5,0)*ls
 circle dashed rad a at A0
 pivot with .C at B0;              "B`'svg_sub(0)" at B0-(5,0)*ls
                        "d = A`'svg_sub(0)B`'svg_sub(0)" at 0.5<A0,B0>

 B1: Cintersect(A0,a+b,B0,c)
 B2: Cintersect(A0,b-a,B0,c)
 arc dashed from B1 to B2 with .c at B0

 A0B1: line thick 1.6 from A0 to B1 chop 2*ls chop 0
 line thick 1.6 from B0 to B1 chop 2*ls chop 0 "c" ljust
 circle fill_(1) at B1;            "B`'svg_sub(1)" wid 3*ls at B1+(5,0)*ls
 A1: circle fill_(1) at LCintersect(A0B1,A0,a,R)
                                   "A`'svg_sub(1)" at A1+(5,0)*ls

 A2: b/(b-a) between B2 and A0;    "a" at 0.4<A2,A0> above rjust
                                   "b" at 0.4<A1,B1> above rjust
 A2B2: line thick 1.6 from A2 to B2
 line thick 1.6 from B0 to B2 chop 2*ls chop 0
 circle fill_(1) at B2;            "B`'svg_sub(2)" at B2+(5,0)*ls
 circle fill_(1) at A2;            "A`'svg_sub(2)" at A2+(5,0)*ls

 thinlines_
 line from B0+(3*ls,0) right 4*ls
 ArcAngle(Here,B0,B1,5*ls) ->;     "svg_psi`'svg_sub(0)" at last arc.ne above ljust
 ArcAngle(B1,B0,B2,8*ls) ->;       "svg_psi" at last arc.n+(-3*ls,0) above
 ArcAngle(A1,A0,B2,b*0.45) ->;     "svg_theta" at last arc.start+(0,4*ls)
 line from A0+(3*ls,0) right 8*ls
 ArcAngle(Here,A0,B1,9*ls) ->;     "svg_theta`'svg_sub(0)" \
   at last arc.start+(2,2)*ls
 ]

Fig2: [
# FourbarDPV.m4
# https://tex.stackexchange.com/questions/609452/help-drawing-a-more-sophisticated-right-triangle-with-tikz-or-something-else

  textkht = 12/72
  unit = 0.6
  C: Here; { "C" at C rjust below }
  B: C+(4*unit,0); { "B" at B ljust below }
  A: C+(0,3*unit); { "A" at A rjust above }
  H: PerpTo(C,A,B); { "H" at H ljust above }
  line from C to H then to B then to C shaded rgbstring(0.5,0.8,0.9)
# line from C to H then to B then to C shaded "CornflowerBlue"
  line from C to H then to A then to C shaded rgbstring(0.8,0.9,0.7)
# line from C to H then to A then to C shaded "SpringGreen"
  ArcAngle(C,A,B,unit*0.4)
  ArcAngle(C,A,B,unit*0.5)
  ArcAngle(A,B,C,unit*0.5,,"svg_theta" rjust)
  ArcAngle(B,C,H,unit*0.5); {"svg_theta" at C+(unit*0.3,unit*0.17) }
  ArcAngle(B,C,A,unit*0.6)
  RightAngle(B,C,A,unit*0.17)
  RightAngle(C,H,A,unit*0.17)
 ] with .nw at Fig1.sw+(0.2,0)


Fig3: [ ls = 3/4 # local scale
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
 ArcAngle(N,P,Q,0.4);           "svg_beta" at last arc.ne above ljust
 ArcAngle(O,P,N,0.5);           "svg_alpha" at last arc.start+(5bp__,8bp__)
 ArcAngle(R,Q,N,0.5);           "svg_alpha" at last arc.start+(8bp__,-5bp__)
 ] with .sw at Fig2.e+(-0.2,-0.7)

Fig4: [ ls = 2/3       # local scale
 A: Here;              "A" at A above
 B: A+(-1*ls,-3.5*ls); "B" at B below rjust 
 C: B+(4.6*ls,0);      "C" at C below ljust
 AB: line from A to B
 BC: line from B to C
 CA: line from C to A

 perpto(A,BC,L);        "L" at L below
 AL: line from A to L; RightAngle(A,L,C)

 angleLAC = atan2(C.x-L.x,A.y-L.y)
 S: move from A to (sin(angleLAC/2),-cos(angleLAC/2)) 
 AW: line from A to Intersect_(S,BC)
 W: Here;               "W" at W below rjust

 perpto(C,AB,N);        "N" at N above rjust
 CN: line from C to N; RightAngle(C,N,B)

 perpto(B,CA,M);        "M" at M above
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
 ] with .sw at (Fig3.e,Fig2.s)

.PE
