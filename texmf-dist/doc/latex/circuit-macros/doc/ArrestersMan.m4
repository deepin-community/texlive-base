.PS
# ArrestersMan.m4
cct_init

  sep = 0.2

R1: [
  arrester
  {`"\tt arrester"' at last line.c+(0,-0.2)}
  move sep
  arrester(,G)
  {`"\tt arrester(,G)"' at last line.c+(0,-0.2)}
  move sep
  arrester(,g)
  {`"\tt ...(,g)"' at last line.c+(0,-0.2)}
  move sep
  arrester(,M)
  {`"\tt \ldots(,M)"' at last line.c+(0,-0.2)}
  move sep
  arrester(,C)
  {`"\tt \ldots(,C)"' at last line.c+(0,-0.2)}
  move sep
  arrester(,A)
  {`"\tt \ldots(,A)"' at last line.c+(0,-0.2)}
  ]

R2: [
  arrester(,H)
  {`"\tt \ldots(,H)"' at last line.c+(0,-0.2)}
  move sep
  arrester(,HR)
  {`"\tt \ldots(,HR)"' at last line.c+(0,-0.2)}
  move sep
  arrester(,P)
  {`"\tt \ldots(,P)"' at last line.c+(0,-0.2)}
  move sep
  arrester(,s)
  {`"\tt \ldots(,s)"' at last line.c+(0,-0.2)}
  move sep
  arrester(,F)
  {`"\tt \ldots(,F)"' at last line.c+(0,-0.2)}
  move sep
  arrester(,S)
  {`"\tt \ldots(,S)"' at last line.c+(0,-0.2)}

  ] with .nw at R1.sw+(0,-0.2)

  define(`Dlabels',
  `{ thinlines_
    arrow <- from A.A up 0.1 left 0.1; "\sl A" rjust
    arrow <- from A.B up 0.1 right 0.1; "\sl B" ljust
    arrow <- from A.G up 0.05 right 0.15; "\sl G" ljust
    thicklines_ }')
[
  arrester(,E)
  {`"\tt \ldots(,E)"' at last line.c+(0,-0.25)}
  move up_ 0.1 then right_ sep
  A: arrester(,DE,,,fill_(0.95))
  {`"\tt \ldots(,DE,{,},"' wid 61bp__ at A.A+(-0.1,-0.40) ljust \
   `"\tt fill\_(0.95))"' ljust }
  Dlabels
  move down_ 0.1 then right_ sep*3
  A: arrester(,DS)
  {`"\tt \ldots(,DS)"' at last [].s+(0,-0.1)}
  Dlabels
  move sep*3
  A: arrester(,DEL)
  {`"\tt \ldots(,DEL)"' at last [].s+(0,-0.1)}
  Dlabels
  move sep*3
  A: arrester(,DSL)
  {`"\tt \ldots(,DSL)"' at last [].s+(0,-0.1)}
  Dlabels
  ] with .nw at R2.sw+(0,-0.2)

.PE
