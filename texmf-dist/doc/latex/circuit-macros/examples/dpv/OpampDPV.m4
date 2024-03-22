.PS
# OpampDPV.m4
cct_init(svg_font(sans-serif,11bp__))

  A: opamp(,,, body=shaded "yellow")
     thinlines_
      `"opamp(,,,"' wid 0.65 ljust at A.sw-(0.4,0.4) \
        `"body=shaded \"yellow\")"' ljust
      `"Out"' below at A.Out
       spline <- from A.In1 left 0.1 then up 0.1 left 0.1
        `"In1"' wid 0.25 rjust above
       spline <- from A.In2 left 0.1 then down 0.1 left 0.1
        `"In2"' rjust below
       arrow <- up 0.1 right 0.1 from A.N
        `"N"' ljust above
       arrow <- up 0.1 right 0.1 from A.E1
        `"E1"' ljust above
       arrow <- up 0.1 right 0.1 from A.E
        `"E"' ljust above
       arrow <- down 0.1 right 0.1 from A.E2
        `"E2"' ljust below
       arrow <- down 0.1 right 0.1 from A.S
        `"S"' ljust below
       arrow <- left 0.2 from A.W
        `"W"' rjust
     thicklines_
     Point_(90)
  B: opamp(,,,,PR) with .sw at A.se+(0.75,0)
     thinlines_
      `"Point_(90);"' ljust at B.sw-(0,0.2) \
      `"opamp(,,,,PR)"' ljust
       spline <- left arrowht down arrowht from B.V1 then left 0.1
        `"V1"' rjust
       spline <- right arrowht down arrowht from B.V2 then right 0.1
        `"V2"' ljust
     thicklines_
     right_
  C: opamp(,,,body=shaded "orange",T) with .sw at B.se+(0.75,0)
      `"opamp(,,,"' wid 0.85 ljust at C.sw+(0,-0.25) \
         `"body=shaded \"orange\",T)"' wid 1.75 ljust

 command `"</g>"' # end font
.PE
