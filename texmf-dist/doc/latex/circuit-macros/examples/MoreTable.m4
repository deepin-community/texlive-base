.PS
# heater.m4
cct_init

Heater:[
{
  {E: lamp(,,shaded "yellow") 
   "`\tt\shortstack[l]{lamp(,{,}\\\;shaded \"yellow\")}'" ljust below \
     at E.start -(textoffset,0) }
  move right_ 1.5
  {E: lamp(,T)
   "`\tt lamp(,T)'" ljust below at E.start -(textoffset,0)}
  move right_ 1.0
  {E: thermocouple
   "`\tt thermocouple'" ljust below at E.start -(textoffset,0)}
  move right_ 1.25
  {E: thermocouple(,,,T)
   "`\tt thermocouple(,{,},T)'" ljust below at E.start -(textoffset,0) }
  }
move down 0.5; right_
{
  definergbcolor(lightred,0.8,0.16,0.16)
  {E: heater(,,,,shaded "lightred")
   "`\tt\shortstack[l]{heater(,{,},{,}\\ \;shaded \"'lightred`\")}'" ljust below \
     at (E.start-(textoffset,0),last [].sw)}
  move right_ 1.5
  {E: heater(,,,,E); move;"`{\tt heater(,{,},{,}E)}'" ljust below \
   at E.start -(textoffset,0) }
  move right_ 1.5
  {E: heater(,,,,ET); move;"`{\tt heater(,{,},{,}ET)}'" ljust below \
    at E.start -(textoffset,0) }
  }
  ]

#.PE
#.PS
## MoreTable.m4
#cct_init

More: [
movewid = 2 pt__
hm = 2.05
vm = 0.28
#{  right; {lamp ; move;"`{\tt lamp}'" ljust}
#   move right_ hm
#   {thermocouple ; move;"`{\tt thermocouple}'" ljust }
#}
#   move down 0.25; right_
{  {memristor ; move;"`{\tt memristor}'" ljust}
#  move right_ hm
#  {heater; move;"`{\tt heater}'" ljust}
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

] with .nw at Heater.sw+(0,-0.3)
.PE
