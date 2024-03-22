.PS
# RandomNodes.m4
gen_init
NeedDpicTools

  scale = 2.54
  n = 300
  msiz = 4.90*2
  maxdist = 1.0

  box wid msiz ht msiz with .sw at (0,0)
  for i=1 to n do { X[i] : (rand(), rand())*msiz }
  for i=1 to n-1 do { for j=i+1 to n do {
    if distance(X[i],X[j]) <= maxdist then { 
      line outlined "green" from X[i] to X[j]
      } } }
  for i=1 to n do { circle rad dotrad_ at X[i] shaded "green" }

.PE
