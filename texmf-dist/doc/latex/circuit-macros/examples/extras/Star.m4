.PS
# Star.m4
# https://tex.stackexchange.com/questions/605132/how-can-i-insert-a-nine-pointed-star-in-a-latex-document
gen_init

#                           star(keys)
#                           keys: size=expr;
#                                 points=expr;
#                                 angle=expr;     last convex vertex ang
#                                 depth=expr;     inner vertex fraction
#                                 line=attributes;
define(`star',`[ pushkeys_(`$1',
 `size:linewid; points:5; angle:90; depth:1/(m4points-1); line::N')
  dang = 360/m4points
 T: (Rect_(m4size/2*m4depth,m4angle+dang/2)) # concave inner vertex
 S: 1/2 between T and (Rect_(m4size/2,m4angle))
 U: (Rect_(m4size/2,m4angle+dang))           # convex outer vertex
  line m4line from S to T then to U
  for i=1 to m4points-1 do {
   T: (Rect_(m4size/2*m4depth,m4angle+i*dang+dang/2))
   U: (Rect_(m4size/2,m4angle+(i+1)*dang))
   continue to T then to U }
   continue to S; popdef(`size',`points',`angle',`depth',`m4line')]')

linewid = linewid*2
ifelse(1,1,`
star
star(size=1)
star(points=4)
star(depth=1/4)
star(line=outlined "red")
star(points=8)
star(points=9;line=outlined "red" shaded "magenta")
')
#for_(3,8,1,`
#star(points=m4x;line=outlined "red" shaded "magenta")')

.PE
