.PS
# `AmptableMan.m4'
cct_init
divert(-1)

divert(0)dnl

movewid = 2pt__
{
   {amp ; move ; "{\tt `amp'}" ljust}
   move right_ 2.0
   {amp(,5mm__) ; move ; "\tt `amp'(,5mm\_\_)" ljust}
   move right_ 2.0
   {integrator ; move ; "\tt `integrator'" ljust}
  }
   move down 0.5; right_
{
   {delay(,,fill_(0.9)) ; move ;
    "`\tt\shortstack[l]{delay(,{,}\\ fill\_(0.9))}'" ljust}
   move right_ 2.0
   {delay(,,type=S;body=shaded "blue!25"); move
   "{\tt `delay'(,,type=S;}" ljust "{\tt body=shaded \"blue!25\")}" ljust}
  }

.PE
