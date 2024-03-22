.PS
# Optics.m4
# https://tex.stackexchange.com/questions/623201/geometrical-optics
gen_init
scale = 2.54

  textoffset = 4pt__
 O: dot(at (0,0)) ; "\Large $O$" below rjust
 L: line thick 1 right_ 14 with .c at O
 S: dot(at (1.8,0)) ; "\Large $S$" below rjust
  r = 7
 C: dot(at (S.x-r,0)) ; "\Large $C$" below
 F: dot(at (-1.8,0)) ; "\Large $F$" below
 I: dot(at (4,0)) ; "\Large $I$" below
  arrow dashed from I up_ 3.2 ; It: Here
 AS: C.x+sqrt(r^2-3.7^2),3.7
 Arc: arc thick 1 cw from AS to (AS.x,-AS.y) rad r with .c at C
  for y=-AS.y to AS.y+0.001 by 0.1 do { line thick 0.4 right 0.5 up 0.1 \
    from (C.x+sqrt(r^2-y^2),y) }
 M: move from C to It
 A1: arrow outlined "red" from C to LCintersect(M,C,r,R) chop -2 chop 0
  arrow outlined "red" dashed to It chop 0 chop -3
 N: move from It to F
  arrow <- outlined "red" dashed from It to LCintersect(N,C,r) chop -2 chop 0
 P: move down_ 1 from A1.start
  arrow outlined "red" from last arrow.end to Intersect_(P,N)
 Q: move up 1 from O
  arrow from O to Intersect_(Q,M)
  arrow outlined "red" to (C.x+sqrt(r^2-Here.y^2),Here.y)

.PE
