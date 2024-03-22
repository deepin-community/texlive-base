.PS
# PerpTo.m4
# https://tex.stackexchange.com/questions/666411/repetitive-perpendiculars-in-a-right-angle-triangle
gen_init

  O: (0,0)
  A: (5,0)
  B: (0,3)

define drawperp { #( depth, O, A, B )
[ d = $1; O[d]: $2; A[d]: $3; B[d]: $4
  P[d]: PerpTo(O[d],A[d],B[d])
  if d > 0 then {
    exec sprintf("drawperp(%g,P[%g],O[%g],A[%g]) with .O[%g] at P[%g]",\
      d-1,d,d,d,d-1,d)
    exec sprintf("drawperp(%g,P[%g],B[%g],O[%g]) with .O[%g] at P[%g]",\
      d-1,d,d,d,d-1,d)
    }
  line outlined graystring((depth-d)/depth) from O[d] to P[d]
  ] }

  depth = 6
  drawperp(depth,O,A,B) with .O[depth] at O
  line from O to A then to B then to O
   
.PE
