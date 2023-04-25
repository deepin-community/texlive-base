.PS
# Capacitors.m4
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
   {capacitor(,CP); move ;"`{\tt capacitor(,CP)}'" ljust}
}
   move down 0.25; right_
{  {capacitor(,dC); move ;"`{\tt capacitor(,dC)}'" ljust}
   move right_ hm
   {capacitor(,dF); move ;"`{\tt capacitor(,dF)}'" ljust}
   move right_ hm
   {variable(`capacitor',NN,-30,dimen_/3); move
#    Stacking the strings normally does not work because the .pdf uses the
#    length of the last line.
   "`{\tt variable(}{\rm}{\tt capacitor}{\rm}{\tt,}'" ljust
   "`{\enskip\tt NN,-30,dimen\_/3)}'" ljust at last ""+(0,-12pt__)
   }
}
.PE
