.PS
# ChipsDPV.m4
log_init
include(icsDPV.m4)
svg_font(sans-serif,8.5bp__)

Chips: [
  ic4017
  {"4017" at last [].Chip.sw below ljust}
  move
  ic4510
  {"4510" at last [].Chip.sw below ljust}
  move
  icVS1053
  {"VS1053" at last [].Chip.sw below ljust}

  DIP_chip_outline with .sw at last [].se+(0.5,0)
  { `"DIP_chip_outline"' at last [].s below }
  ]

DIPs: [
  DIP0: DIP
  DIP32: DIP(32,direct=R;bodywid=0.5*scale) with .sw at last [].se+(0.5,0)
  DIP16: DIP(16,type=Q;pinwid=1bp__) with .sw at DIP32.se+(1.5,0)

  thinlines_
  { "svg_tt(`DIP')" at DIP0.s - (0,10bp__) }
  { arrow <- from DIP0.Pin1 up 0.2; "svg_it(`Pin1')" ljust at Here+(-0.05,0.1) }
  { arrow <- from DIP0.c up 0.7 right 0.25; "svg_it(`Body')" ljust }
  { arrow <- from DIP0.Pin8 up 0.25 right 0.2 ; "svg_it(`Pin8')" above ljust }

  { "svg_tt(`DIP(32,direct=R;bodywid=0.5*scale)')" ljust \
      at DIP32.sw - (20bp__,10bp__) }
  { arrow <- right 0.2 from DIP32.Pin1; "svg_it(`Pin1')" ljust }
  { spline <- right 0.2 then right 0.1 up 0.1 from DIP32.Pin32
    "svg_it(`Pin32')" ljust }

  { "svg_tt(`DIP(16,type=Q;pinwid=1bp__)')" at DIP16.sw - (0,10bp__) ljust }
  thicklines_

  ] with .nw at last [].sw+(0,-0.3)

  command "</g>"
.PE
