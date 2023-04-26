% SLDsMan.m4
define(`SLDheading',`
cct_init
include(libSLD.m4)
  mr = dimen_*6/5
  dv = 20bp__
  ds = dimen_/3
  movewid = 10bp__
  right_
')dnl
%
\global\newcommand{\SLDTransformers}{%
.PS
SLDheading
command "{\sf"
define(`Below',`ifelse(`$1',,below,`$1',0,below,`-(0,dv*(`$1'))')')
Transformers: [ setdir_(U)
  { Tr1: sl_transformer(,name=TR1,C,C)
     "sl\_transformer(,,C,C)" wid 97bp__ at Tr1.start Below(0) }
  { thinlines_
    arrow <- up_ dimen_/3 left_ dimen_/3 from BrO.nw; "\sl BrO" rjust
    arrow <- down_ dimen_/5 right_ dimen_*3/4 from BrI.e; BrIx: Here
    { "\sl BrI" below }
    thicklines_ }
  move right_ mr*3/2; up_
  { Tr2: sl_transformer(,type=S,O,O)
    ".{.}.(,type=S,O,O)" at Tr2.start Below(1) }
  { thinlines_
    arrow <- up_ dimen_*3/4 right_ dimen_*2/3 from 1/2 between TR1.ne and TR1.n
    { "\sl Body" above }
    arrow to Body.w
    arrow from BrIx to BrI.w
    arrow <- up_ dimen_*3/4 right_ dimen_/2 from Body.C2 chop Body.C2.rad chop 0
     { "\sl C2" above }
    arrow <- down_ dimen_*3/4 right_ dimen_/2 from Body.C1 chop Body.C1.rad \
     chop 0
     { "\sl C1" below }
    arrow <- right_ dimen_/2 from Body.M2; { "\sl M2" ljust }
    arrow <- right_ dimen_/2 from Body.M1; { "\sl M1" ljust }
    thicklines_ }

  move right_ mr*3/2; up_
  { TRF21: sl_transformer(, type=S,C,C,YN,YN)
     ".{.}.(,type=S,C,C,YN,YN)" wid 97bp__ at TRF21.start Below(0) }
  move right_ mr*3/2; up_
  { TRF22: sl_transformer(, type=S,X,/,Delta,Y)
     ".{.}.(,type=S,X,/,Delta,Y)" wid 97bp__ at TRF22.start Below(1) }
  move right_ mr*3/2; up_
  { TRF23: sl_transformer(,type=S,,,Y,Delta)
     ".{.}.(,type=S,{,},Y,Delta)" wid 97bp__ at TRF23.start Below(0) }
  move right_ mr*3/2; up_
  { TRF24: sl_transformer(, type=A,S,S3)
     ".{.}.(,type=A,S,S3)" wid 97bp__ at TRF24.start Below(1) }
  ]

command "}%"
.PE
}
\global\newcommand{\SLDTwoTerms}{%
.PS
SLDheading
command "{\sf"
TwoTerms: [
  { sl_ttbox(,,box=shaded "green",box=shaded "red") #; llabel(,"ttbox",,,Body)
    move; "sl\_ttbox(,,box=shaded \"green\",box=shaded \"red\")" ljust }
  move down; right_
  { sl_rectifier #; llabel(,"Re",,,Body)
    move right_
    sl_inverter #; llabel(,"Inv",,,Body)
    move; "sl\_rectifier, sl\_inverter" ljust }
  move down dimen_*5/6; right_
  { sl_breaker #; llabel(,"Br")
    move right 10bp__
    sl_breaker(,type=C;name=C) #; llabel(,"C")
    move right 10bp__
    sl_breaker(,type=D;name=B3) ;llabel(,"\sl D",,,B3)
    move; `"sl\_breaker, sl\_breaker(,type=C)"' ljust \
       `"sl\_breaker(,type=D;name=B3) ; llabel(,\"D\",{,},B3)"' ljust }
  move down dimen_*2/3; right_
  { R: sl_reactor(,,C,C) #; llabel(,"\sl R",,,Body)
    move; "sl\_reactor(,,C,C)" ljust }
  move right_ dimen_*6; right_
  { sl_drawout #; llabel(,"\sl Dr")
    move; "sl\_drawout" ljust }
  ] #with .nw at Transformers.sw + (0,-dimen_)

command "}%"
.PE
}
\global\newcommand{\SLDOneTerms}{%
.PS
SLDheading
command "{\sf"
define(`Below',`ifelse(`$1',,below,`$1',0,below,`-(0,dv*(`$1'))')')

OneTerms: [
define(`dimen_',dimen_*1.2)
  up_
  D: sl_disk
  {"sl\_disk" at D.s Below(0) }
  move right_ mr; up_
  B: sl_box(,,C); Bre: Br.e; {"sl\_box(,,C)" at B.s Below(1)
    thinlines_
    arrow <- from last circle.se down dimen_/4 right dimen_/4
    { "\sl Head" Below(0) }
    { M1: move from Head.sw to Head.nw }
    { M2: move to Head }
    arrow to Intersect_(M1,M2)
    thicklines_
    }
  move right_ mr; up_
  G: sl_grid(,,X) ; {"sl\_grid(,,X)" at G.s Below(0)}
  { thinlines_
    Brc: 1/2 between Bre and Br.w
    arrow <- from Bre to Brc+(0,-dimen_/4); { "\sl Br" below }
    arrow to Br.w
    thicklines_ } 
  move right_ mr; up_
  L: sl_load(,,O) ; {"sl\_load(,,O)" at L.s Below(1) }
  move right_ mr; up_
  M: sl_meterbox ; {"sl\_meterbox" at M.s Below(0)}
  move right_ mr; up_
  S: sl_syncmeter ; {"sl\_syncmeter" at S.s Below(1)}
  move right_ mr; up_
  P: sl_lamp ; {"sl\_lamp" at P.s Below(0) }
  ] #with .nw at TwoTerms.sw + (0,-dimen_*2/3)

command "}%"
.PE
}
\global\newcommand{\SLDGenerators}{%
.PS
SLDheading
command "{\sf"
define(`Below',`ifelse(`$1',,below,`$1',0,below,`-(0,dv*(`$1'))')')

Generators:[
  up_
  GEN0: sl_generator ; {"sl\_generator" at GEN0.s Below(0)}
  move right_ mr; up_
  GEN1: sl_generator(,type=WT); {".{.}.(,type=WT)" at GEN1.s Below(1)}
  move right_ mr; up_
  GEN2: sl_generator(, type=BS); {".{.}.(,type=BS)" at GEN2.s Below(0)}
  move right_ mr; up_
  GEN3: sl_generator(, type=PV); {".{.}.(,type=PV)" at GEN3.s Below(1)}
  move right_ mr; up_
  GEN4: sl_generator(, type=StatG); {".{.}.(,type=StatG)" at GEN4.s Below(0)}
  move right_ mr; up_
  GEN4: sl_generator(, type=Y); {".{.}.(,type=Y)" at GEN4.s Below(1)}
  { thinlines_
    arrow <- from Head_Y.N down_ dimen_/2 right_ dimen_*0.6
    "\sl Head\_Y.N" below
    thicklines_ }
  move right_ mr; up_
  GEN4: sl_generator(, type=Delta); {".{.}.(,type=Delta)" at GEN4.s Below(0)}
  move right_ mr; up_
  GEN5: sl_disk(, text="SG"); {"sl\_disk(,text=\"SG\")" at GEN5.s Below(1)}
  ] #with .nw at OneTerms.sw + (0,-dimen_*2/3)

command "}%"
.PE
}
\global\newcommand{\SLDComposite}{%
.PS
SLDheading
command "{\sf"

Composite: [
ifelse(1,1,`
  Ref: line right_ 1.5 cm__
  CTL: sl_ct at last line.c
    CTLt: "sl\_ct" at CTL.Tc+(0,-30bp__)
  thinlines_
    arrow <- from CTL.Tstart down 10bp__ left_ 7bp__; "\sl Tstart" below rjust
    arrow <- from CTL.Tend down 10bp__ right_ 7bp__; "\sl Tend" below ljust
    arrow <- from CTL.Tc down 10bp__ right_ 2bp__ ; "\sl Tc" below
  thicklines_
  CTC: sl_transformer3(,type=C) with .Tstart at Ref.end+(3/2*dimen_,0) 
    "sl\_transformer3(," ljust at (CTC.Tstart-(12bp__,0),CTLt) \
    "type=C)" ljust
  thinlines_
    arrow <- from CTC.Tstart down 10bp__ left 7bp__; "\sl Tstart" below rjust
    arrow <- from CTC.Tend down 10bp__ right 7bp__; "\sl Tend" below ljust
    "\sl Tc" at CTC.Tc ljust
  thicklines_
  BB: sl_busbar(right_ 3*dimen_,4,port=D) with .Start at Ref.start+(0,-dimen_*2)
    "sl\_busbar(right\_ 3{\tt*}dimen\_,4,port=D)" ljust at BB.Start+(0,-15bp__)
    thinlines_
    arrow up ds right ds/2 <- from BB.P1.ne chop dotrad_; "\sl P1" ljust
    arrow up ds right ds/2 <- from BB.P2.ne chop dotrad_; "\sl P2" ljust
    arrow up ds right ds/2 <- from BB.P3.ne chop dotrad_; "\sl P3" ljust
    arrow up ds right ds/2 <- from BB.P4.ne chop dotrad_; "\sl P4" ljust
    spline <- from BB.End right ds then up ds right ds/2; "\sl End" above
    spline <- from BB.Start up ds/2 then up ds right ds/2; "\sl Start" above
    thicklines_
  Tr3: sl_transformer3(,,,Y:Y:Delta) with .Tc at CTC.ne + (dimen_*2,0)
    {"sl\_transformer3(," ljust at Tr3.sw+(0,-25bp__) "Y:Y:Delta)" ljust}
')
  Tr32: sl_transformer3(,direct=R,C:C:box=shaded "green",Y:Y:Delta) \
    with .Tstart at Tr3.Tc + (dimen_,0)
    "sl\_transformer3(," ljust at Tr32.sw+(15bp__,-25bp__) \
    "direct=R,C:C:box=shaded \"green\"," ljust \
    "Y:Y:Delta)" ljust
    "\sl Tstart" at Tr32.Tstart+(0,-4bp__) below
    "\sl Tend" at Tr32.Tend+(0,-4bp__) below
    "\sl Tc" at Tr32.Tc ljust
    "\sl BrI" at Tr32.BrI.n above
    "\sl BrO" at Tr32.BrO.n above
    "\sl Br" at Tr32.Br.w rjust
#   "\sl C1" at Tr32.Body.C1.nw rjust
#   "\sl C2" at Tr32.Body.C2.ne ljust
#   "\sl C3" at Tr32.C3.se ljust
  ] #with .nw at Generators.sw+(0,-dimen_/2)

command "}%"
.PE
}
%\iffalse
%\SLDTransformers
%\par \vspace*{\baselineskip}
%\SLDGenerators
%\par \vspace*{\baselineskip}
%\SLDTwoTerms
%\par
%\SLDOneTerms
%\par \vspace*{\baselineskip}
%\fi
%\SLDComposite
