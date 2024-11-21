.PS
#QTrans.m4
cct_init
elen = 0.75
  Vs: source(up_ elen,S); llabel(-,V_s,+)
     resistor(right_ elen);  rlabel(,R_s)
     dot
     { capacitor(down_ to (Here,Vs.start))
       rlabel(+,V,-); llabel(,{1\over{j\omega C}},)
       dot }
    arrowline(right_ elen*2/3); llabel(,I)
  T1: transformer(down_ Vs.len,,6,,4) with .P1 at Here # Place P1
    "$T1$" at last [].n above
    line from T1.P2 to Vs.start
    line from T1.S1 up_ to (T1.S1,Vs.end) then right_ elen*2/3
    resistor(down_ Vs.len); rlabel(,R_L); b_current(I_L,rjust)
    line to (T1.S2,Here) then to T1.S2
.PE
