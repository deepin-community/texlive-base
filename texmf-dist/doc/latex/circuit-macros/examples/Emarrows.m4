.PS
# `Emarrows.m4'
cct_init

  hskip = 0.6
  { A: em_arrows()
    box dotted wid A.wid ht A.ht at A.c
    thinlines_
    arrow <- left 0.15 from A.Head; "\sl Head" wid 0.31 rjust
    arrow <- right 0.12 from A.Tail; "\sl Tail" ljust
    arrow <- left 0.15 from 0.6 between A.A1.end and A.A1.start; "\sl A1" rjust
    arrow <- right 0.15 up 0.07 from A.A2; "\sl A2" ljust
    thicklines_
    move down 0.25 from A.s
    move up 0.2 from A.n
    "\tt em\_arrows()" at A.s+(0,-4bp__) below }
  { em_arrows(ND,45) with .sw at last [].se+(hskip*1.5,0)
    "\tt $\ldots$(ND,45)" at last [].s below }
  { em_arrows(I) with .sw at last [].se+(hskip,0)
    "\tt $\ldots$(I)" at last [].s below }
  { em_arrows(ID) with .sw at last [].se+(hskip,0)
   "\tt $\ldots$(ID)" at last [].s below }
  { em_arrows(E) with .sw at last [].se+(hskip,0)
    "\tt $\ldots$(E)" at last [].s below }
  { A: em_arrows(NT) with .sw at last [].se+(hskip,0)
   "\tt $\ldots$(NT)" at last [].s below }

.PE
