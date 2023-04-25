.PS
# `CapacitorsDPV.m4'
cct_init(svg_font(sans-serif,11pt__))
textwid = 1.5
movewid = 2 pt__
hm = 2.1
vm = 0.28

hm = 2.05
vm = 0.28
{  {capacitor ; move ; "`capacitor '" ljust}
   move right_ hm
   {capacitor(,C); move ; "`capacitor(,C) '" ljust}
   move right_ hm
   {capacitor(,C+); move ; "`capacitor(,C+) '" ljust}
}
   move down vm; right_
{  {capacitor(,P); move ; "`capacitor(,P) '" ljust}
   move right_ hm
   {capacitor(,E); move ; "`capacitor(,E) '" ljust}
   move right_ hm
   {capacitor(,K); move ; "`capacitor(,K) '" ljust}
}
   move down 0.25; right_
{  {capacitor(,M); move ; "`capacitor(,M) '" ljust}
   move right_ hm
   {capacitor(,N); move ; "`capacitor(,N) '" ljust}
   move right_ hm
   {capacitor(,CP); move ; "`capacitor(,CP) '" ljust}
#  {xtal ; move ; "`xtal '" ljust}
}
   move down 0.25; right_
{  {capacitor(,dC); move ;"`capacitor(,dC) '" ljust}
   move right_ hm
   {capacitor(,dF); move ;"`capacitor(,dF) '" ljust}
   move right_ hm
   {variable(`capacitor',NN,-30,dimen_/3)
   move ;"`variable('svg_grave`capacitor'svg_prime`,'" wid 97bp__ ljust \
         "`      NN,-30,dimen_/3)'" ljust }
}

 command "</g>" # end font
.PE
