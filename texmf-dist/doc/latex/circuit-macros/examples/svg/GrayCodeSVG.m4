.PS
# Gray_code.m4
gen_init

GrayCode: [
  outer = 4
  inner = 0.75
  nbits = 10

C: circle diam outer
  circle diam inner at C
  sectors = 2^nbits
  lthk = (outer-inner)/2/nbits
  for bit = 1 to nbits do {
    for is = 2^(bit-1) to sectors by 2^(bit+1) do {
      startang = is/sectors*360
      endang = min(startang+(2^bit)/sectors*360,360)
      arcd(C,outer/2-(bit-0.5)*lthk,startang,endang) thick lthk/(1bp__)
      }
    }
  ]
Crossbar: [
#.PS
# Crossbar switch
#gen_init
  svg_font(sans-serif,11bp__)
  circlerad = 0.12
  boxwid = 0.18
  boxht = 0.18
  rathick = 1.5
  rawd = rathick*4 bp__
  raht = rawd*2
  boxdist = boxwid*1.8

`define bcoord {($2,-($1))*boxdist}'
`define redarrow { arrow ht raht wid rawd thick rathick color "red" }'

`define cbx {'
  thinlines_
  n = $+ - 1
  for i=0 to n do {
    line color "blue" from bcoord(i,0) to bcoord(i,n)
    line color "blue" from bcoord(0,i) to bcoord(n,i)
    C[i]: circle invis at bcoord(i,-1.5)
    }
  for i=0 to n do {
    exec sprintf("col = $%g",i+1)
    redarrow from C[i].e right 1.25*boxwid
    redarrow from C[i].w+(-boxwid,0) right raht
    for j=0 to n do {
      B: box color "blue" shaded "yellow" at bcoord(i,j)
      if j==col then {
        line color "blue" from B.s to B.e
        line thick rathick color "red" from C[i].e to B.w \
          then to B.n then to (B.x,C[0].y+(2+j*2/3)*boxht)
          continue to (C[j].x-(2+j*2/3)*boxht,Here.y)
          continue to (Here,C[j]) then to C[j].w
        } \
      else {
        line color "blue" from B.n to B.s
        line color "blue" from B.w to B.e
        }
      }
    } 
  thicklines_
  for i=0 to n do {
    circle thick 1.5 outlined "blue" shaded "yellow" at C[i] \
      sprintf("ifpostscript(,ifsvg(,\large))%g",i)
    }
  }

[
  cbx(3,6,0,5,2,7,1,4)
  ] at 4,4

 command "</g>" # end font
#.PE
  ] with .w at last [].e+(0.25,0)
.PE
