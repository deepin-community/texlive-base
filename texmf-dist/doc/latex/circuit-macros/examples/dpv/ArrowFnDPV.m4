.PS
# ArrowFnDPV.m4
# https://tex.stackexchange.com/questions/581089/arrow-function-diagrams
gen_init
  brad = 0.04
  bht = 0.4
  bwid = 0.25
define(`rbox',`box rad brad outlined "Orange"')

B1: [
  svg_font(Times,14bp__)
  linethick = 1.2
  arrowwid = 0.08
  rbox wid 5*boxwid ht 3/2*boxwid
  line from last box.w-(bht/4,0) "svg_it(X)" above ljust
T: Here
  arrow up bwid right bwid then right bwid
F: rbox ht bht "svg_it(f)"
  {"svg_it(Y)" above ljust }
  arrow down bwid right bwid from T then right boxwid + bwid*3/2
G: rbox ht bht "svg_it(g)"
  {"svg_it(Z)" above ljust }
S: circle diam bht "svg_it(+)" at (G.e.x+boxwid,(F.y+G.y)/2)
  d = F.y-S.nw.y
  arrow from F.e to S.nw+(-d,d) then to S.nw
  arrow from G.e to S.sw+(-d,-d) then to S.sw
  arrow right from S.e
  command "</g>" # end font
  ]
[
  svg_font(Times,11bp__)
  bht = bht/2
  sbwid = boxwid*3/4
  bbwid = sbwid*5/4
  dh = bht/2
B1: rbox wid bbwid ht bbwid
B2: rbox wid sbwid*3/2 ht bbwid at B1+(3/2*bbwid,0)
B3: rbox wid bbwid ht bbwid at B2+(3/2*bbwid,0)
B4: rbox wid sbwid*3/2 ht bbwid at B3+(3/2*bbwid,0)
B5: rbox wid bbwid ht bbwid at B4+(3/2*bbwid,0)
 F: rbox ht bht wid sbwid at B2.n-(0,bht*3/4) "svg_it(f)"
BR: B2.s+(0,B2.n.y-F.y)
 G: rbox ht bht wid sbwid at (B4,F) "svg_it(g)"
 S: circle diam bht*3/2 at B5+(bht/2,0) "svg_it(+)"
  arrow right from S.e
 T: B1.w+(dh,0)
B:  rbox ht bbwid*5/4 wid boxwid*7.25 with .w at T-(sbwid*3/4,0)
  { line from T left sbwid "svg_it(x)" above ljust }
  arrow from T to (B1.e-(dh,0),F) then to F.w
  arrow from F.e to (B3.w+(dh,0),F) then to (B3.e-(dh,0),BR)
  continue to (B5.w+(dh,0),Here) then to S.sw 
  line thick 5 outlined "white" from B3.sw to B3.ne chop brad
  arrow from T to (B1.e-(dh,0),BR) then to (B3.w+(dh,0),BR) \
    then to (B3.e-(dh,0),G) then to G.w
  arrow from G.e to (B5.w+(dh,0),G) then to S.nw
  command "</g>" # end font
  ] with .nw at B1.sw+(0,-0.2)

.PE
