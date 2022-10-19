.PS
# MoreTable.m4
cct_init

movewid = 2 pt__
hm = 2.05
vm = 0.28
{  {memristor ; move;"`{\tt memristor}'" ljust}
   move right_ hm
   {heater; move;"`{\tt heater}'" ljust}
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
{  move down 0.10; right; {lamp ; move;"`{\tt lamp}'" ljust}
   move right_ hm
   {thermocouple ; move;"`{\tt thermocouple}'" ljust }
#  move up 0.10 right_ hm
#  {arrester ; move ;"`{\tt arrester}'" ljust}
}

.PE
