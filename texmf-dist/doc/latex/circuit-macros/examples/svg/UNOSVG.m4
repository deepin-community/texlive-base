.PS
# UNOSVG.m4
log_init
include(../icsSVG.m4)
textoffset = 1.5bp__
svg_font(sans-serif,8.5bp__,textoffset)

divert(-1)

                          `Header([A][1|2], rows, wid, ht, 
                           boxspec, pinlen;pinsize)
                            arg1: A= type A; number of columns
                            arg2: pins per column
                            arg3,4: custom wid, ht
                            arg5: eg fill_(0.9)'
define(`Header',
`[ define(`m4tp',ifinstr(`$1',A,A))define(`m4Hq',patsubst(`$1',A))dnl
  define(`m4Hn',`ifelse(m4Hq,,1,m4Hq)')dnl
  define(`m4Hm',`ifelse(`$2',,2,`$2')')dnl
  define(`m4Hw',`ifelse(`$3',,`m4Hn*L_unit*3',`($3)')')dnl
  define(`m4Hh',`ifelse(`$4',,`m4Hm*L_unit*3',`($4)')')dnl
  ifinstr(`$6',;,
  `stacksplit_(`m4Jdr',`$6',;)dnl
   define(`m4Jps',ifelse(m4Jdr,,`L_unit',m4Jdr))popdef(`m4Jdr')dnl
   define(`m4Jpl',ifelse(m4Jdr,,`lg_plen*L_unit',m4Jdr))popdef(`m4Jdr') ',
  `define(`m4Jps',L_unit)dnl
   define(`m4Jpl',`ifelse(`$6',,lg_plen*L_unit,`$6')')')dnl
  Block: rotbox(m4Hw,m4Hh,`$5')
  ifelse(`m4tp',A,`pushdef(`L_unit',(linewid/6))')
  define(`m4Hct',1)dnl
  for_(1,m4Hm,1,
   `HeaderPin(Block.NW+vec_(m4Jps*3/2,-(m4x-1/2)*m4Hh/m4Hm),
     ifinstr(m4tp,A,1,eval(m4Hct-1)),
     P`'m4Hct, w, (m4Jpl+m4Jps);m4Jps)  define(`m4Hct',incr(m4Hct))
    ifelse(m4Hn, 2, `HeaderPin(Block.NE+vec_(-m4Jps*3/2,-(m4x-1/2)*m4Hh/m4Hm),
       1, P`'m4Hct, e, (m4Jpl+m4Jps);m4Hps) define(`m4Hct',incr(m4Hct))') ')
  ifelse(`m4Hq',A,`popdef(`L_unit')')
  `$7' ]')
                          `HeaderPin(location, type, Picname, n|e|s|w,
                            [length][;pinsize])
                           arg2: 0= square' 
define(`HeaderPin',`
  ifinstr(`$5',;,
  `stacksplit_(`m4Hdr',`$5',;)dnl
   define(`m4Hps',ifelse(m4Hdr,,`L_unit',m4Hdr))popdef(`m4Hdr')dnl
   define(`m4Hpl',ifelse(m4Hdr,,`lg_plen*L_unit',m4Hdr))popdef(`m4Hdr') ',
  `define(`m4Hps',L_unit)dnl
   define(`m4Hpl',`ifelse(`$5',,lg_plen*L_unit,`$5')')')dnl
  ifelse(`$1',,,`move to `$1';')
  ifelse(`$3',,,`$3':) line to ifelse(
   `$4',n,`rvec_(0,m4Hpl)', `$4',e,`rvec_(m4Hpl,0)',
   `$4',s,`rvec_(0,-m4Hpl)', `rvec_(-m4Hpl,0)')
  ifelse(`$3',,,Pin`$3':) ifelse(ifelse(`$2',,0,`$2'),0,
   `rotbox(m4Hps,m4Hps,fill_(1))',
   `circle diam m4Hps fill_(1)') at last line.start ')

define(`brdge',`eleminit_(`$1')
 define(`m4h',ifelse(`$2',,`sourcerad_',`($2)/2'))dnl
 { line to rvec_(rp_len/2-m4h/2,0)
   move to rvec_(m4h/2,0)
   for m4ng=75 to 255 by 180 do {{
     m4fshade(0, arc cw from rvec_(Rect_(m4h/2,m4ng)) \
       to rvec_(Rect_(m4h/2,-m4ng)) \
         with .c at Here ) }}
   line from rvec_(m4h/2,0) to rvec_(rp_len/2,0) }
 { [box invis ht_ m4h wid_ m4h] at rvec_(rp_len/2,0) }
 line to rvec_(rp_len,0) invis ')

define(`ATMEGA16U2',`[
  Chip: box wid 10*lg_pinsep ht 25*lg_pinsep
  Loopover_(`x',
   `Arightpin(patsubst(x,;,`,'))',
   6;PD0, 7;PD1, 8;PD2, 9;PD3, 10;PD4, 11;PD5, 12;PD6, 13;PD7,
   131;nul,
   5;PC2, 26;PC4, 25;PC5, 23;PC6, 22;PC7,
   132;nul,
   133;nul,
   14;PB0, 15;PB1, 16;PB2, 17;PB3, 18;PB4, 19;PB5, 20;PB6, 21;PB7)
  Loopover_(`x',
   `Aleftpin(patsubst(x,;,`,'))',
   33;PAD,
   100;nul,
   28;UGND, 29;D`'svg_it(+), 30;D`'svg_it(-), 31;UVCC, 27;UCAP,
   101;nul, 102;nul,
   3;GND, 4;VCC, 103;nul,
   104;nul,
   32;AVCC,
   105;nul, 106;nul,
   1;XTAL1,
   107;nul,
   2;XTAL2(PC0),
   108;nul, 109;nul)
   lg_pin(Pin109+(0,lg_pinsep),RESET,Pin24,wN,24,pinlen)
  ]')
define(`Aleftpin',`move to Chip.sw+(0,m4Lx*lg_pinsep)
 Pin`$1': ifelse(`$2',nul,Here,dnl
 `line left pinlen "`$1'" above
  "`$2'" ljust at last line.start')') 
define(`Arightpin',`move to Chip.se+(0,m4Lx*lg_pinsep)
 Pin`$1': ifelse(`$2',nul,Here,dnl
 `line right pinlen "`$1'" above
  "`$2'" rjust at last line.start')') 

define(`ATMEGA328P',`[
  Chip: box wid 10*lg_pinsep ht 23*lg_pinsep
  Loopover_(`x',
   `Arightpin(patsubst(x,;,`,'))',
   2;PD0, 3;PD1, 4;PD2, 5;PD3, 6;PD4, 11;PD5, 12;PD6, 13;PD7,
   100;nul,
   23;PC0, 24;PC1, 25;PC2, 26;PC3, 27;PC4, 28;PC5,
   101;nul,
   14;PB0, 15;PB1, 16;PB2, 17;PB3, 18;PB4, 19;PB5)
  Loopover_(`x',
   `Aleftpin(patsubst(x,;,`,'))',
   201;nul, 202;nul, 203;nul, 204;nul, 205;nul, 206;nul, 207;nul, 208;nul,
   209;nul,
   8;GND, 7;VCC,
   301;nul,
   22;AGND, 20;AVCC, 21;AREF,
   302;nul,
   9;XTAL1,
   303;nul,
   10;XTAL2,
   304;nul, 305;nul)
   lg_pin(Pin305+(0,lg_pinsep),RESET,Pin1,wN,1,pinlen)
  ]')

define(`rswitch',`dswitch(`$1',,WBoDCP)
  DS: last line.start; DC: last line.c; DE: last line.end
  DL: DC-vec_(dimen_/6,0); DR: DC+vec_(dimen_/6,0)
  {{"1" at DL above rjust}; {"3" at DR above ljust}
  { line from DL to DL-vec_(0,dimen_/6) chop dotrad_ chop 0
    {"2" below rjust}
    continue to DS-vec_(0,dimen_/6) then to DS; dot }
  { line from DR to DR+vec_(0,-dimen_/6) chop dotrad_ chop 0
    {"4" below ljust}
    continue to DE+vec_(0,-dimen_/6) then to DE; dot }
  line from DC+vec_(dimen_/10,-dimen_/6) to DC+vec_(-dimen_/10,-dimen_/6)
  move to last line.c; line to rvec_(0,-dimen_/3) \
    then to rvec_(-dimen_/3,-dimen_/3)
    {"5" below}} ')

divert(0)dnl

 maxpswid = 20
 maxpsht = 20

 define(`pinlen',`30bp__')
 define(`lg_pinsep',(1.2*lg_pinsep))
 del = lg_pinsep
 define(`pindiam',0.1)

 define(`egnd',`ground(,,E); "GND" at last line.c below')

 U3: ATMEGA16U2
  `"ATMEGA16U2-MU(R)"' at U3.Chip.s below
  `"U3"' at U3.Chip.nw ljust above
 ZU4: ATMEGA328P with .Chip.nw at U3.Chip.sw+(-2.5,-10*del)
  `"ATMEGA328P-PU"' at ZU4.Chip.s below
  `"ZU4"' at ZU4.Chip.nw ljust above

  dot(at U3.Pin2.end)
 R1: resistor(down_ 2*lg_pinsep,,E)
  rlabel(,"R1" rjust "1M" rjust)
  dot
  dot(at R1.start-(2*del,0))
  xtal(down_ 2*lg_pinsep)
  rlabel(16,,MHz); dot
 XT2: dot(at last line.start-(2*del,0)); { "XT2" at last [].n above }

 Br1: brdge(left_ from U3.Pin33.end to (XT2,U3.Pin33))
  rlabel(1,,2); llabel(,GROUND)
 BRE: dot
  line to (Here,U3.Pin28) then to U3.Pin28.end
  {"UGND" at (Br1,Here) above}

 XT1: dot(at XT2-(del,R1.len)); { "XT1" at last [].n above }
  line from XT1 to U3.Pin1.end
  line from U3.Pin2.end to (XT1,XT2)
 C11: capacitor(left_ 3*del); rlabel(,C11); llabel(,22`'pF)
 C9: capacitor(from XT1 to (Here,XT1)); {"C9" "22`'pF" at last [].s+(0,-11bp__)}
  { line to C11.end }
  dot
 G1: egnd
  line from XT1 down_ 3*del; continue to (G1,Here); dot(,,1)
  {"XT3" at last [].n above}
  dot(at Here+(0,-3/2*del),,1); {"XT4" at last [].n above}
  { line to (XT2,Here) then to XT2 chop dotrad_ chop 0 }
  USBVCC: dot(at Here+(0,-7/2*del),,1)
  {"USBVCC" at last [].n-(3/2*del,0) above ljust}
  { line to (Here,U3.Pin31) chop dotrad_ chop 0; continue to U3.Pin31.end }
  dot(at Here+(2*del,0),,1); {"VUCAP" at last [].e+(0,-5bp__) ljust}
  line to (Here,U3.Pin27) chop dotrad_ chop 0; dot
  line from U3.Pin27.end to (G1.x-4.5*del,U3.Pin27.y)
 C8: capacitor(down_ to (Here,Br1)); llabel(C8,,1`'svg_micro) 
 Bus1: dot

  dot(at U3.Pin33.end)
  move to U3.Pin3.end; line to (Here,U3.Chip.s)
 G2: ground(,T,E); {"GND" at last line.c below }

 dot(at U3.Pin32.end)
 {line to U3.Pin4.end; dot}
 line left del; ground(,,E,U); {"svg_it(+)5 V" at last line.c above}

  line from U3.Pin4.end left_ 2*del
  capacitor(down_ 3*del); { llabel(C7,,100n) }
 G3: ground(,T,E);  {"GND" at last line.c below }

  line from U3.Pin30.end to (G1.x-2*del,U3.Pin30.y); TD: Here
  continue to (Here,U3.Pin32)
  { "RD`'svg_it(-)" above rjust }; continue left_ 1.5*del
 RN3A: resistor(left_ 3/2*dimen_,,E); rlabel(,22R RN3A)
 Dm: line left_ 7*del

USB: [ K: box invis wid dimen_/2 ht 5*lg_pinsep
  "USB" rjust at K.e
  line thick 1.5 from K.nw to K.ne then to K.se then to K.sw
  Loopover_(`x',
   `Pin`'m4Lx: K.ne-(0,m4Lx/5*K.ht)
    "x" at Pin`'m4Lx ljust above',
   1 XUSB, 2 D`'svg_it(-), 3 D`'svg_it(+), 4 UGND)
  P_1: K.sw; {"P$`1'" at P_1 below rjust}
  P_2: K.s; {"P$`2'" at P_2 below ljust}
  ] with .Pin2 at Here; "X2" at USB.ne above rjust

  move to U3.Pin29.end
  line to (TD.x-del,Here.y); continue to (Here,Dm-(0,lg_pinsep))
  { "RD`'svg_it(+)" above rjust}
  continue to (RN3A.start,Here)
 RN3D: resistor(left_ 3/2*dimen_,,E); llabel(,22R RN3D)
  line to USB.Pin3

   dot(at RN3A.end); line to (Here,RN3D)
 Z2: variable(`resistor(down_ to (Here,U3.Pin27),,E); rlabel(Z2)',NN)
   dot(at RN3D.end-(2*del,0))
 Z1: variable(`resistor(to (Here,U3.Pin27),,E); rlabel(Z1)',NN)
   dot; line to (Z2,Here)
   move up Z1.len/4 from last line.c; "CG0603MLC-05E" "X 2"

   line down_ del from USB.P_1; continue to (USB.P_2,Here); dot
   line from USB.P_2 to (USB.P_2,Z1.end) then to Z1.end
   dot(at (USB.P_2,Here)+(3/2*del,0)); line to (Here,USBVCC)
   dot(,,1); {"USHIELD" at last [].n+(4bp__,0) above}

  L1: reversed(`inductor',down_ from Z1.end to (Z1,C8.end),W,,)
   rlabel(,L1); llabel("svg_thinsp`'BLM21" ljust); dot
   { dot(at (Z2,Here)); line to (Here,U3.Pin28); dot(,,1)
     "UGND" at last [].n above }
   line from USB.Pin1 to (Z2,USB.Pin1) then up 2*del
  XUSB: dot(,,1); {"XUSB" at last [].n above}
   line from (Z1,USB.Pin3) to (Z1,XUSB);
  DP: dot(,,1); {"D`'svg_it(+)" at last [].n above}
   dot(at (DP,USB.Pin2)-(2*del,0)); line to (Here,XUSB)
  DM: dot(,,1); "D`'svg_it(-)" at last [].n above
   line from USB.Pin4 to (DM,USB.Pin4) then to (DM,BRE) then to BRE

   line from U3.Pin18.end right_ 3.5*del
  JP2: Header(A2,2,4*del,2*lg_pinsep,,0.2;pindiam) with .P3.end at Here
   "JP2" at JP2.Block.nw above ljust
   "2X2M - NM" at JP2.s below
   "1" at JP2.P3.end above ljust; "3" at JP2.P1.end above ljust
   "2" at JP2.P4.end above rjust; "4" at JP2.P2.end above rjust
   line from JP2.P1.end to (JP2.P1.end,U3.Pin19) then to U3.Pin19.end
   dot(at JP2.P1.end); line up 3.5*del
  TPPB5: dot(,,1); {"PB5" at last [].e ljust}
  TPPB4: dot(at TPPB5-(del*3/2,0),,1); {"PB4" at last [].w rjust}
   line to (Here,JP2.P3); dot
   line from JP2.P2.end to (JP2.P2.end,TPPB4)
  TPPB7: dot(,,1); {"PB7" at last [].w rjust}
   line from JP2.P4.end right del*3/2; continue to (Here,TPPB4)
  TPPB6: dot(,,1); {"PB6" at last [].n above}
   line from U3.Pin20.end right del then up del; continue to (TPPB6,Here); dot
   line from U3.Pin21.end up del; continue to (TPPB7,Here); dot

  ICSP1: Header(A2,3,4*del,2.5*lg_pinsep,,0.2;pindiam) \
    with .P1.end at (JP2.P1.end,U3.Pin14)
   "ICSP1" at last [].Block.nw above ljust
   "3X2 M" at last [].Block.sw below ljust
   for_(1,5,2,`"m4x" at ICSP1.P`'m4x.end above ljust')
   for_(2,6,2,`"m4x" at ICSP1.P`'m4x.end above rjust')
   line from ICSP1.P1.end to (ICSP1.P1.end,U3.Pin17) then to U3.Pin17.end
   line from ICSP1.P3.end left del; continue to (Here,U3.Pin15) \
     then to U3.Pin15.end

   dot(at U3.Pin24.end); 
  RN1C: resistor(up_ 5*lg_pinsep,,E); rlabel(,10K,RN1C); llabel(5,,3) dot
# D3: diode(up_ 5*lg_pinsep); rlabel(,,D3); dot
   line up_ 2*del; ground(,T,E,U); {"+5 V" at last line.w rjust}
   dot(at U3.Pin24.end-(del,0)); 
# RN1C: resistor(up_ D3.len,,E); llabel(,10K,RN1C)
  D3: diode(up_ RN1C.len); llabel(,,D3)
   line to (TPPB6.x+del,Here.y)
   continue to (Here,ICSP1.P2.end) then to ICSP1.P2.end
   line from ICSP1.P5.end down 2*del; continue to (TPPB6.x+2*del,Here.y)
   TRESET2: Here
   continue to (Here.x,D3.end.y+del) then to (RN1C.end.x-2.5*del,D3.end.y+del)
   continue to (Here,U3.Pin24) then to U3.Pin24.end
  G4: ground(at ICSP1.P6.end,,E); {"GND" at last line.c below }
   line from ICSP1.P4.end right del then up U3.Pin16.y-ICSP1.P4.y \
     then to U3.Pin16.end
   dot(at ICSP1.P1.end); line left_ 2.5*del then down_ 5*del
   MISO2: dot(,,1); {"MISO2" at last [].s below }
   dot(at ICSP1.P3.end-(del,0)); line to (Here,MISO2)
   SCK2: dot(,,1); {"SCK2" at last [].s below ljust }
   dot(at TRESET2); line to (Here,SCK2)
   RESET2: dot(,,1); {"RESET2" wid 36bp__ at last [].s below }
   dot(at ICSP1.P4.end+(del,0)); line to (Here,RESET2)
   MOSI2: dot(,,1); {"MOSI2" at last [].s-(del,0) below }

    line right_ del from U3.Pin11.end then up_ del*3/2
   TXLED: reversed(`diode',right_ elen_,LER)
    rlabel(,YELLOW); llabel(TX); dot
    {line up_ del; TPTXL: dot(,,1); "TXL" at last [].n above}
   RN2C: resistor(right_ elen_,,E); llabel(,1 K RN2C); rlabel(6,,3); dot 
    line from U3.Pin10.end to (TXLED.start,U3.Pin10)
   RXLED: reversed(`diode',to (TXLED.end,Here),LER)
    rlabel(,YELLOW); llabel(RX); dot
    {line up_ del; dot(,,1); "RXL" at last [].n above}
   RN2B: resistor(right_ elen_,,E); llabel(,1 K RN2B); rlabel(7,,2)
    line to (Here,TPTXL); ground(,T,E,U); "+5 V" at last line.c above

# ZU4 connections
   line left_ del*3/2 from ZU4.Pin7.end; dot
   {line up_ del;  G4: ground(,T,E,U); "+5 V" at last line.c above }
  C6: capacitor(down dimen_); llabel(100n,,C6); dot
   { dot(at ZU4.Pin8.end) }; dot(at (ZU4.Pin8.end,Here))
  { G4: ground(at Here+(0,-del),,E); {"GND" at last line.c below }
     line to ZU4.Pin22.end }
   line left_ Here.x-C6.x + dimen_*5/4
  C10: capacitor(up_ C6.len); llabel(100n,,C10); dot
   { line to (Here,ZU4.Pin20) then to ZU4.Pin20.end }
# L2: ebox(right_ to C6.start,,,0.2); rlabel(,L2); llabel(,100`'svg_micro`'H) 
  L2: inductor(right_ to C6.start,W); rlabel(,L2); llabel(,100`'svg_micro`'H) 

   line left 2*del from ZU4.Pin9.end; PE: dot
  R2: resistor(up_ to (Here,ZU4.Pin10),,E); llabel(,R2); rlabel(,1 M); dot 
   dot(at Here-(del*4.0,0)); { "XTAL2" above ljust }
  XTAL: xtal(down_ R2.len); llabel(16 MHz); dot; { "XTAL1" below ljust }
   pushdef(`dimen_',dimen_/2)
   capacitor(left_ del from 0.25 between XTAL.start and XTAL.end)
   capacitor(left_ del from 0.75 between XTAL.start and XTAL.end)
   popdef(`dimen_')
   line up XTAL.len/2
   line left del from last line.c then  down del
  G5: ground(,T,E); "GND" at last line.c below
   line down_ del from XTAL.end; dot(,,1); "XT1" at last [].s below
   line up del from XTAL.start;  dot(,,1); "XT2" at last [].n above
   line from XTAL.start to ZU4.Pin10.end
   line from XTAL.end to ZU4.Pin9.end
   line left 2*del from ZU4.Pin1.end; dot
#  dot(at ZU4.Pin1.end)
  D2: diode(up_ dimen_); rlabel(,D2)
   dot(at D2.start-(2.5*del,0))
  RN1D: resistor(up_ D2.len,,E); rlabel(10 K,,RN1D); dot
   { line to D2.end }
   line up_ del; ground(,T,E,U); "+5 V" at last line.c above

   line from ZU4.Pin1.end to (RN1D-(1.5*del,0),ZU4.Pin1) then up 7*del
   continue to (ZU4.Chip.w,Here)+(del,0); BRB: dot
   { line down_ 2*del; Br2: brdge(right_ dimen_)
      llabel(1,,2); rlabel(,RESET_EN); line up_ 2*del; dot }
   line right_ dimen_+del
  C5: capacitor(right_ dimen_); llabel(,C5); rlabel(100n); dot
  { RN2D: resistor(down_ dimen_,,E); rlabel(,1 K); llabel(,RN2D)
  G6: ground(,T,E); "GND" at last line below }
  { line up_ del; DTR: dot(,,1); "DTR" at last [].e ljust }
   line from U3.Pin13.end right del/2; continue to (Here,U3.Chip.s) \
     then left+2*del; continue to (Here,BRB) then to C5.end
  TP2: Here; continue to C5.end

   line up 3*del from BRB
  TP1: dot #; line left BRB.x-RN1D.x
  RESET: rswitch( right_ dimen_ from (USB.e,Here)+(del/2,0))
   { "RESET" at RESET+(-del*1.7,1.0*del) above }
   line left del from RESET.start then down del
  G7: ground(,T,E); "GND" at last line.c below

  ICSP: Header(A2,3,4*del,2.5*lg_pinsep,,0.2;pindiam) \
    with .Block.sw at ZU4.Pin19.end+(2*del,del*3)
  "ICSP" at ICSP.Block.nw above ljust
  "3X2 M" at ICSP.Block.sw below ljust
   for_(1,5,2,`"m4x" at ICSP.P`'m4x.end above ljust')
   for_(2,6,2,`"m4x" at ICSP.P`'m4x.end above rjust')
   dot(at ZU4.Pin19.end); line to (Here,ICSP.P3) then to ICSP.P3.end
   line from ZU4.Pin18.end right del; dot
   line to (Here,ICSP.P1) then to ICSP.P1.end
   move to ICSP.P5.end; line to (ZU4.Pin19.end,Here)-(del,0);
   continue to (Here,TP1); dot 
   line from ICSP.P2.end up_ del; ground(,T,E,U); "+5 V" at last line.c above
   line from ICSP.P6.end down_ del; G9: ground(,T,E); "GND" at last line.c below
   move to ICSP.P4.end; line right_ del then down Here.y - ZU4.Pin17.y; dot
#  move to ICSP.P4.end; line right_ del then down Here.y - G9.y + del
#    continue to (ICSP.P1.end.x+del,Here.y) then down_ Here.y-ZU4.Pin17.y; dot

   line right_ from RESET.end to (U3.Chip.e+(12*del,0),TP1)
  POWER: Header(A1,8,1.5*del,7*lg_pinsep,,0.2;pindiam) with .P3.end at Here
   "POWER" wid 36bp__ at POWER.Block.nw above ljust
   "8X1F-H8.5" at POWER.Block.sw below ljust
   for_(1,8,1,`"m4x" at POWER.P`'m4x.end above ljust')
   line from POWER.P2.end left del/2 then down POWER.P2.y-POWER.P5.y ; dot
   line from POWER.P4.end left 2.5*del;  "+3V3" above ljust
   dot(at POWER.P3.end-(del*1.5,0)); line up 2*del
   dot(,,1); "RESET" at last [].n above
   line from POWER.P5.end left 3.5*del then up 4*del; ground(,T,E,U)
   "+5 V" at last line.c above
   line left del*2 from POWER.P8.end; "VIN" above ljust
   line left del/2 from POWER.P7.end; dot
   line from POWER.P6.end to (Here,POWER.P6.end) then to Here+(0,-2.5*del)
   G10: ground(,T,E); "GND" at last line.c below
   
   right_

  IOH: Header(A1,10,1.5*del,10*lg_pinsep,,0.2;pindiam) \
    with .P10.end at ZU4.Pin14.end + (del*15,0)
   "IOH" at IOH.Block.nw above ljust
   "10X1F-H8.5" at IOH.Block.se below ljust
   for_(0,9,1,`
     { "incr(m4x)" above ljust at IOH.P`'eval(10-m4x).end }
     move to IOH.P`'eval(10-m4x).start-(pindiam/2+dotrad_/2,0)
     ifelse(m4x,6,,`dot')
     move to IOH.P`'eval(10-m4x).end
     ifelse(eval(m4x<6),1,`line from ZU4.Pin`'eval(14+m4x).end to Here ')
     ifelse(m4x,6,,` line right del*4; dot(,pindiam/2,1) ')
     ifelse(eval(m4x<6),1,`"eval(8+m4x)" at last [].e ljust ')')
   "SCL" at last [].e ljust
   "SDA" at 3rd last [].e ljust
   "AREF" at 5th last [].e ljust

  AD: Header(A1,6,1.5*del,6*lg_pinsep,,0.2;pindiam) \
    with .P6.end at (IOH.P10.end,ZU4.Pin23) #.end + (del*6,0)
#   with .P6.end at ZU4.Pin23.end + (del*6,0)
   "AD" at AD.Block.nw above ljust
   "6X1F-H8.5" at AD.Block.se below ljust
   for_(0,5,1,`
     dot(at AD.P`'eval(6-m4x).start-(pindiam/2+dotrad_/2,0))
     line from ZU4.Pin`'eval(23+m4x).end \
       to AD.P`'eval(6-m4x).end; {"incr(m4x)" above ljust}
     line right del*4; dot(,pindiam/2,1)
     "A`'m4x" at last [].e ljust ')

  IOL: Header(A1,8,1.5*del,8*lg_pinsep,,0.2;pindiam) \
    with .P8.end at (AD.P1.end,ZU4.Pin2)
   "IOL" at IOL.Block.nw above ljust
   "8X1F-H8.5" at IOL.Block.sw ljust below
   for_(0,7,1,`
     dot(at IOL.P`'eval(8-m4x).start-(pindiam/2+dotrad_/2,0))
     line from ZU4.Pin`'eval(ifelse(eval(m4x<5),1,2,6)+m4x).end \
       to IOL.P`'eval(8-m4x).end; {"incr(m4x)" above ljust}
     line right del*4; dot(,pindiam/2,1)
     "m4x" at last [].e ljust ')

   line from ZU4.Pin21.end up RESET.y-ZU4.Pin21.y-del \
     then right ICSP.P4.end.x-ZU4.Pin21.end.x + 2*del
   continue to (Here,IOH.P3)+(0,del*3/2); dot
   { C4: capacitor(down_ 3.0*del); llabel(C4,,100n)
     { ground(,T,E); "GND" at last line.e ljust}
     line from IOH.P4.end to (Here,IOH.P4); dot }
   line right del*3/2; continue to (Here,IOH.P3) then to IOH.P3.end

   line left del/2 from IOH.P2.end; continue to (Here,AD.P2); dot
   line left del*3/2 from IOH.P1.end; continue to (Here,AD.P1); dot

#  line right_ del*2 from U3.Pin9.end then down_ 5.5*lg_pinsep; dot
   line right_ del*2 from U3.Pin9.end then down_ 3.5*lg_pinsep; dot
   { line right_ 2*del; dot(,,1); "RX" at last [].e ljust }
   line to (Here,RESET)-(0,del)
  RN4B: resistor(down_ dimen_,,E); llabel(7,"RN4B" ljust "1 K" ljust,2)
   line down_ del then left_ Here.x - IOH.P9.end.x + del*2.5
   continue to (Here,ZU4.Pin2); dot

   line right_ del from U3.Pin8.end; dot
   { line right_ 3*del; dot(,,1); "TX" at last [].e ljust }
   line to (Here,RN4B.start)
  RN4A: resistor(down_ dimen_,,E); rlabel(8,"RN4A" rjust "1 K" rjust,1)
   line to (IOH.P9.end,Here)-(del*3.5,0); continue to (Here,ZU4.Pin3); dot

Pwr: [
  Vin: line right 2*del "VIN" above
  RN1A: resistor(down_ dimen_*5/4,,E); rlabel(8, "RN1A" rjust "10 K" rjust ,1)
  CMP: dot
  RN1B: resistor(down_ dimen_*5/4,,E); rlabel(2, "RN1B" rjust "10 K" rjust ,7)
  B12: ground(,T,E); "GND" at last line below

    line right_ 2*del from CMP; dot
    { line up_ 2*del; dot(,,1); "CMP" at last [].n above }
    line right_ del
   POA: opamp(,"+" ljust,"-" ljust) with .In1 at Here
    "U5A" at last [].n; "1" at POA.Out above rjust
    "3" at POA.In1 rjust above; "2" at POA.In2 rjust above
    line left_ del from POA.In2 then down_ del; "+3V3" below
    dot(at POA.Out); {line up_ 2*del; dot(,,1); "GATE" at last [].n above }
   T1: mosfet(down_ dimen_*1.5,R,dMdPyEDSQdB,) with .G at Here 
    "T1" at T1 + (-dimen_/4,del*5/4)
    "FDN340P" at T1 + (0,-del*5/4) rjust
#   "USBVCC" at T1.D rjust
    dot(at T1.S); { line up_ 2*del; ground(,T,E,U); "+5 V" at last line above }
   ] with .RN1B at (USB.e.x+del,RN1C.y-2*del)
   dot(at XUSB+(0,-del/2))
  F1: fuse(right_ to (Pwr.T1.D,Here)); { "500 mA" ljust }
   { "MF-MSMF050-2" at last [].sw below ljust }
   line to Pwr.T1.D

   line from Pwr.T1.S right_ 2.5*lg_pinsep
  { U2:box ht 3*lg_pinsep wid 5*lg_pinsep with .nw at Here+(0,lg_pinsep/2) }
   {"1" above rjust}; {"IN" ljust}
   "LP2985-33DBVR" at U2.s below
   "U2" above ljust at U2.nw
   "3" above rjust at U2.w; line left del from U2.w then up_ lg_pinsep; dot
   "ON/svg_ol(OFF)" at U2.w ljust
#  line right_ textht*0.66*3 from U2.w+(textht*0.66*5,textht)
  U2P2: U2.w+(0,-lg_pinsep); "2" at U2P2 above rjust; "GND" at U2P2 ljust
   line from U2P2 left del then down_ del
  G15: ground(,T,E); "GND" at last line.c below
  U2P5: (U2.e.x,U2.e.y+lg_pinsep)
   "OUT" at U2P5 rjust; "5" at U2P5 above ljust
   line from U2P5 right 2*del "+3V3" below; dot
   { line up_ del; dot(,,1); "3V3" at last [].n above }
  C3: capacitor(down_ to(Here,G15)); rlabel(,"C3" rjust "1`'svg_micro" rjust)
   ground(,T,E); "GND" at last line.c below
   "NC/FB" at (U2.e.x,U2P2.y) rjust

   "SCK" above ljust at Pwr.Vin + (0,4*del)
  line right_ 3*del
  U5B: opamp(,"+" ljust, "-" ljust) with .In1 at Here
   "5" at U5B.In1 above rjust; "6" at U5B.In2 above rjust
   "U5B" at last [].n; "7" at U5B.Out above rjust
   line from U5B.In2 left del then down del then right U5B.Out.x-U5B.In1.x+del
   TD2: dot
   dot(at U5B.Out); dot(at Here+(0,2*del),,1); "LCMD" at last [].e ljust
   line down_ from last [].s to TD2
   RN2A: resistor(right_ dimen_*5/4,,E); llabel(8,"1K",1); rlabel(,RN2A)
   dot; {line up_ 2*del; dot(,,1); "LL" at last [].n above }
   diode(right_ dimen_*5/4,LE); rlabel(,YELLOW)
   line down_ dimen_/4; egnd
    
  X1:box ht 3*lg_pinsep wid 5*lg_pinsep with .w at (U2.x,U5B.y+del)
   "X1 DC21MMX" at X1.nw above ljust; "PWR SUPPLY" at X1.nw below ljust
  X1P1: 1/3 between X1.sw and X1.se; "1" at X1P1 rjust below
  X1P2: 2/3 between X1.sw and X1.se; "2" at X1P2 rjust below
   line down_ del from X1P1; dot; { egnd }
   line right X1.e.x+del - Here.x then up_ X1.e.y-Here.y then to X1.e
   "3" above ljust at X1.e
   line from X1P2 down del/2 then right X1.e.x+del*2 - X1P2.x \
     then up X1.n.y - X1P2.y + del/2; dot
   { line up_ 2*del; PWRIN: dot(,,1); "PWRIN" at last [].w rjust }
  D1: diode(right_ dimen_); llabel(,D1); rlabel(,M7); dot
  { PC1: capacitor(down_ dimen_,C); llabel(,"PC1" ljust "47`'svg_micro" ljust) 
     G16: egnd }
   { line to (Here,PWRIN); dot(,,1); "VIN" at last [].e ljust }
   line right 3*del; { "3" above rjust }
  U1P1: Here
  U1: box ht 3*lg_pinsep wid 4*lg_pinsep with .nw at Here+(0,lg_pinsep/2)  
   "IN" at U1P1 ljust; "OUT" at (U1.e,U1P1) rjust
   "1" below rjust at U1.s
   "U1" at U1.nw +  (0,textht/dptextratio) above ljust \
   "NCP1117ST50T3G"  ljust
   line from U1.s to (U1.s,G16); egnd
  U1P4: (U1.e,U1P1); U1P2: U1P4+(0,-del)
   { "4" at U1P4 above ljust }; { "2" at U1P2 above ljust }; 
   line right_ 2*del from U1P4; dot;
   line from U1P2 to (Here,U1P2); dot; { line to (Here,U1P4) }
  { PC2: capacitor(down_ to (Here,G16),C)
   llabel(,"PC2" ljust "47`'svg_micro" ljust); egnd }
   line right_ del*3/2 from (Here,U1P4); dot
   { line to (Here,PWRIN); ground(,T,E,U); "+5V" at last line.c above }
   line right_ del*3/2; dot; { line to (Here,PC2.start)
    C2: capacitor(down_ to (Here,G16),C)
   llabel(,"C2" ljust "100`'svg_micro" ljust); egnd }
   { line to (Here,PWRIN); dot(,,1); "5V" at last [].n above }
   line right_ del*3/2 then to (Here.x+del*3/2,PWRIN.y); dot(,,1)
   "5V1" at last [].n above



  command "</g>"
.PE
