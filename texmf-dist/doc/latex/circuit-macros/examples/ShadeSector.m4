.PS
# ShadedSector.m4
# https://tex.stackexchange.com/questions/635327/multi-color-circular-gradient-in-tikz

gen_init
NeedDpicTools

  rx = 4
  n = int(rx/lthick)
  for i=1 to n do { left_
    hsvtorgb((1-i/n)*180,1,1,r,g,b)
    arc rad i/n*rx with .c at (0,0) outlined rgbstring(r,g,b) }

.PE
