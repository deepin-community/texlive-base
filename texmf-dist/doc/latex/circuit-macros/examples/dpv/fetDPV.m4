.PS
# `fetDPV.m4'
cct_init(svg_font(Times,11bp__))

textht = 0.1
define(`rmove',0.75)

dnl                               `IRF4905(linespec,R)'
define(`IRF4905',
 `[ ifelse(`$1',,,`eleminit_(`$1')')
   Q: mosfet(,`$2',dMdPzEDSQdB,) ifelse(`$1',,`
     S: Q.tr_xy(-4,-2); line from Q.tr_xy(-2,-2) to S
     D: Q.tr_xy( 4,-2); line from Q.tr_xy(2,-2) to D',
    `with .Diode.c at last line.c
     S: last line.start; D: last line.end; line from S to D ')
   G: Q.G
   circle rad 5*dimen_/10 at Q.tr_xy(0,1) ]')

{move left 20bp__}
Row1: [ J: j_fet
  { "svg_tt(`j_fet')" at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: j_fet(right_ dimen_,,P,E) with .w at J.e+(0.5,0)
  { "svg_tt(`j_fet(right_')" at J.s+(0,-4bp__) below "svg_tt(`dimen_,,P,E)')"
    "svg_it(G)" at J.G rjust above
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: e_fet with .w at J.e+(0.5,0)
  {  "svg_tt(` e_fet')" at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: e_fet(,,P) with .w at J.e+(0.6,0)
  {  "svg_tt(` e_fet(,,P)')" at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: e_fet(,,P,S) with .w at J.e+(0.8,0)
  {  "svg_tt(` e_fet(,,P,S)')" at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: c_fet with .w at J.e+(0.7,0)
  {  "svg_tt(` c_fet')" at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: c_fet(,,P) with .w at J.e+(0.7,0)
  {  "svg_tt(` c_fet(,,P)')" wid 72bp__ at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
  ]

Row2: [
   J: d_fet
  { "svg_tt(`d_fet')" at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: d_fet(,,P) with .w at J.e+(0.5,0)
  { "svg_tt(`d_fet(,,P)')" at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: d_fet(,,P,S) with .w at J.e+(0.8,0)
  { "svg_tt(`d_fet(,,P,S)')" at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: g_fet with .w at J.e+(0.6,0)
  { "svg_tt(`g_fet')" at J.s+(0,-0.05) below
    "svg_it(G)" at J.G rjust
    "svg_it(S)" at J.S rjust
    "svg_it(D)" at J.D ljust }
   J: g_fet(up_ dimen_,,P) with .w at J.e+(0.6,0)
  { "svg_tt(`g_fet(up_')" at last [].s below
    "svg_tt(` dimen_,,P)')" at last [].s + (0,-12bp__) below
    "svg_it(G)" at last [].G rjust
    "svg_it(S)" at last [].S + (0,2bp__) ljust
    "svg_it(D)" at last [].D + (0,2bp__) ljust below }
  right_
  M1: mosfet(,,dBSDFQM1,E) with .w at J.e+(0.6,0) 
  "svg_it(G0)" at M1.G0 above rjust
  "svg_it(G1)" at M1.G1 above ljust
  {"svg_tt(`mosfet(,,dBSDFQM1,E)')" wid 1.45 \
     with .nw at last [].sw+(0,-0.2) }
  M2: mosfet(,,dBSDFQuM1) with .nw at M1.ne+(0.6,0)
  "svg_it(G0)" at M2.G0 above ljust
  "svg_it(G1)" at M2.G1 above rjust
  {"svg_tt(`...(,,dBSDFQuM1')" wid 1.25 \
     with .n at last [].s+(0,-0.05) }
  ] with .nw at Row1.sw+(0,-10bp__) # Row2

Row3: [
  linewid = linewid*1.2

  Q1: mosfet(,,dGSDF,)
  {"svg_tt(`mosfet(,,dGSDF,)')" wid 1.25 \
     with .nw at last [].sw+(-0.2,-0.05)
    thinlines_
    arrow <- down .05 left .15 from (Q1.G.x,Q1.G.y-0.05)
    "svg_tt(dG)" rjust
    arrow <- down .10 left .30 from Q1.Channel.start+(.15,0)
    "svg_tt(F)" rjust
    arrow <- down .05 left .15 from (Q1.S.x,Q1.S.y+0.05)
    "svg_tt(S)" rjust
    arrow <- down .05 right .15 from (Q1.D.x,Q1.D.y+0.05)
    "svg_tt(D)" ljust
    thicklines_ }

  move right_ rmove
  Q2: mosfet(,,uHSDF,)
  {"svg_tt(`...(,,uHSDF,)')" at last [].s+(0,-0.2) below
    thinlines_
    arrow <- down .05 left .15 from (Q2.G.x,Q2.G.y-0.05)
    "svg_tt(uH)" rjust
    thicklines_ }

  move right_ rmove
  Q3: mosfet(,,dMEDSQuB,)
  {"svg_tt(`...(,,dMEDSQuB,)')" at last [].s+(0,-0.05) below
    thinlines_
    arrow <- down .05 left .15 from (Q3.G.x,Q3.G.y-0.05)
    "svg_tt(dM)" rjust
    arrow <- down .13 left .30 from Q3.Channel.start+(.12,0)
    "svg_tt(E)" rjust
    arrow <- down .05 left .10 from Q3.S+(.06,0)
    "svg_tt(Q)" rjust
    arrow <- down .08 right .24 from (Q3.B.x,Q3.B.y+0.175)
    "svg_tt(uB)" ljust
    thicklines_ }

  move right_ rmove
  Q4:  mosfet(,,uMEDSuB)
  {"svg_tt(`...(,,uMEDSuB,)')" at last [].s+(0,-0.2) below
    "svg_it(G)" at last [].G rjust
    "svg_it(S)" at last [].S rjust
    "svg_it(D)" at last [].D ljust
    "svg_it(B)" at last [].B below
    }

  move right_ rmove
  Q5: mosfet(,,ZSDFdT,)
  {"svg_tt(`...(,,ZSDFdT)')" at last [].s+(0,-0.05) below
    thinlines_
    arrow <- down .08 left .08 from (Q5.S.x,Q5.S.y+0.12)
    "svg_tt(Z)" rjust
    arrow from last arrow.end to Q5.Channel.c+(0.05,0)
    arrow from last arrow.start to (Q5.D.x,Q5.D.y+.05)
    arrow <- down .08 right .24 from (Q5.G.x,Q5.G.y-0.02)
    "svg_tt(dT)" ljust
    thicklines_ }

  move right_ rmove+0.1
  up_
  Q6: IRF4905 with .c at Here
  {"svg_tt(`IRF4905')" at Q6.s+(0,-0.15) below
    "svg_it(G)" at Q6.G rjust
    "svg_it(D)" at Q6.D ljust above
    "svg_it(S)" at Q6.S ljust below
    }
  ] with .nw at Row2.sw + (0,-10bp__)

 command "</g>" # end font
.PE
