.PS
# heaterMan.m4
cct_init

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
  {E: heater(,,,,shaded "red!50")
   "`\tt\shortstack[l]{heater(,{,},{,}\\ \;shaded \"red!50\")}'" ljust below \
     at (E.start-(textoffset,0),last [].sw)}
  move right_ 1.5
  {E: heater(,,,,E); move;"`{\tt heater(,{,},{,}E)}'" ljust below \
   at E.start -(textoffset,0) }
  move right_ 1.5
  {E: heater(,,,,ET); move;"`{\tt heater(,{,},{,}ET)}'" ljust below \
    at E.start -(textoffset,0) }
  }

.PE
