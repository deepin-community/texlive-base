.PS
# EV_lugs.m4
# https://en.wikipedia.org/wiki/CHAdeMO
gen_init
divert(-1)

                            `EV_J1772(keys)
                             EV charging plug in a [] block
                             keys: wdth=expr;     # plug width
                                   diamLNP=expr;  # diam of L1, N, PE
                                   twdth=expr;    # tab width
                                   thgt=expr;     # tab hght
                                   thick=expr;    # outer line thickness (pt)
                                   inthick=expr;  # inner line thickness (pt)
                                   BG=attributes; # shaded gray etc
                                   L1=attributes; # L1 attributes ...
                                   N=attributes;
                                   PE=attributes;
                                   PP=attributes;
                                   CP=attributes; '
define(`pEVskale',25.4)       dnl default plug size (20 mm)
define(`EV_J1772',`[ pushkeys_(`$1', `wdth:20/pEVskale;
    twdth:3.5/20*m4wdth; thgt:1.5/20*m4wdth; diamLNP:6/20*m4wdth;
    thick:2; inthick:1.5; BG::N; L1::N; N::N; PE::N; PP::N; CP::N; ')
    tang = atan2(m4twdth/2,m4wdth/2)*rtod_
  TS: (Rect_(m4wdth/2,-90-tang)); TE: (Rect_(m4wdth/2,-90+tang))
  Tab: line thick m4thick from TS down_ m4thgt \
        then to TE-(0,m4thgt) then to TE m4BG
  Arc: arc thick m4thick to TS with .c at (0,0) m4BG
      round(at TS,last arc.thick); round(at TE,last arc.thick)
  L1: circle diam m4diamLNP thick m4inthick at (Rect_(m4wdth/4,150)) m4L1
  N:  circle diam m4diamLNP thick m4inthick at (Rect_(m4wdth/4, 30)) m4N
  PE: circle diam m4diamLNP thick m4inthick at (0,-m4wdth/4) m4PE
  PP: circle diam m4diamLNP*0.55 thick m4inthick at (Rect_(m4wdth/3,210)) m4PP
  CP: circle diam m4diamLNP*0.55 thick m4inthick at (Rect_(m4wdth/3,-30)) m4CP
  `$2' popdef(`m4CP',`m4PP',`m4PE',`m4N',`m4L1',`m4BG',
   `m4wdth',`m4diamLNP',`m4twdth',`m4thgt',`m4thick',`m4inthick') ]')

                            `EV_J3068(keys,shade)
                             EV charging plug in a [] block
                             keys: wdth=expr;     # plug width
                                   diamLNP=expr;  # diam of L1, N, PE
                                   twdth=expr;    # tab width
                                   thgt=expr;     # tab hght
                                   thick=expr;    # outer line thickness (pt)
                                   inthick=expr;  # inner line thickness (pt)
                                   BG=attributes; # shaded gray etc
                                   L1|L2|L3=attributes; # pin attributes ...
                                   N=attributes;
                                   PE=attributes;
                                   PP=attributes;
                                   CP=attributes;
                             arg2= R:G:B background fill color '
define(`EV_J3068',`[ pushkeys_(`$1',
   `wdth:25/pEVskale; diamLNP:m4wdth*0.25; thick:2; inthick:1.5;
    BG::N; L1::N; L2::N; L3::N; N::N; PE::N; PP::N; CP::N; ')
  C: Here
  NE: C+(Rect_(m4wdth/2,45)); NW: C+(Rect_(m4wdth/2,135))
  Ac: NE-(1,1)/sqrt(2)*m4diamLNP/2
  Arc: arc thick m4thick from NW to NE with .c at C m4BG ifelse(`$2',,,
    `shaded rgbstring(patsubst(`$2',:,`,'))
     line invis from NE to Ac+(0,m4diamLNP/2) \
       then to Ac+(0,m4diamLNP/2) \
       then to NW+(1,-1)/sqrt(2)*m4diamLNP/2 + (0,m4diamLNP/2) \
       then to NW then to NE shaded rgbstring(patsubst(`$2',:,`,'))')
  arc thick m4thick to Ac+(0,m4diamLNP/2) with .c at Ac m4BG
  Top: line thick m4thick to (NW+NE-Ac, Here) m4BG
  arc thick m4thick to NW with .c at Here+(0,-m4diamLNP/2) m4BG
  PE: circle diam m4diamLNP thick m4inthick at C m4PE
  PP: circle diam m4diamLNP*0.55 thick m4inthick at C+(Rect_(m4wdth/3,45)) m4PP
  CP: circle diam m4diamLNP*0.55 thick m4inthick at C+(Rect_(m4wdth/3,135)) m4CP
  L1: circle diam m4diamLNP thick m4inthick at C+(m4wdth*.3,0) m4L1
  L2: circle diam m4diamLNP thick m4inthick at C+(Rect_(m4wdth*.3,-60)) m4L2
  L3: circle diam m4diamLNP thick m4inthick at C+(Rect_(m4wdth*.3,-120)) m4L3
  N:  circle diam m4diamLNP thick m4inthick at C-(m4wdth*.3,0) m4N
  `$3' popdef(`m4wdth',`m4diamLNP',`m4thick',`m4inthick',
   `m4BG',`m4L1',`m4L2',`m4L3',`m4N',`m4PE',`m4PP',`m4CP') ]')

                            `EV_CCS1(J1772 keys,DC keys)
                             DC keys: wdth=expr;  # DC socket width
                                   hght=expr;     # DC socket height
                                   diamPM=expr;   # diam of DC+, DC- circles
                                   sep=expr;      # separation of Jack and DC
                                   thick=expr;    # outer line thickness (pt)
                                   inthick=expr;  # inner line thickness (pt)
                                   BG=attributes; # shaded gray etc
                                   DCplus=attributes;
                                   DCminus=attributes; '
define(`EV_CCS1',`[
  J: EV_J1772(`$1')
  pushkeys_(`$2',`wdth:J.wid:23.5/20; hght:J.wid*11/20; diamPM:m4hght*7/11;
                  sep:J.wid*3/30; thick:J.Arc.thick; inthick:J.PE.thick;
                  BG::N; DCplus::N; DCminus::N;')
  DC: [ Box: box thick m4thick wid m4wdth ht m4hght rad m4hght/2 m4BG
    DCplus: circle thick m4inthick diam m4diamPM at Box.w+(m4hght/2,0) m4DCplus
    DCminus:circle thick m4inthick diam m4diamPM at Box.e-(m4hght/2,0) m4DCminus
    ] with .n at J.s+(0,-m4sep)
  popdef(`m4wdth',`m4hght',`m4diamPM',`m4sep',`m4thick',`m4inthick',`m4BG',
   `m4DCplus',`m4DCminus')
  ]')

                            `EV_CCS2(J3068 keys,shade,DC keys)
                             DC keys: wdth=expr;  # DC socket width
                                   hght=expr;     # DC socket height
                                   diamPM=expr;   # diam of DC+, DC- circles
                                   sep=expr;      # separation of Jack and DC
                                   thick=expr;    # outer line thickness (pt)
                                   inthick=expr;  # inner line thickness (pt)
                                   BG=attributes; # shaded gray etc
                                   DCplus=attributes;
                                   DCminus=attributes;
                             arg2= R:G:B background fill color '
define(`EV_CCS2',`[
  J: EV_J3068(`$1',`$2')
  pushkeys_(`$3',`wdth:J.wid:23.5/20; hght:J.wid*11/20; diamPM:m4hght*7/11;
                  sep:J.wid*3/30; thick:J.Arc.thick; inthick:J.PE.thick;
                  BG::N; DCplus::N; DCminus::N;')
  DC: [ Box: box thick m4thick wid m4wdth ht m4hght rad m4hght/2 dnl
      m4BG ifelse(`$2',,,`shaded rgbstring(patsubst(`$2',:,`,'))')
    DCplus: circle thick m4inthick diam m4diamPM at Box.w+(m4hght/2,0) m4DCplus
    DCminus:circle thick m4inthick diam m4diamPM at Box.e-(m4hght/2,0) m4DCminus
    ] with .n at J.s+(0,-m4sep)
  popdef(`m4wdth',`m4hght',`m4diamPM',`m4sep',`m4thick',`m4inthick',`m4BG',
   `m4DCplus',`m4DCminus')
  ]')

                            `EV_CHAdeMO(keys,shade)
                             EV charging plug in a [] block
                             keys: wdth=expr;     # plug width
                                   thick=expr;    # outer line thickness (pt)
                                   inthick=expr;  # inner line thickness (pt)
                                   BG=attributes; # background shaded gray etc
                                   DCplus=|DCminusNS=|FG=|NC=|SS1=|DCP=|PP=|
                                   CL=|CH=|SS2=attributes # pin attributes ...'
define(`EV_CHAdeMO',`[ pushdef(`m4sk',33/140/pEVskale) pushkeys_(`$1',
   `wdth:140*m4sk; thick:m4wdth*9/140/(1bp__); inthick:m4thick*1.5/9;
    BG::N; DCplus::N; DCminus::N;N::N;S::N;
    FG::N; NC::N; SS1::N; DCP::N; PP::N; CL::N; CH::N; SS2::N')
 C: circle thick m4thick diam m4wdth-m4thick bp__ m4BG
  line thick m4thick*0.6 from C+(Rect_(C.rad+m4thick bp__*3/4,42)) \
    to C+(Rect_(C.rad+m4thick bp__*3/4,50)) then left m4thick bp__ m4BG
  line thick m4thick*0.6 from C+(Rect_(C.rad+m4thick bp__*3/4,138)) \
    to C+(Rect_(C.rad+m4thick bp__*3/4,130)) then right m4thick bp__ m4BG
  idiam = (m4wdth-m4thick bp__*2)*47/(27+47*2)
 N: circle diam idiam thick m4inthick with .n at C.n-(0,m4thick bp__/2) m4N
 S: circle diam idiam thick m4inthick with .s at C.s+(0,m4thick bp__/2) m4S
 E: circle diam idiam thick m4inthick at Cintersect(N,N.diam,S,S.diam) m4DCminus
 W: circle diam idiam thick m4inthick at Cintersect(S,S.diam,N,N.diam) m4DCplus
 Loopover_(`Z',
  `line thick m4inthick up Z.diam*0.6 right Z.diam*0.6 with .c at Z
   line thick m4inthick up Z.diam*0.6 left Z.diam*0.6 with .c at Z',N,S)
 Loopover_(`L',`L: circle diam idiam/4 thick linethick/2 \
   at N+(Rect_(idiam/4,90*m4Lx)) m4xpand(m4`'L)',FG,NC,DCP,SS1)
 Loopover_(`L',`L: circle diam idiam/4 thick linethick/2 \
   at S+(Rect_(idiam/4,90*m4Lx)) m4xpand(m4`'L)',PP,CL,SS2,CH)
 `$3' popdef(`m4sk',`m4wdth',`m4thick',`m4inthick',`m4BG',
  `m4DCplus',`m4DCminus',`m4N',`m4S',
  `m4FG',`m4NC',`m4SS1',`m4DCP',`m4PP',`m4CL',`m4CH',`m4SS2') ]')

divert(0)dnl

  ifsvg(svg_font(sans-serif,6bp__))
  iflatex(command "{\sf\scriptsize")
  define(`EVsmall',`ifsvg(svg_small(`$1'),{\tiny `$1'})')
  define(`EVtxt',`ifsvg(``$1'',`{patsubst(`$1',_,\\_)}')')
  define(`EVk',`ifsvg(+(0,0.75bp__))')

[
P1: EV_J1772(BG=fill_(0.75); PE=fill_(1) "PE";L1=fill_(1) "L1";N=fill_(1) "N";
   PP=fill_(1); CP=fill_(1);)
   "EVsmall(PP)" at P1.PP EVk
   "EVsmall(CP)" at P1.CP EVk

P2: EV_J3068(PE=shaded "green" "PE";\
    L1=shaded "yellow" "L1";L2=shaded "yellow" "L2";L3=shaded "yellow" "L3";
    N=fill_(1) "N";",
     0.85:0.85:0.85) at P1+(15bp__,0) \
     with .w at P1.e+(P1.wid/5,0)
   "EVsmall(PP)" at P2.PP EVk
   "EVsmall(CP)" at P2.CP EVk

P3: EV_CCS1(L1="L1";N="N";PE="PE",
      DCplus="DC+";DCminus="DC-") with .w at P2.e+(P1.wid/5,0)
   "EVsmall(PP)" at P3.J.PP EVk
   "EVsmall(CP)" at P3.J.CP EVk

P4: EV_CCS2(L1="L1";L2="L2";L3="L3";N="N";PE="PE",0.85:0.85:0.85,
      DCplus="DC+";DCminus="DC-") with .w at P3.e+(P1.wid/5,0)
   "EVsmall(PP)" at P4.J.PP EVk
   "EVsmall(CP)" at P4.J.CP EVk
P5: EV_CHAdeMO( BG=outlined "blue" fill_(0.8);
    DCplus=shaded "red" "DC+";
    DCminus=shaded "red" "DC-";
    Loopover_(`L',`L=fill_(1);',N,S)
    FG=shaded "green";
    Loopover_(`L',`L=shaded "orange";',SS1,DCP,NC,PP,CH,SS2,CL)) \
      with .w at P4.e+(P4.w.x-P3.e.x,0)
  Loopover_(`L',`"EVsmall(L)" at P5.L EVk',FG,NC,DCP,SS1,PP,CL,CH,SS2)
#
   ifsvg(move from P5.e right 0.2)
   "EVtxt(`EV_CCS2')" at P4.s+(0,-10bp__)
   "EVtxt(`EV_CCS1')" at (P3,last "")
   "EVtxt(`EV_J3068')" at (P2,last "")
   "EVtxt(`EV_J1772')" at (P1,last "")
   "EVtxt(`EV_CHAdeMO')" at (P5,last "")
  ] # with .nw at last [].sw+(0,-0.2)

  iflatex(command "}%")
  ifsvg(command "</g>")
.PE
