.PS
# `fet.m4'
cct_init

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

Row1: [ J: j_fet
  { "{\tt j\_fet}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: j_fet(right_ dimen_,,P,E) with .w at J.e+(0.5,0)
  { "{\tt j\_fet(right\_}" "{\tt dimen\_,{,}P,E)}" at J.s+(0,-13bp__) below
    "$G$" at J.G rjust above
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: e_fet with .w at J.e+(0.5,0)
  {  "{\tt $\;$ e\_fet}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: e_fet(,,P) with .w at J.e+(0.6,0)
  {  "{\tt $\;$ e\_fet(,{,}P)}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: e_fet(,,P,S) with .w at J.e+(0.7,0)
  {  "{\tt $\;$ e\_fet(,{,}P,S)}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: c_fet with .w at J.e+(0.6,0)
  {  "{\tt $\;$ c\_fet}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: c_fet(,,P) with .w at J.e+(0.6,0)
  {  "{\tt $\;$ c\_fet(,{,}P)}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  ]

Row2: [
   J: d_fet
  { "{\tt d\_fet}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: d_fet(,,P) with .w at J.e+(0.5,0)
  { "{\tt d\_fet(,{,}P)}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: d_fet(,,P,S) with .w at J.e+(0.7,0)
  { "{\tt d\_fet(,{,}P,S)}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: g_fet with .w at J.e+(0.6,0)
  { "{\tt g\_fet}" at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
   J: g_fet(up_ dimen_,,P) with .w at J.e+(0.6,0)
  { "{\tt `g\_fet'(up\_$\;\;$}" at last [].s below
    "{\tt  dimen\_,{,}P)}" at last [].s + (0,-12bp__) below
    "{\sl G}" at last [].G rjust
    "{\sl S}" at last [].S + (0,2bp__) ljust
    "{\sl D}" at last [].D + (0,2bp__) ljust below }
  right_
  M1: mosfet(,,dBSDFQM1,E) with .w at J.e+(0.5,0) 
  "$G0$" at M1.G0 above rjust
  "$G1$" at M1.G1 above ljust
  {"\tt `mosfet'(,{,}dBSDFQM1,E)" wid 1.45 \
     with .nw at last [].sw+(0,-0.2) }
  M2: mosfet(,,dBSDFQuM1) with .nw at M1.ne+(0.5,0)
  "$G0$" at M2.G0 above ljust
  "$G1$" at M2.G1 above rjust
  {"\tt ...(,{,}dBSDFQuM1)" wid 1.25 \
     with .n at last [].s+(0,-0.05) }
  ] with .nw at Row1.sw+(0,-0.1)

Row3: [
  linewid = linewid*1.2

  Q1: mosfet(,,dGSDF,)
  {"\tt `mosfet'(,{,}dGSDF,)" wid 1.25 \
     with .nw at last [].sw+(-0.2,-0.05)
    thinlines_
    arrow <- down .05 left .15 from (Q1.G.x,Q1.G.y-0.05)
    "\tt dG" rjust
    arrow <- down .10 left .30 from Q1.Channel.start+(.15,0)
    "\tt F" rjust
    arrow <- down .05 left .15 from (Q1.S.x,Q1.S.y+0.05)
    "\tt S" rjust
    arrow <- down .05 right .15 from (Q1.D.x,Q1.D.y+0.05)
    "\tt D" ljust
    thicklines_ }

  move right_ rmove
  Q2: mosfet(,,uHSDF,)
  {"\tt `$\ldots$'(,{,}uHSDF,)" at last [].s+(0,-0.15) below
    thinlines_
    arrow <- down .05 left .15 from (Q2.G.x,Q2.G.y-0.05)
    "\tt uH" rjust
    thicklines_ }

  move right_ rmove
  Q3: mosfet(,,dMEDSQuB,)
  {"\tt `$\ldots$'(,{,}dMEDSQuB,)" at last [].s+(0,-0.05) below
    thinlines_
    arrow <- down .05 left .15 from (Q3.G.x,Q3.G.y-0.05)
    "\tt dM" rjust
    arrow <- down .13 left .30 from Q3.Channel.start+(.12,0)
    "\tt E" rjust
    arrow <- down .05 left .10 from Q3.S+(.06,0)
    "\tt Q" rjust
    arrow <- down .08 right .24 from (Q3.B.x,Q3.B.y+0.175)
    "\tt uB" ljust
    thicklines_ }

  move right_ rmove
  Q4:  mosfet(,,uMEDSuB)
  {`"{\tt $\ldots$(,{,}uMEDSuB)}"' at last [].s+(0,-0.15) below
    "$G$" at last [].G rjust
    "$S$" at last [].S rjust
    "$D$" at last [].D ljust
    "$B$" at last [].B below
    }
  move right_
  J: Fe_fet #(right_ dimen_)
  {`"{\tt $\;$ Fe\_fet}"' at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  move right_
  J: Fe_fet(,,TEDQSuB)
  {`"{\tt $\;$ Fe\_fet(,,TEDSQuB)}"' at J.s+(0,-0.15) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust
    thinlines_
    arrow <- down .05 left .18 from (J.G.x,J.G.y-0.1)
    "\tt T" rjust
    thicklines_ }
  ] with .nw at last [].sw

Row4: [
  {move left 0.5}
  Q5: mosfet(,,ZSDFdT,)
  {"\tt `$\ldots$'(,{,}ZSDFdT,)" at last [].s+(0,-0.05) below
    thinlines_
    arrow <- down .08 left .08 from (Q5.S.x,Q5.S.y+0.12)
    "\tt Z" rjust
    arrow from last arrow.end to Q5.Channel.c+(0.05,0)
    arrow from last arrow.start to (Q5.D.x,Q5.D.y+.05)
    arrow <- down .08 right .24 from (Q5.G.x,Q5.G.y-0.02)
    "\tt dT" ljust
    thicklines_ }
  move right_ 0.8
  up_
  Q6: IRF4905 with .c at Here
  {`"\tt IRF4905"' at Q6.s+(0,-0.15) below
    "$G$" at Q6.G rjust
    "$D$" at Q6.D ljust above
    "$S$" at Q6.S ljust below
    }
  ] with .nw at last [].sw

.PE
