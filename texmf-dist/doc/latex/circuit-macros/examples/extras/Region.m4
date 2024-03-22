.PS
# Region.m4
# https://tex.stackexchange.com/questions/606088/how-can-i-plot-in-latex
gen_init

  grsize = 3.3
  maxaxis = 4.5
  define Grid { (($1+maxaxis)/(2*maxaxis)*grsize-grsize/2,\
                 ($2+maxaxis)/(2*maxaxis)*grsize-grsize/2) }

thinlines_
  box wid grsize ht grsize with .c at (0,0)
  tic = 0.05
  for x=-maxaxis to maxaxis by 0.5 do {
    line up tic from Grid(x,-maxaxis)
    y = abs(x)
    { if y/2 == int(y/2+0.5) then { sprintf("%g",x) at last line.start below } }
    line down tic from Grid(x,maxaxis)
    line right tic from Grid(-maxaxis,x)
    { if y/2 == int(y/2+0.5) then { sprintf("%g",x) at last line.start rjust } }
    line left tic from Grid(maxaxis,x)
    }
thicklines_

  n = 10
  ylim = 3
  for i=0 to n do { y = i/n*ylim
    P[i]: Grid(sqrt(1+y^2),y) 
    P[-i]:( P[i].x,-P[i].y)
    Q[i]: (-P[i].x, P[i].y)
    Q[-i]:(-P[i].x,-P[i].y) }
  rgbfill(0.6,0.6,0.8,
    fitcurve(P,n,,-n)
    line to (P[n].x,P[n].x) then to (Q[-n].x,Q[-n].x) then to Q[-n]
    fitcurve(Q,n,,-n)
    line to (Q[n].x,-Q[n].x) then to (P[-n].x,-P[-n].x) then to P[-n] )
  
.PE
