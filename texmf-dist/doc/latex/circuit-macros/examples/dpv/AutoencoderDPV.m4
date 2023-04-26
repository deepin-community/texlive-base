.PS
# Masked_Autoencoder.m4
gen_init
NeedDpicTools
svg_font(sans-serif,12bp__,textoffset)

  circlerad = 0.2
  circlesep = 0.5
  rowsep = 0.9
  arrowht = arrowht*0.8
  arrowwid = arrowwid*1.4
  linethick = 1

define plan {
  m = 0
  for i=1 to 4 do {
    for j=1 to ncircles[i] do {
      exec sprintf("C[i,j]: circle thick 1.6 \"%g\" at Here",m+j)
      if i>1 then {
        if "$1"=="" then {
          for k=1 to ncircles[i-1] do { arrow from C[i,j] to C[i-1,k] chop } }
        }
      if j!=ncircles[i] then { move right_ circlesep from C[i,j] }
      }
    m += ncircles[i]
    case(i,
      move to C[1,1]+(-circlesep/2,-rowsep),
      move to C[2,1]+(0,-rowsep),
      move to C[3,1]+(circlesep/2,-rowsep), )
    }
  }
  gridsiz = 0.78/4
define grid { [ SW: 0,0
  for i=1 to $1 do {
    move to (0,(0.5-i)*gridsiz)
    exec sprintf("fv = $%g",2+i)
    for j=1 to $2 do { fl = 1-(int(fv / 2^(j-1)) % 2)
      box wid gridsiz ht gridsiz outlined "gray" shaded rgbstring(fl,fl,fl) }
    } ]}

define cxt {
  m = 1
  for i=2 to 4 do {
    for j=1 to ncircles[i] do {
      exec sprintf("narrows = $%g",m)
      for k=1 to narrows do {
        exec sprintf("cnum = $%g",m+k)
        exec sprintf("arrow from C[i,j] to C[i-1,cnum] $%g chop", $+)
        }
      m += narrows+1 
      } } }

B: box invis ht 8 wid 8
[
  array(ncircles,3,4,4,3)
  plan()
  svg_font(Times,12bp__,textoffset)
  for j=1 to 3 do {
    sprintf("svg_it(x)`'svg_sub(%g,60%)",j) at C[1,j].n+(0,2bp__) above
    "svg_circ" at last ""+(-1bp__,1bp__)
    sprintf("svg_it(x)`'svg_sub(%g,60%)",j) at C[4,j].s+(0,-2bp__) below
    }

  "V" at 0.5 between C[2,1].w and C[1,1].w
  "W`'svg_sup(2)" at 0.5 between C[3,1].w and C[2,1].w
  "W`'svg_sup(1)" at 0.5 between C[3,1].w and C[4,1].w

GV: grid(3,4,0,15,6) with .w at C[2,4]+(circlerad*2,rowsep/2)
  "=M`'svg_sup(V)" at GV.e ljust
G2: grid(4,4,13,0,0,13) with .w at (GV.w,C[3,4]+(circlerad*2,rowsep/2))
  "=M`'svg_sup(V`'svg_sup(2))" at G2.e ljust
G1: grid(4,3,1,5,1,1) with .w at (GV.w,C[4,3]+(circlerad*2,rowsep/2))
  "=M`'svg_sup(V`'svg_sup(1))" at G1.e ljust
  command "</g>"

  move to (GV.x+3*circlesep,C[1,1].y)
  plan(3,1,2,1,2,2,1,2,1,2,2,3,1,2)
  for i=2 to 4 do {
      cxt(2,1,3,0,0,2,1,3, 0,4,1,2,3,4,0,0, 0,4,1,2,3,4,0, \
        outlined rgbstring(0.5,0.5,0.5) shaded rgbstring(0.5,0.5,0.5) )
    cxt(0,1,1,1,1,0, 2,2,3,0,2,2,3,2,2,3, 0,0,3,1,3,4,)
    }
  svg_font(Times,12bp__,textoffset)
  for j=1 to 3 do { sprintf("svg_it(x)`'svg_sub(%g,60%)",j) \
    at C[4,j].s+(0,-2bp__) below }
  arrow dotted from C[1,2].n up circlesep/2
  "svg_it(p(x`'svg_sub(2)))" at Here+(0,2bp__) above
  "svg_it(p(x`'svg_sub(3)|x`'svg_sub(2)))" at (C[1,3]+(circlesep/2,0),last "")
  arrow dotted from C[1,3] to last "".s chop circlerad chop textoffset
  "svg_it(p(x`'svg_sub(1)|x`'svg_sub(2),x`'svg_sub(3)))" \
    at (C[1,1]+(-circlesep/2,0),last "")
  arrow dotted from C[1,1] to last "".s chop circlerad chop textoffset
  command "</g>"

 ] at B
 command "</g>"
.PE
