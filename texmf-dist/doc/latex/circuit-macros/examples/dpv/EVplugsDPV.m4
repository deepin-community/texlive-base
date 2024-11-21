.PS
# EVplugs.m4
# https://en.wikipedia.org/wiki/CHAdeMO
# https://en.wikipedia.org/wiki/North_American_Charging_Standard
# https://tesla-cdn.thron.com/static/HXVNIC_North_American_Charging_Standard_Technical_Specification_TS-0023666_HFTPKZ.pdf?xseo=&response-content-disposition=inline%3Bfilename%3D%22North-American-Charging-Standard-Technical-Specification-TS-0023666.pdf%22

gen_init
divert(-1)

                            `EV_J1772(keys)
                             EV charging plug in a [] block
                             keys: wdth=expr;     # plug width
                                   diamLNP=expr;  # diam of L1, N, PE
                                   twdth=expr;    # tab width
                                   thgt=expr;     # tab hght
                                   thick=expr;    # outer line thickness (pt)
                                   thickin=expr;  # inner line thickness (pt)
                                   BG=attributes; # shaded gray etc
                                   L1=attributes; # L1 attributes ...
                                   N=attributes;
                                   PE=attributes;
                                   PP=attributes;
                                   CP=attributes; '
define(`pEVskale',25.4)       dnl default plug size (20 mm)
define(`EV_J1772',`[ pushkeys_(`$1', `wdth:20/pEVskale;
    twdth:3.5/20*m4`'wdth; thgt:1.5/20*m4`'wdth; diamLNP:6/20*m4`'wdth;
    thick:2; thickin:1.5; BG::N; L1::N; N::N; PE::N; PP::N; CP::N; ')
    tang = atan2(m4twdth/2,m4wdth/2)*rtod_
  TS: (Rect_(m4wdth/2,-90-tang)); TE: (Rect_(m4wdth/2,-90+tang))
  Tab: line thick m4thick from TS down_ m4thgt \
        then to TE-(0,m4thgt) then to TE m4BG
  Arc: arc thick m4thick to TS with .c at (0,0) m4BG
      round(at TS,last arc.thick); round(at TE,last arc.thick)
  L1: circle diam m4diamLNP thick m4thickin at (Rect_(m4wdth/4,150)) m4L1
  N:  circle diam m4diamLNP thick m4thickin at (Rect_(m4wdth/4, 30)) m4N
  PE: circle diam m4diamLNP thick m4thickin at (0,-m4wdth/4) m4PE
  PP: circle diam m4diamLNP*0.55 thick m4thickin at (Rect_(m4wdth/3,210)) m4PP
  CP: circle diam m4diamLNP*0.55 thick m4thickin at (Rect_(m4wdth/3,-30)) m4CP
  `$2' popdef(`m4CP',`m4PP',`m4PE',`m4N',`m4L1',`m4BG',
   `m4wdth',`m4diamLNP',`m4twdth',`m4thgt',`m4thick',`m4thickin') ]')

                            `EV_J3068(keys,shade)
                             EV charging plug in a [] block
                             keys: wdth=expr;     # plug width
                                   diamLNP=expr;  # diam of L1, N, PE
                                   twdth=expr;    # tab width
                                   thgt=expr;     # tab hght
                                   thick=expr;    # outer line thickness (pt)
                                   thickin=expr;  # inner line thickness (pt)
                                   BG=attributes; # shaded gray etc
                                   L1|L2|L3=attributes; # pin attributes ...
                                   N=attributes;
                                   PE=attributes;
                                   PP=attributes;
                                   CP=attributes;
                             arg2= R:G:B background fill color '
define(`EV_J3068',`[ pushkeys_(`$1',
   `wdth:25/pEVskale; diamLNP:m4`'wdth*0.25; thick:2; thickin:1.5;
    BG::N; L1::N; L2::N; L3::N; N::N; PE::N; PP::N; CP::N; ')
  C: Here
  NE: C+(Rect_(m4wdth/2,45)); NW: C+(Rect_(m4wdth/2,135))
  Ac: NE-(1,1)/sqrt(2)*m4diamLNP/2
  Arc: arc thick m4thick from NW to NE with .c at C m4BG ifelse(`$2',,,
    `shaded rgbstring(patsubst(`$2',:,`,'))
     line invis from NE to Ac+(0,m4diamLNP/2) \
       then to NW+(1,-1)/sqrt(2)*m4diamLNP/2 + (0,m4diamLNP/2) \
       then to NW then to NE shaded rgbstring(patsubst(`$2',:,`,'))')
  arc thick m4thick to Ac+(0,m4diamLNP/2) with .c at Ac m4BG
  Top: line thick m4thick to (NW+NE-Ac, Here) m4BG
  arc thick m4thick to NW with .c at Here+(0,-m4diamLNP/2) m4BG
  PE: circle diam m4diamLNP thick m4thickin at C m4PE
  PP: circle diam m4diamLNP*0.55 thick m4thickin at C+(Rect_(m4wdth/3,45)) m4PP
  CP: circle diam m4diamLNP*0.55 thick m4thickin at C+(Rect_(m4wdth/3,135)) m4CP
  L1: circle diam m4diamLNP thick m4thickin at C+(m4wdth*.3,0) m4L1
  L2: circle diam m4diamLNP thick m4thickin at C+(Rect_(m4wdth*.3,-60)) m4L2
  L3: circle diam m4diamLNP thick m4thickin at C+(Rect_(m4wdth*.3,-120)) m4L3
  N:  circle diam m4diamLNP thick m4thickin at C-(m4wdth*.3,0) m4N
  `$3' popdef(`m4wdth',`m4diamLNP',`m4thick',`m4thickin',
   `m4BG',`m4L1',`m4L2',`m4L3',`m4N',`m4PE',`m4PP',`m4CP') ]')

                            `EV_CCS1(J1772 keys,DC keys)
                             DC keys: wdth=expr;  # DC socket width
                                   hght=expr;     # DC socket height
                                   diamPM=expr;   # diam of DC+, DC- circles
                                   sep=expr;      # separation of Jack and DC
                                   thick=expr;    # outer line thickness (pt)
                                   thickin=expr;  # inner line thickness (pt)
                                   BG=attributes; # shaded gray etc
                                   DCplus=attributes;
                                   DCminus=attributes; '
define(`EV_CCS1',`[
  J: EV_J1772(`$1')
  pushkeys_(`$2',`wdth:J.wid:23.5/20; hght:J.wid*11/20; diamPM:m4`'hght*7/11;
                  sep:J.wid*3/30; thick:J.Arc.thick; thickin:J.PE.thick;
                  BG::N; DCplus::N; DCminus::N;')
  DC: [ Box: box thick m4thick wid m4wdth ht m4hght rad m4hght/2 m4BG
    DCplus: circle thick m4thickin diam m4diamPM at Box.w+(m4hght/2,0) m4DCplus
    DCminus:circle thick m4thickin diam m4diamPM at Box.e-(m4hght/2,0) m4DCminus
    ] with .n at J.s+(0,-m4sep)
  popdef(`m4wdth',`m4hght',`m4diamPM',`m4sep',`m4thick',`m4thickin',`m4BG',
   `m4DCplus',`m4DCminus')
  ]')

                            `EV_CCS2(J3068 keys,shade,DC keys)
                             DC keys: wdth=expr;  # DC socket width
                                   hght=expr;     # DC socket height
                                   diamPM=expr;   # diam of DC+, DC- circles
                                   sep=expr;      # separation of Jack and DC
                                   thick=expr;    # outer line thickness (pt)
                                   thickin=expr;  # inner line thickness (pt)
                                   BG=attributes; # shaded gray etc
                                   DCplus=attributes;
                                   DCminus=attributes;
                             arg2= R:G:B background fill color '
define(`EV_CCS2',`[
  J: EV_J3068(`$1',`$2')
  pushkeys_(`$3',`wdth:J.wid:23.5/20; hght:J.wid*11/20; diamPM:m4`'hght*7/11;
                  sep:J.wid*3/30; thick:J.Arc.thick; thickin:J.PE.thick;
                  BG::N; DCplus::N; DCminus::N;')
  DC: [ Box: box thick m4thick wid m4wdth ht m4hght rad m4hght/2 dnl
      m4BG ifelse(`$2',,,`shaded rgbstring(patsubst(`$2',:,`,'))')
    DCplus: circle thick m4thickin diam m4diamPM at Box.w+(m4hght/2,0) m4DCplus
    DCminus:circle thick m4thickin diam m4diamPM at Box.e-(m4hght/2,0) m4DCminus
    ] with .n at J.s+(0,-m4sep)
  popdef(`m4wdth',`m4hght',`m4diamPM',`m4sep',`m4thick',`m4thickin',`m4BG',
   `m4DCplus',`m4DCminus')
  ]')

                            `EV_CHAdeMO(keys,shade)
                             EV charging plug in a [] block
                             keys: wdth=expr;     # plug width
                                   thick=expr;    # outer line thickness (pt)
                                   thickin=expr;  # inner line thickness (pt)
                                   BG=attributes; # background shaded gray etc
                                   DCplus=|DCminusNS=|FG=|NC=|SS1=|DCP=|PP=|
                                   CL=|CH=|SS2=attributes # pin attributes ...'
define(`EV_CHAdeMO',`[ pushdef(`m4sk',33/140/pEVskale) pushkeys_(`$1',
   `wdth:140*m4sk; thick:m4`'wdth*9/140/(1bp__); thickin:m4`'thick*1.5/9;
    BG::N; DCplus::N; DCminus::N;N::N;S::N;
    FG::N; NC::N; SS1::N; DCP::N; PP::N; CL::N; CH::N; SS2::N')
 C: circle thick m4thick diam m4wdth-m4thick bp__ m4BG
  line thick m4thick*0.6 from C+(Rect_(C.rad+m4thick bp__*3/4,42)) \
    to C+(Rect_(C.rad+m4thick bp__*3/4,50)) then left m4thick bp__ m4BG
  line thick m4thick*0.6 from C+(Rect_(C.rad+m4thick bp__*3/4,138)) \
    to C+(Rect_(C.rad+m4thick bp__*3/4,130)) then right m4thick bp__ m4BG
  idiam = (m4wdth-m4thick bp__*2)*47/(27+47*2)
 N: circle diam idiam thick m4thickin with .n at C.n-(0,m4thick bp__/2) m4N
 S: circle diam idiam thick m4thickin with .s at C.s+(0,m4thick bp__/2) m4S
 E: circle diam idiam thick m4thickin at Cintersect(N,N.diam,S,S.diam) m4DCminus
 W: circle diam idiam thick m4thickin at Cintersect(S,S.diam,N,N.diam) m4DCplus
 foreach_(`Z',
  `line thick m4thickin up Z.diam*0.6 right Z.diam*0.6 with .c at Z
   line thick m4thickin up Z.diam*0.6 left Z.diam*0.6 with .c at Z',N,S)
 foreach_(`L',`L: circle diam idiam/4 thick linethick/2 \
   at N+(Rect_(idiam/4,90*m4Lx)) m4xpand(m4`'L)',FG,NC,DCP,SS1)
 foreach_(`L',`L: circle diam idiam/4 thick linethick/2 \
   at S+(Rect_(idiam/4,90*m4Lx)) m4xpand(m4`'L)',PP,CL,SS2,CH)
 `$3' popdef(`m4sk',`m4wdth',`m4thick',`m4thickin',`m4BG',
  `m4DCplus',`m4DCminus',`m4N',`m4S',
  `m4FG',`m4NC',`m4SS1',`m4DCP',`m4PP',`m4CL',`m4CH',`m4SS2') ]')

                            `EV_NAC(keys)
                             NAC (Tesla) charging plug in a [] block
                             keys: wdth=expr;     # plug width
                                   diamL=expr; # diam of L1, L2
                                   BG=background attributes; # shaded "gray"
                                   L1=attributes; # L1 attributes ...
                                   L1inner=attributes; # inner circle...
                                   L2=attributes; # L2 attributes ...
                                   L2inner=attributes; # inner circle...
                                   inner=attributes; # central object
                                   Gnd=attributes;
                                   Gndinner=attributes;
                                   PP=attributes;
                                   CP=attributes; '
define(`EV_NAC',`[ pushkeys_(`$1', `wdth:1.6; diamL:m4`'wdth*0.28; BG::N;
   L1::N; L1inner::N; L2::N; L2inner::N; Gndinner::N; inner::N;
   Gnd::N; PP::N; CP::N; ')
  sN = 1/pEVskale*m4wdth/1.6      # drawing coord scale factor
  tt = 8.5/160*m4wdth;            # outer width
  rt = (4^2+43^2)/(2*4)/4*sN; rb = (23^2+56.5^2)/(2*23)/4*sN # arc radii
  Ct: (0,0.83*m4wdth-rt); Cb: (0,rb) # arc centres
  ra = rb*0.45; ri = ra/4         # radii
  NAC_fillet(Ct,-rt,Cb,-rb,ra,NW,Wt,Wb) # draw outer boundary
  NE: (-NW.x,NW.y); Eb: (-Wb.x,Wb.y); Et: (-Wt.x,Wt.y)
  m = 9; n = 0; P[n]: (0,0)
  NAC_arc(m,Cb,rb,-pi_/2,langle(Cb,Eb))
  NAC_arc(m,NE,ra,langle(NE,Eb),langle(NE,Et))
  NAC_arc(m,Ct,rt,langle(Ct,Et),pi_/2)
  fitcurve(P,n,shaded "lightgray" m4BG,-n)
  pushdef(`m4EVs',`shaded graystring(1)')dnl  # inner circles
  L1: circle diam m4diamL at ( 21.5/2,23.75)*sN m4EVs m4L1
  inLt = L1.rad/4/(1bp__)
  L1i: circle thick inLt rad L1.rad-(inLt+L1.thick)/2 bp__ outlined "yellow" \
    at L1 m4L1inner
  L2: circle diam m4diamL at (-21.5/2,23.75)*sN m4EVs m4L2
  L2i: circle thick inLt rad L2.rad-(inLt+L2.thick)/2 bp__ outlined "yellow" \
    at L2 m4L2inner
  Gnd: circle diam m4wdth/7 at (0,L1.y-15.92*sN) m4EVs m4Gnd
  Gndi: circle thick Gnd.rad/4/(1bp__) rad Gnd.rad-(Gnd.rad/4/(1bp__)+ \
    Gnd.thick)/2 bp__ outlined "green" at Gnd m4Gndinner
  PP: circle diam Gnd.diam/2 at (-17/2*sN,L1.y-16.52*sN) m4EVs m4PP
  CP: circle diam Gnd.diam/2 at ( 17/2*sN,L1.y-16.52*sN) m4EVs m4CP
  rs = (15^2+50^2)/(2*15)/4*sN; Cs: (0,0.3*m4wdth-rs) # inner tri-shape
  m = 9; n = 0; P[0]: Ct+(0,rt-tt)
  NAC_fillet(L2,L2.rad+tt,Ct,-(rt-tt),ri,FW,Fb,Ft)
  NAC_fillet(Cb,-(rb-tt),L2,L2.rad+tt,ri,GW,Gt,Gb)
  NAC_fillet(Cs,rs,Cb,-(rb-tt),ri,SW,St,Sb)
  NAC_arc(3,Ct,rt-tt,pi_/2,langle(Ct,Ft))
  NAC_arc(m,FW,ri,langle(FW,Ft),NAC_ang(FW,Fb))
  NAC_arc(m,L2,L2.rad+tt,langle(L2,Fb),langle(L2,Gb))
  NAC_arc(m,GW,ri,NAC_ang(GW,Gb),NAC_ang(GW,Gt))
  NAC_arc(m,Cb,rb-tt,NAC_ang(Cb,Gt),NAC_ang(Cb,Sb))
  NAC_arc(m,SW,ri,NAC_ang(SW,Sb),NAC_ang(SW,St))
  NAC_arc(m,Cs,rs,langle(Cs,St),pi_/2)
  fitcurve(P,n,fill_(1) m4inner,-n)
  popdef(`m4EVs',`m4CP',`m4PP',`m4Gnd',`m4inner',
   `m4L2',`m4L2inner',`m4L1',`m4L1inner',`m4Gndinner',
   `m4BG',`m4diamL',`m4wdth') `$2' ]')
  define(`NAC_fillet', #( C1, r1, C2, r2, frad, Cf, T1, T2 )
   ``$6': Cintersect(`$1',(abs(`$2')+sign(`$2')*(`$5')),
                     `$3',(abs(`$4')+sign(`$4')*(`$5')))
    `$7': LCintersect(,`$6',`$5',ifelse(index(`$2',-),0,R),`$1',`$6')
    `$8': LCintersect(,`$6',`$5',ifelse(index(`$4',-),0,R),`$3',`$6')')
  define(`NAC_arc', #( m, C, rad, a0, af )
   `m4a0 = `$4'; m4af = `$5'; for i=1 to `$1' do { n+=1
      P[n]: `$2'+(rect_(`$3',(1-i/`$1')*m4a0+i/`$1'*m4af))
      P[-n]: (-P[n].x,P[n].y) }')
  define(`NAC_ang',`pmod(langle(`$1',`$2'),twopi_)')

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
    foreach_(`L',`L=fill_(1);',N,S)
    FG=shaded "green";
    foreach_(`L',`L=shaded "orange";',SS1,DCP,NC,PP,CH,SS2,CL)) \
      with .w at P4.e+(P4.w.x-P3.e.x,0)
  foreach_(`L',`"EVsmall(L)" at P5.L EVk',FG,NC,DCP,SS1,PP,CL,CH,SS2)

P6: EV_NAC(wdth=1) with .w at P5.e+(P5.wid/5,0)
  foreach_(`L',`"EVtxt(`L'm4Lx)" at P6.L',L1,L2)
thinlines_
   arrow <- from P6.Gnd.s down P6.ht/5; "EVtxt(Gnd)" below
   arrow <- from P6.PP.sw down P6.ht/8 left P6.ht/8; "EVtxt(`PP')" rjust
   arrow <- from P6.CP.se down P6.ht/8 right P6.ht/8; "EVtxt(`CP')" ljust
thicklines_

   "EVtxt(`EV_CCS2')" at P4.s+(0,-10bp__)
   "EVtxt(`EV_NAC')" at (P6,last "")
   "EVtxt(`EV_CHAdeMO')" at (P5,last "")
   "EVtxt(`EV_CCS1')" at (P3,last "")
   "EVtxt(`EV_J3068')" at (P2,last "")
   "EVtxt(`EV_J1772')" at (P1,last "")
  ]

  iflatex(command "}%")
  ifsvg(command "</g>")
.PE
