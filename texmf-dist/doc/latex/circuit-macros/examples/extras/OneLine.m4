.PS
# OneLine.m4
# https://tex.stackexchange.com/questions/191598/electric-network-one-line-diagrams/325717#325717
cct_init
include(libSLD.m4)
First: [
  xgap = 0.6
  dim1 = 1; dim2 = 0.75 ; dim3=0.5
  X: box fill_(0.9) wid 1 "Xingu" "\SI{500}{\kV}"
  { "$R_0=\SI{1,682}{\ohm}$" at X.sw below ljust }
  sl_transformer(right_ dim2,type=S); rlabel(,\SI{18}{\percent},)
  {[Ysymbol;Ysymbol(at last []+(last [].wid,0))] with .s at last [].n+(0,2bp__)}
  { B1: line thick 3*linethick up 0.4 with .c at Here
    "$s$" wid 0.1 ht 0.1 above }
  { arrow right 0.2 from last line.c+(0.1,-0.1) }
  { "$I^s$" at last line.start below }
  line right 3.0 "$l=\SI{2600}{\km}$" wid 0.1 ht 0.1 above
  { B2: line thick 3*linethick up 0.4 with .c at Here; "$r$" above }
  sl_transformer(right_ dim2,type=S); rlabel(,\SI{18}{\percent},)
  {[Ysymbol;Ysymbol(at last []+(last [].wid,0))] with .s at last [].n+(0,2bp__)}
  NI: box fill_(0.9) wid 1 "Nova Igua\c{c}u" "\SI{500}{\kV}"
  "$Z_0=a+b$" at NI.sw below ljust
  RELE: box wid dimen_/2 ht dimen_/2 with .w at B1+(0.6,0.3)
  line left 0.15 from 1/4 between RELE.nw and RELE.sw; "$V^s$" rjust
  line left 0.15 from 3/4 between RELE.nw and RELE.sw; "$I^s$" rjust
  ]
Second: [
  lstem = dimen_*3/4
  asep = dimen_/3
  sl_grid(U,lgth=dimen_;wdth=dimen_)
  sl_transformer(down_ dimen_*7/4,type=S;name=Tr)
  llabel(,"$\SI{400}{kVA}$" ljust "$\SI{4}{\percent}$" ljust,,,Tr)
  Bus: sl_busbar(right_ dimen_*12, 5) with .P3 at Here
#
define(`loadstring',`[ L: line invis down_ dimen_*5
    line from L.start down_ L.len/4; dot
      { arrow <-> down_ last line.len at last line+(asep,0) "\sf $5 m" ljust }
      { sl_load(left_ lstem); "\sf $1" at Head.w rjust }
      { r_text(90,`\sf\scriptsize NAYY 4x150 mm$^2$', at Here+(-7bp__,0)) }
    line down_ L.len/4; dot
      { arrow <-> down_ last line.len at last line+(asep,0) "\sf $6 m" ljust }
      { sl_load(left_ lstem); "\sf $2" at Head.w rjust }
      { box wid dimen_/3 ht dimen_/3 at Here }
    line down_ L.len/8-3bp__
    { ACsymbol(at Here+(0,-3bp__),,,2:RA) }
    line down_ L.len/8+3bp__ from last line.end chop 6bp__ chop 0; dot
      ifelse(`$7',,,
       `{ arrow <-> up_ L.len/4 from Here+(asep,0) "\sf $7 m" ljust }')
      { sl_load(left_ lstem); "\sf $3" at Head.w rjust }
    line down_ L.len/4; dot
      { arrow <-> down_ last line.len at last line+(asep,0) "\sf $8 m" ljust }
      { sl_load(left_ lstem); Q:"\sf $4" at Head.w rjust }
      { box wid dimen_/3 ht dimen_/3 at Here } ]')
#
  loadstring(1,2,27,28, 21,21,,21) with .L.start at Bus.P1
  move left_ 13bp__ from last [].Q
  loadstring(1,2,15,16, 29,29,,29) with .L.start at Bus.P2
  loadstring(1,2, 8, 9, 40,40,,40) with .L.start at Bus.P3
  loadstring(1,2, 3, 4, 64,64,64,64) with .L.start at Bus.P4
  line down_ last [].L.len/2 from Bus.P5; dot
  { r_text(90,`\sf\scriptsize NAYY 4x150 mm$^2$', at last line.c+(-7bp__,0)) }
  { arrow <-> down_ last line.len at last line+(asep,0)
    "\sf 102 m" wid 30.4 bp__ ljust at last arrow }
  { sl_load(left_ lstem)}
  ] with .nw at First.sw+(0,-dimen_/2)
#showbox_
.PE
