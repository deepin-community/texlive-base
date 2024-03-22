.PS
gen_init
[
# TR_fill.m4
# https://tex.stackexchange.com/questions/654117/fill-parts-of-a-shape
  B: (0,0); "B" at B below
  C: (5,0); "C" at C below
  A: Cintersect(B,4,C,3); "A" at A above
  line from B to C then to A then to B
  RightAngle(B,A,C,0.25)

  rgbfill(0.5,0.5,0.5,
    arc from A to B rad 2
    arc cw to C rad 2.5
    arc to A rad 1.5 )
  ]
[
# Fillbetween
# https://tex.stackexchange.com/questions/688273/polar-curve-shading-error-with-fillbetween
NeedDpicTools
  
  sc = 0.5
  define coord {(($1,$2)*sc)}
  define X1 {coord(Rect_(6*sind($1),$1))}
  define X2 {coord(Rect_(2+2*sind($1),$1))}
  define interp {$1+($2-($1))*($3)}
  define axes {
    arrow from coord(-6,0) to coord(6,0)
      "$x$" rjust above
      for x=-5 to 5 do {line up_ 0.1 at coord(x,0)}
      "${-}5$" at coord(-5,-0.05/sc) below
      "${}5$" at coord(5,-0.05/sc) below
    arrow from coord(0,-2) to coord(0,7)
      "$y$" at Here+(8bp__,-10bp__)
      for y=-1 to 5 do {line right 0.1 at coord(0,y)}
      "${}5$" at coord(-0.05/sc,5) rjust
    }

  n = 36
  for i=0 to n do { t = interp(30,150,i/n); C3[i]: X1(t) }
  for i=0 to n do { t = interp(150,150-360,i/n); C4[i]: X2(t) }
  for i=0 to n do { t = interp(150,210,i/n); C5[i]: X1(t) }
  rgbfill(0.9,0.9,0.9,
    fitcurve(C3,n)
    fitcurve(C4,n)
    fitcurve(C5,n) )
  fitcurve(C3,n,outlined "orange" )
  fitcurve(C4,n,outlined "red" )
  fitcurve(C5,n,outlined "orange" )

  axes
  ] with .nw at last [].sw+(0,-0.2)

.PE
