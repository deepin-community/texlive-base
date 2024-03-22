.PS
# `ConnDPV.m4'
cct_init(svg_font(sans-serif,10.5bp__))

T:[
 ifelse(ifmpost(T)`'ifpostscript(T),,`command "{\sf"')
 S1: tstrip(U)
  thinlines_
  arrow <- left 0.15 from S1.L1; "L1" rjust
  arrow <- left 0.15 from S1.L4; "L4" wid 0.2 rjust
  ":" at (0.5 between last "" and 2nd last "")+(0,0.02)
  arrow <- right 0.25 from S1.R1; "R1" ljust
  arrow <- right 0.25 from S1.R4; "R4" ljust
  ":" at (0.5 between last "" and 2nd last "")+(0.05,0.02)
  arrow <- right 0.15 up 0.10 from S1.T1; "T1" ljust
  arrow <- right 0.15 up 0.10 from S1.T4; "T4" ljust
  ":" at (0.5 between last "" and 2nd last "")+(0.15,0.02)
  thicklines_
  CS1: "`tstrip(U)'" at S1.s+(0,-0.15)
 S2: tstrip(R,5,DO;wid=1.0;ht=0.25) with .sw at S1.se+(0.8,0.15)
  thinlines_
  arrow <- up 0.2 right 0.1 from S2.T1; "T1" above 
  arrow <- up 0.2 right 0.1 from S2.T5; "T5" above 
  "..." at 0.5 between last "" and 2nd last "" above
 CS2: `"tstrip(R,5,"' ht 0.1 ljust \
      `"DO;wid=1.0;ht=0.25)"' ljust at S2.sw+(-0.1,-0.2)
  ifelse(ifmpost(T)`'ifpostscript(T),,`command "}"')
]

C: [
  C1: ccoax
    `"ccoax"' at C1.s below
    thinlines_
    arrow <- down 0.05 left 0.15 from C1.C.w; "svg_it(C)" rjust
    arrow <- down 0.05 right 0.1 from C1.S.e; "svg_it(S)" ljust
    thicklines_
  C2: ccoax(at C1+(0,0.4),F)
    `"ccoax(,F)"' at C2.s below
  ] with .w at T.e+(0.6,0.0)

B: [
  tbox(V_2)
  { "`tbox'(V`'svg_sub(2))" at last [].s below }
  tbox(V_1,,,<) at last []+(0,-0.4)
  { "`tbox'(V`'svg_sub(1),,,svg_lt)" at last [].s below }
  tbox(V_1,,,<>) at last []+(0,-0.4)
  { "`tbox'(V`'svg_sub(1),,,svg_lt`'svg_gt)" at last [].s below }
] with .w at C.e + (0.5,-0.1)

Y: [
  P1: tconn(,O)
  {"`tconn'(,O)" at last line.c+(0,-0.2) wid 43 pt__ }
  move to Here+(0.3,0)
  P2: tconn(,>)
  {"...(,svg_gt)" at last line.c+(0,-0.2)}
  move to P2.end+(0.3,0)
  P3: tconn(,>>)
  {"...(,svg_gt`'svg_gt)" at last line.c+(0,-0.2)}
  move to P3.end+(0.3,0)
  P4: tconn(,<)
  {"...(,svg_lt)" at last line.c+(0,-0.2)}
  move to P4.end+(0.3,0)
  P5: tconn(,<<)
  {"...(,svg_lt`'svg_lt)" at last line.c+(0,-0.2)}
  move to P5.end+(0.3,0)
  P6: tconn(,A)
  {`"...(,A)"' at last line.c+(0,-0.2)}
  move to P6.end+(0.3,0)
  P7: tconn(,M)
  {`"...(,M)"' at last line.c+(0,-0.2)}

] with .nw at T.sw+(0,-0.35)

 command "</g>" # end font
.PE
