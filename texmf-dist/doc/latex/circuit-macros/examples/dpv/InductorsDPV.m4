.PS
# `Inductors.m4'
cct_init(svg_font(sans-serif,10pt__))
textwid = 1.5
movewid = 2 pt__
hm = 2.1
vm = 0.28

hm = 2.05
vm = 0.28
{  {inductor ; move ; "`inductor '" ljust}
   move right_ hm
   {inductor(,W); move ; "`inductor(,W) '" ljust}
   move right_ hm
   {inductor(,L); move ; "`inductor(,L) '" ljust}
}
   move down vm; right_
{ {inductor(,,3,M) ; move ;"`...(,,3,M) '" ljust}
   move right_ hm
   {inductor(,W,6,P1); variable; move; "`...(,W,6,P1); variable'" ljust}
   move right_ hm+5bp__
   {inductor(,L,9,K); move ;"`...(,L,9,K) '" ljust}
}

   move down vm; right_
{ {I:inductor(,,,M3); addtaps(-,1/2,-dimen_/6); move; `"...(,,,M3)"' ljust
    {`"addtaps(-,1/2,-dimen_/6)"' ljust at (I.start,last ""+(0,-textht*3/2)) }
    }
   move right_ hm
  {ebox(,,,0) ; move ;"`ebox(,,,0) '" ljust}
   move right_ hm -10bp__
  {TI: tapped(`ebox(,,,0)',-,1/4,-dimen_/6,3/4,-dimen_/6) ; move ;
   "`tapped(`ebox(,,,0)','" ljust at Here+(10bp__,-5bp__) \
   "-,1/4,-dimen_/6," ljust "3/4,-dimen_/6)" ljust
   "svg_it(Tap1)" at TI.Tap1 rjust below
   "svg_it(Tap2)" at TI.Tap2 ljust below }
}

   move down vm*3/2; right_
{ {shielded(`inductor(,,,M)') ; move
   `"shielded(`inductor(,,,M)')"' ljust
   move to (3rd last line.start,Here)
   shielded(`ebox(,,,0)',R) ; move; `"shielded(`ebox(,,,0)',R)"' ljust }
}

 command "</g>" # end font
.PE
