.PS
# FourbarSVG.m4
# https://tex.stackexchange.com/questions/563831/how-to-draw-four-bar-linkage-with-center-of-mass
gen_init
scale = 25.4

 a = 18
 b = 73
 c = 47
 d = 72
 A0: Here
 B0: A0+(d,0)
 circlerad = 1

define(`pivot',`[
 C: circle
 line down_ 4 from C+(2,0)
 arc from last line.start to C+(-2,0) with .c at C
 line down_ 4
 B: line thick 1.6 right 7 with .c at (C,Here)
 thinlines_
 sep = 0.9
 nhash = B.len/sep
#for i=0 to nhash do { line down sep left sep from B.start+(i/nhash*B.len,0) }
 for i=0 to nhash do { line down sep left sep from B.end-(i/nhash*B.len,0) }
 thicklines_
 ]')

 pivot with .C at A0;              "svg_it(A`'svg_sub(0))" at A0-(5,0)
 circle dashed rad a at A0
 pivot with .C at B0;              "svg_it(B`'svg_sub(0))" at B0-(5,0)
                        "svg_it(d = A`'svg_sub(0)B`'svg_sub(0))" at 0.5<A0,B0>

 B1: Cintersect(A0,a+b,B0,c)
 B2: Cintersect(A0,b-a,B0,c)
 arc dashed from B1 to B2 with .c at B0

 A0B1: line thick 1.6 from A0 to B1 chop 2 chop
 line thick 1.6 from B0 to B1 chop 2 chop "svg_it(c)" ljust
 circle fill_(1) at B1;            "svg_it(B`'svg_sub(1))" wid 3 at B1+(5,0)
 A1: circle fill_(1) at LCintersect(A0B1,A0,a,R)
                                   "svg_it(A`'svg_sub(1))" at A1+(5,0)

 A2: b/(b-a) between B2 and A0;    "svg_it(a)" at 0.4<A2,A0> above rjust
                                   "svg_it(b)" at 0.4<A1,B1> above rjust
 A2B2: line thick 1.6 from A2 to B2
 line thick 1.6 from B0 to B2 chop 2 chop 0
 circle fill_(1) at B2;            "svg_it(B`'svg_sub(2))" at B2+(5,0)
 circle fill_(1) at A2;            "svg_it(A`'svg_sub(2))" at A2+(5,0)

 thinlines_
 line from B0+(3,0) right 4
 ArcAngle(Here,B0,B1,5) ->;     "svg_psi`'svg_sub(0)" at last arc.ne above ljust
 ArcAngle(B1,B0,B2,8) ->;       "svg_psi" at last arc.n+(-3,0) above
 ArcAngle(A1,A0,B2,b*0.45) ->;  "svg_theta" at last arc.start+(0,4)
 line from A0+(3,0) right 8
 ArcAngle(Here,A0,B1,9) -> ;    "svg_theta`'svg_sub(0)" at last arc.start+(2,2)

.PE
