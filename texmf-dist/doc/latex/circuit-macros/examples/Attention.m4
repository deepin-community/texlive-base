.PS
# Attention.m4
gen_init
scale = 2.54
linethick = 0.2

define dot2 { (($1).x*($2).x + ($1).y*($2).y) }

 nlines = 128
 nr = 50
 innerrad = 1
 outerrad = 8
 diff = outerrad - innerrad
B: box wid outerrad*2 ht outerrad*2 outline "red" shaded "red"
C: circle rad outerrad at B
 circle rad innerrad at C shaded "black"
 P[0]: C+(innerrad,0)
 t = 0
 for i=1 to nr do {
   r = innerrad+i/nr*diff
   t = t + i/nr*(-pi_/2)/nr
   P[i]: C+(rect_(r,t))
   }
 dth = twopi_/nlines
 R: (cos(dth),-sin(dth))
 S: (sin(dth),cos(dth))
 for j = 0 to nlines-1 do {
 for i=0 to nr do {
   X: P[i]-C
   Q[nr-i]: (dot2(R,X),dot2(S,X)) + C
   }
 shade(j%2,
  fitcurve(P,nr)
  line from P[nr] to Q[0]
  fitcurve(Q,nr)
  line from Q[nr] to P[0] 
  )
 for i=0 to nr do { P[i]: Q[nr-i] }
 }

.PE
