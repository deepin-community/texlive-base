.PS
# Inductors.m4
cct_init
ifpostscript(,latexcommand({\tt)) # disable "command" for psfrag

movewid = 2 pt__
hm = 2.05
vm = 0.4
{ {I: inductor ; move ;"`{inductor}'" ljust}
   move right_ hm
   {inductor(,W); move ;"`{inductor(,W)}'" ljust}
   move right_ hm
   {inductor(,L); move ;"`{inductor(,L)}'" ljust}
}

   move down vm; right_
{ {inductor(,,3,M) ; move ;"`{...(,,3,M)}'" ljust}
   move right_ hm
   {inductor(,W,6,P1); variable; move
    "`...(,W,6,P1);'" ljust "`variable'" ljust}
   move right_ hm
   {inductor(,L,9,K); move ;"`{...(,L,9,K)}'" ljust}
}

   move down vm; right_
{ {inductor(,,,M3); addtaps(-,1/2,-dimen_/6); move; `"...(,{,},M3)"' ljust
    {`"addtaps(-,1/2,-dimen\_/6)"' ljust at (I.start,last ""+(0,-0.2)) }
    }
   move right_ hm
  {ebox(,,,0) ; move ;"`{ebox(,{,},0)}'" ljust}
   move right_ hm -10bp__
  {TI: tapped(`ebox(,,,0)',-,1/4,-dimen_/6,3/4,-dimen_/6) ; move ;
   "`tapped(\char96{}ebox(,{,},0)\char39,'" ljust at Here+(10bp__,3bp__)
   "`-,1/4,-dimen\_/6,'" ljust at last ""+(0,-11pt__)
   "`3/4,-dimen\_/6)'" ljust at last ""+(0,-11pt__)
   "\sl Tap1" at TI.Tap1 rjust below
   "\sl Tap2" at TI.Tap2 ljust below }
}

   move down vm*5/4; right_
{ {shielded(`inductor(,,,M)') ; move
   `"shielded("' ljust `"\char96inductor(,{,},M)\char39)"' ljust
   move to (3rd last line.start,Here)
   shielded(`ebox(,,,0)',R) ; move; `"shielded(`ebox(,{,},0)',R)"' ljust }
}

ifpostscript(,latexcommand(}))
.PE
