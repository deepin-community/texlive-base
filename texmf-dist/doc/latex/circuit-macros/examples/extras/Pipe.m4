.PS
# How about ladder diagrams?
gen_init
NeedDpicTools

  { for x=0 to 5 do { line up 5 from (x,0) } }
  { for y=0 to 5 do { line right 5 from (0,y) } }
 posarray(A,
  (1,0.5),
  (4,0.5),
  (4.5,1),
  (4.5,3),
  (4,3.5),
  (3.5,3),
  (3,2.5),
  (1,2.5),
  (0.5,3),
  (0.5,4),
  (1,4.5),
  (4,4.5))
 P[0]: 1,0.5
 P[1]: 4.5,0.5
 P[2]: 4.5,3.5
 P[3]: 3.5,3.5
 P[4]: 3.5,2.5
 P[5]: 0.5,2.5
 P[6]: 0.5,4.5
 P[7]: 4,4.5
 
  r = 0.4
 define(`curve',
 ` move to P[0]
   for i_c=1 to 6 do { arcto(P[i_c],P[i_c+1],r,`$1') }
   line to P[7] `$1'')
 
  lw = 0.3/(1bp__)
  lt = 1.8
  for i=0 to 6 do {
   curve(thick lw-lt*i outlined rgbstring(0.1+i/10,0.1+i/10,0.1+i/10))}
.PE
