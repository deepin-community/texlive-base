.PS
# Ant.m4 (Langton's ant)
# https://tex.stackexchange.com/questions/361838/how-to-create-a-langtons-ant-in-latex/361891
# https://en.wikipedia.org/wiki/Langton%27s_ant
gen_init
NeedDpicTools
 picwid = 5
 D: (0,0); DD: (1,0); t[D] = 0
 minx = 0; miny = 0; maxx = 0; maxy = 0
 for i = 0 to 10500 do {
  if (t[D]%2) == 0 then { DD: (-DD.y,DD.x) } else { DD: (DD.y,-DD.x) }
  t[D] += 1
  D: D+DD
  if D.x > maxx then { maxx = D.x; for y = miny to maxy do { t[maxx,y] = 0 }} \
  else { if D.x < minx then {
   minx = D.x; for y = miny to maxy do { t[minx,y] = 0 }}}
  if D.y > maxy then { maxy = D.y; for x = minx to maxx do { t[x,maxy] = 0 }} \
  else { if D.y < miny then {
   miny = D.y; for x = minx to maxx do { t[x,miny] = 0 }}}
  }
 boxwid = picwid/(maxx-minx)
 boxht =  picwid/(maxy-miny)
 if boxht > boxwid then { boxht = boxwid } else { boxwid = boxht }
 circlerad = boxht/2
 hue = 240; val = 1
 for i = minx to maxx do { for j = miny to maxy do {
  if t[i,j]!=0 then { sat = (t[i,j]%20)/20
   hsvtorgb(hue,sat,val,r,g,b)
   circle colored rgbstring(r,g,b) at (-i,j)*boxwid } }}
.PE
