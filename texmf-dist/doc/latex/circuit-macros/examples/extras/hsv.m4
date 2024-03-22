.PS
# hsv.m4
gen_init
NeedDpicTools

define grid { (($2)*boxwid,($1)*boxht) }
r = 0
g = 0
b = 1
rgbtohsv(r,g,b,h,s,v)
nstep = 4
{ for j=0 to nstep do {
    sprintf("%g",j/nstep) at ((0.5+j)*boxwid,-boxht/2) below } }
  { "S" at ((0.5+nstep/2)*boxwid, -boxht) }
{ for i=0 to nstep do { sprintf("%g",i/nstep) at (-boxht/3,(i)*boxht) } }
  { "V" at (-boxht,(nstep/2)*boxht) \
    "or" \
    "L" }
right_
for v = 0 to nstep do {
  { for s = 0 to nstep do { hsvtorgb(h,s/nstep,v/nstep,r,g,b)
      box shaded rgbstring(r,g,b) } }
  move up_ boxht; right_ }


.PE
