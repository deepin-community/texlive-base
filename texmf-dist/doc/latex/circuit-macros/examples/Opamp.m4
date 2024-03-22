.PS
# Opamp.m4
sinclude(FOpamp.dim)
sinclude(Circuit_macros.dim)
sinclude(tst.dim)
s_init(Opamp)
cct_init
  A: opamp(,,,\;body=shaded "yellow")
     thinlines_
       s_box(`\tt\shortstack[l]{opam{}p(,{,},\\body=shaded \"`yellow'\")}') \
         at A.s-(0,0.35)
       s_box(\sl Out) below at A.Out
       spline <- from A.In1 left 0.1 then up 0.1 left 0.1
         s_box(\sl In1) rjust above
       spline <- from A.In2 left 0.1 then down 0.1 left 0.1
         s_box(\sl In2) rjust below
       arrow <- up 0.1 right 0.1 from A.N
         s_box(\sl N) ljust above
       arrow <- up 0.1 right 0.1 from A.E1
         s_box(\sl E1) ljust above
       arrow <- up 0.1 right 0.1 from A.E
         s_box(\sl E) ljust above
       arrow <- down 0.1 right 0.1 from A.E2
         s_box(\sl E2) ljust below
       arrow <- down 0.1 right 0.1 from A.S
         s_box(\sl S) ljust below
       arrow <- left 0.2 from A.W
         s_box(\sl W) rjust
     thicklines_
     Point_(90)
  B: opamp(,,,,PR) with .sw at A.se+(1,0)
     thinlines_
       s_box(`\tt\shortstack[l]{Point\_(90);\\opam{}p(,{,},{,}PR)}') \
         at B.s-(0,0.20)
       spline <- left arrowht down arrowht from B.V1 then left 0.1
       s_box(\sl V1) rjust
       spline <- right arrowht down arrowht from B.V2 then right 0.1
       s_box(\sl V2) ljust
     thicklines_
     right_
  D: opamp(,,,body=shaded "orange",T) with .sw at B.se+(0.95,0)
       s_box(`\tt\shortstack[l]{opam{}p(,{,},\\body=shaded \"`orange'\"\\,T)}') \
         at D.s+(0.2,-0.25)

.PE
