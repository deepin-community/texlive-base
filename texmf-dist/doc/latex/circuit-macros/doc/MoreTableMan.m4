.PS
# MoreTableMan.m4
cct_init

movewid = 2 pt__
hm = 2.05
vm = 0.28
   move down 0.25; right_
{  {memristor ; move;"`{\tt memristor}'" ljust}
   move right_ hm
   {tline ; move;"`{\tt tline}'" ljust}
}
   move down 0.25; right_
{ {pvcell ; move;"`{\tt pvcell}'" ljust}
   move right_ hm
   {reed ; move ;"`{\tt reed}'" ljust}
   move right_ hm
   {reed(,,,fill_(0.9),CR) ; move ; "`{\tt reed(,{,},fill\_(0.9),CR)}'" ljust}
}
   move down 0.25; right_
{  {gap ; move ;"`{\tt gap}'" ljust}
   move right_ hm
   {gap(,,A) ; move ;"`{\tt gap(,{,}A)}'" ljust}
   move right_ hm
  {arrowline ; move;"`{\tt arrowline}'" ljust}
}
   move down 0.25; right_
{  {xtal ; move ;"`{\tt xtal}'" ljust}
   move right_ hm
   {xtal(,type=R;outerdiam=0.2) ; move ;"`{\tt xtal(,type=R)}'" ljust}
}

.PE
