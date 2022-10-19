.PS
# `Capacitors.m4'
cct_init

movewid = 2 pt__
hm = 2.05
vm = 0.28
{  {capacitor ; move ;"`{\tt capacitor}'" ljust}
   move right_ hm
   {capacitor(,C); move ;"`{\tt capacitor(,C)}'" ljust}
   move right_ hm
   {capacitor(,C+); move ;"`{\tt capacitor(,C+)}'" ljust}
}
   move down vm; right_
{  {capacitor(,P); move ;"`{\tt capacitor(,P)}'" ljust}
   move right_ hm
   {capacitor(,E); move ;"`{\tt capacitor(,E)}'" ljust}
   move right_ hm
   {capacitor(,K); move ;"`{\tt capacitor(,K)}'" ljust}
}
   move down 0.25; right_
{  {capacitor(,M); move ;"`{\tt capacitor(,M)}'" ljust}
   move right_ hm
   {capacitor(,N); move ;"`{\tt capacitor(,N)}'" ljust}
   move right_ hm
   {xtal ; move ;"`{\tt xtal}'" ljust}
}
   move down 0.25; right_
{  {capacitor(,dC); move ;"`{\tt capacitor(,dC)}'" ljust}
   move right_ hm
   {capacitor(,dF); move ;"`{\tt capacitor(,dF)}'" ljust}
   move right_ hm
   {variable(`capacitor',NN,-30,dimen_/3)
   move ;`"{\tt variable(}`{\tt capacitor',}"' ljust \
  `"{\enskip\tt NN,-30,dimen\_/3)}"' ljust
     }
}
.PE
