.PS
# Wheel.m4
# https://tex.stackexchange.com/questions/605178/drawing-a-directed-wheel-graph-with-tikz
gen_init

  linethick = 1.6
  nnodes = 9
  brad = 2
  srad = circlerad/2
  P: circle rad srad at (1,0.5) fill_(0.75)
  A: Rect_(brad,90+360/nnodes)
  for i=1 to nnodes do {
    B: circle invis shaded "lightgray" at Rect_(brad,90-(i-1)/nnodes*360) \
      sprintf("\Huge %g",i) 
    line from B to P chop circlerad chop srad
    line from B to A chop
    A: B
    }

.PE
