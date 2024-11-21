.PS
# Sevensegment.m4
# https://tex.stackexchange.com/questions/644009/seven-segments-anchors-how-to-use-them
gen_init
divert(-1)
                           `sevensegment(keys)
                            Seven-segment display in a [] block. keys:
                            hght=expr; (default boxht)
                            wdth=expr; (default hght*3.3/5.85) 
                            slant=fraction; top is skewed slant fraction of ht
                            segwid=expr; segment width
                            gap=expr; gap between segments
                            bevel=fraction; corner truncation 
                            on=attributes; "on" segment attributes
                            off=attributes; "off" segment attributes
                            code=[0-8][.]; displayed number .=decimal point
                               or
                            code=Xddddddd[.] where each d=0 or 1 to define
                               Segment1 to Segment7 off or on 
                            Segments are labeled Seg1 Seg2 ... Seg7
                            and the decimal point is Seg8'
define(`sevensegment', # hght, wdth, slant, segwid, gap, bevel, on, off, code
 `[ pushkeys_(`$1',`hght:boxht; wdth:m4`'hght*3.3/5.85; slant:0;
      segwid:0.75/3.2*m4`'wdth; gap:0.12/3.2*m4`'wdth; bevel:0.4;
      on:outlined "red" shaded "red":N; off:outlined "lightgray":N;
      code:00000010:N;')
  gapch = m4gap/2*sqrt(2)
  ifinstr(m4code,.,`define(`m4tmp',substr(m4code,0,decr(len(m4code))))dnl
    pushdef(`dodp',1)poppushdef(`m4code',m4tmp)')dnl
  ifinstr(m4code,X,`pushdef(`opcode',substr(m4code,1))',
   `foreach_(`m4cd',`pushdef(`Cd'decr(m4Lx),m4cd)',1111110,0110000,1101101,
      1111001,0110011,1011011,1011111,1110000,1111111,1111011)dnl
    pushdef(`opcode',Cd`'m4code)')dnl
  for_(1,7,1,`pushdef(`attrib'm4x,
   ifelse(substr(opcode,decr(m4x),1),1,`m4on',`m4off'))')dnl
  Seg1: m4segment(R,m4bevel,m4bevel,attrib1) \
    with .S at m4slu(0,m4hght-m4segwid)
  inner = distance(Seg1.SW,Seg1.SE) + gapch*2
  Seg2: m4segment(D,0.5,m4bevel,attrib2) with .S at \
    m4slu(m4wdth/2-m4segwid,m4hght-m4segwid-inner/2)
  Seg3: m4segment(D,m4bevel,0.5,attrib3) with .S at \
    m4slu(m4wdth/2-m4segwid,m4segwid+inner/2)
  Seg4: m4segment(L,m4bevel,m4bevel,attrib4) with .S at m4slu(0,m4segwid)
  Seg5: m4segment(U,0.5,m4bevel,attrib5) with .S at \
    m4slu(-m4wdth/2+m4segwid,m4segwid+inner/2)
  Seg6: m4segment(U,m4bevel,0.5,attrib6) with .S at \
    m4slu(-m4wdth/2+m4segwid,m4hght-m4segwid-inner/2)
  Seg7: m4segment(R,0.5,0.5,attrib7) with .c at m4slu(0,m4hght/2)
  ifelse(dodp,1,`Seg8: circle diam m4segwid m4on \
      at m4slu(Seg3.e.x+m4segwid/2+m4gap,Seg4.s.y+m4segwid/2)') popdef(`dodp')
  popdef(`m4hght',`m4wdth',`m4slant',`m4segwid',`m4gap',`m4bevel',
   `m4on',`m4off',`m4code',`opcode')dnl
  for_(1,7,1,`popdef(`attrib'm4x)') for_(0,9,1,`popdef(`Cd'm4x)')dnl
  ]')
define(`m4segment',`[ setdir_(`$1')
  m4seven_pos(SE,E,NE,,`$2'); m4seven_pos(SW,W,NW,-,`$3')
  resetdir_
  S: 1/2 between SW and SE
  Line: line from m4slu(S.x,S.y) to m4slu(SE.x,SE.y) then to m4slu(E.x,E.y) \
    then to m4slu(NE.x,NE.y) then to m4slu(NW.x,NW.y) then to m4slu(W.x,W.y) \
    then to m4slu(SW.x,SW.y) then to m4slu(S.x,S.y) `$4' ] ')
define(`m4seven_pos',
 `AA: (`$4'(m4wdth/2-m4segwid-gapch),0); `$1': rot_(AA.x,AA.y,rp_ang)
  BA: AA + (`$4'1,1)*m4segwid*(1-`$5');  `$2': rot_(BA.x,BA.y,rp_ang)
  CA: BA - (`$4'1,-1)*m4segwid*`$5';     `$3': rot_(CA.x,CA.y,rp_ang) ')
define(`m4slu',`(`$1'+(`$2')*m4slant,`$2')')

divert(0)dnl
 

[
  S: sevensegment(code=4.;hght=1)
  { for_(1,8,1,`"m4x" at S.Seg`'m4x') }
  move right 0.25
  P: sevensegment(code=X1100011;off=invis;hght=1)
  ]
[
  for_(0,9,1,`sevensegment(code=m4x`'ifelse(m4x,1,.);slant=1/4;off=invis)
   move movewid/4')
  ] with .nw at last [].sw+(0,-boxht/3)

.PE
