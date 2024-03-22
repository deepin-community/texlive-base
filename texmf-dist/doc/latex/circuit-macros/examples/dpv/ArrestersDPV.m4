.PS
# ArrestersDPV.m4
cct_init

  sep = 0.2

R1: [
  arrester
  {"svg_tt(`arrester')" at last line.c+(0,-0.2)}
  move sep
  arrester(,G)
  {"svg_tt(`arrester(,G)')" at last line.c+(0,-0.2)}
  move sep
  arrester(,g)
  {"svg_tt(...(,g))" at last line.c+(0,-0.2)}
  move sep
  arrester(,M)
  {"svg_tt(...(,M))" at last line.c+(0,-0.2)}
  move sep
  arrester(,C)
  {"svg_tt(...(,C))" at last line.c+(0,-0.2)}
  move sep
  arrester(,A)
  {"svg_tt(...(,A))" at last line.c+(0,-0.2)}
  ]

R2: [
  arrester(,H)
  {"svg_tt(...(,H))" at last line.c+(0,-0.2)}
  move sep
  arrester(,HR)
  {"svg_tt(...(,HR))" at last line.c+(0,-0.2)}
  move sep
  arrester(,P)
  {"svg_tt(...(,P))" at last line.c+(0,-0.2)}
  move sep
  arrester(,s)
  {"svg_tt(...(,s))" at last line.c+(0,-0.2)}
  move sep
  arrester(,F)
  {"svg_tt(...(,F))" at last line.c+(0,-0.2)}
  move sep
  arrester(,S)
  {"svg_tt(...(,S))" at last line.c+(0,-0.2)}

  ] with .nw at R1.sw+(0,-0.2)

  define(`Dlabels',
  `{ thinlines_
    arrow <- from A.A up 0.1 left 0.1; "svg_it(A)" rjust
    arrow <- from A.B up 0.1 right 0.1; "svg_it(B)" ljust
    arrow <- from A.G up 0.05 right 0.15; "svg_it(G)" ljust
    thicklines_ }')
  sep = 0.35
[
  arrester(,E)
  {"svg_tt(...(,E))" at last line.c+(0,-0.25)}
  move up_ 0.1 then right_ sep
  A: arrester(,DE,,,fill_(0.95))
  {"svg_tt(...svg_lparen,DE,,,)" wid 61bp__ at A.A+(-0.1,-0.4) ljust \
   "svg_tt(fill`'svg_fsize(_,65)`'svg_lparen`0.95'svg_rparen`'svg_rparen)" ljust}
  Dlabels
  move down_ 0.1 then right_ sep*3
  A: arrester(,DS)
  {"svg_tt(...(,DS))" at last [].s+(0,-0.1)}
  Dlabels
  move sep*3
  A: arrester(,DEL)
  {"svg_tt(...(,DEL))" at last [].s+(0,-0.1)}
  Dlabels
  move sep*3
  A: arrester(,DSL)
  {"svg_tt(...(,DSL))" at last [].s+(0,-0.1)}
  Dlabels
  ] with .nw at R2.sw+(0,-0.2)

.PE
