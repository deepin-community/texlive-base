.PS
# Chips.m4
log_init
include(ics.m4)

  ifpostscript(,latexcommand({\sf))

Chips: [
  ic4017
  {"\sf 4017" at last [].Chip.sw below ljust}
  move
# ic4510
# {"\sf 4510" at last [].Chip.sw below ljust}
# move
  ic555
  {"\sf 555" at last [].Chip.sw below ljust}
  move
  icVS1053
  {"\sf VS1053" at last [].Chip.sw below ljust}

  DIP_chip_outline with .sw at last [].se+(0.5,0)
  { `"DIP\_chip\_outline"' at last [].s below }
  ]

DIPs: [
  DIP0: DIP
  DIP32: DIP(32,direct=R;bodywid=0.5*scale) with .sw at last [].se+(0.5,0)
  DIP16: DIP(16,type=Q;pinwid=1bp__) with .sw at DIP32.se+(1.5,0)

  thinlines_
  { `"\tt DIP"' at DIP0.s - (0,10bp__) }
  { arrow <- from DIP0.Pin1 up 0.2 ; `"\sl Pin1"' ljust at Here+(-0.05,0.1) }
  { arrow <- from DIP0.c up 0.7 right 0.25; `"\sl Body"' ljust }
  { arrow <- from DIP0.Pin8 up 0.25 right 0.2 ; `"\sl Pin8"' above ljust }

  { `"\tt DIP(32,direct=R;bodywid=0.5*scale)"' ljust \
      at DIP32.sw + (-10bp__,-10bp__) }
  { arrow <- right 0.2 from DIP32.Pin1; `"\sl Pin1"' ljust }
  { spline <- right 0.2 then right 0.1 up 0.1 from DIP32.Pin32
    `"\sl Pin32"' ljust }

  { `"\tt DIP(16,type=Q;pinwid=1bp\_\_)"' at DIP16.sw + (0,-10bp__) ljust }
  thicklines_

  ] with .nw at last [].sw+(0,-0.2)

  ifpostscript(,latexcommand(}%))

.PE
