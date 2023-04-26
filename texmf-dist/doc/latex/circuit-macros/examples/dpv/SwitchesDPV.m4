.PS
# SwitchesDPV.m4
cct_init(svg_font(sans-serif,11bp__,2bp__))
textoffset = 3bp__

movewid = 0.25

define(`Below',`at last [].s+(0,-(8 ifelse(`$1',,,+10*(`$1')))bp__)')
movewid = 0.25

# Row 1
  right_; {
    lswitch; {"svg_tt(`lswitch')" at last [].s Below}
    move right_
    lswitch(,,O); {"svg_tt(`(,,O)')" at last [].s Below}
    move right_
    lswitch(,,C); {"svg_tt(`(,,C)')" at last [].s Below}
    move right_
    lswitch(,,DA); {"svg_tt(`(,,DA)')" at last [].s Below}
    move right_
    lswitch(,,dDO); {"svg_tt(`(,,dDO)')" at last [].s Below}
    move right_
    lswitch(,,uDC); {"svg_tt(`(,,uDC)')" at last [].s Below}
    }
# Row 2
  move down 0.4; right_; {
    lswitch(,,K); {"svg_tt(`(,,K)')" at last [].s Below}
    move right_
    lswitch(,,KD); {"svg_tt(`(,,KD)')" at last [].s Below}
    move right_
    lswitch(,,KOD); {"svg_tt(`(,,KOD)')" at last [].s Below}
    move right_
    lswitch(,,KCD); {"svg_tt(`(,,KCD)')" at last [].s Below}
    move right_
    bswitch; {"svg_tt(``bswitch'')" at last [].s Below}
    move right_
    bswitch(,,C); {"svg_tt(`(,,C)')" at last [].s Below}
    }
# Row 3
  move down 0.45; right_; {
    D: dswitch; {"svg_tt(`dswitch')" at D.start below ljust}
    thinlines_
    {spline <- from last [].B.c up 0.1 then up 0.05 left 0.1
      "svg_tt(`B')" rjust}
    thicklines_
    move right_
    dswitch(,,WdBK); {"svg_tt(`(,,WdBK)')" at last [].s Below}
    thinlines_
    { spline <- from 0.5 along_(last [].B) up 0.1 then up 0.10 left 0.1
      {"svg_tt(`B')" rjust} }
    { spline <- from last [].K right 0.1 then right 0.05 up 0.15
      {"svg_tt(`K')" above }}
    thicklines_
    move right_
    dswitch(,,WBmdDK); {"svg_tt(`(,,WBmdDK)')" at last [].s Below}
    move right_
    dswitch(,,WBKTr); {"svg_tt(`(,,WBKTr)')" at last [].s Below}
    move right_
    dswitch(,,WdBL); {"svg_tt(`(,,WdBL)')" at last [].s Below}
    move right_
    dswitch(,,WBSd); {"svg_tt(`(,,WBSd)')" at last [].s Below}
    }
# Row 4
  move down 0.4; right_; {
    dswitch(,,WBCb); {"svg_tt(`(,,WBCb)')" at last [].s Below}
    move right_
    dswitch(,,WBcCb); {"svg_tt(`(,,WBcCb)')" at last [].s Below}
    move right_
    dswitch(,,WBcDI); {"svg_tt(`(,,WBcDI)')" at last [].s Below}
    thinlines_
    {arrow <- from last [].DI.start up_ 0.1 right_ 0.15; "svg_tt(`DI')" ljust}
    thicklines_
    move right_
#   dswitch(,,WBDI); {"svg_tt(`(,,WBDI)')" at last [].s Below}
    dswitch(,,WBKCo); {"svg_tt(`(,,WBKCo)')" at last [].s Below}
    move right_
    dswitch(,,WBFDI); {"svg_tt(`(,,WBFDI)')" at last [].s Below}
    move right_
    dswitch(,,WBFSd); {"svg_tt(`(,,WBFSd)')" at last [].s Below}
    }
# Row 5
  move down 0.4; right_; {
    dswitch(,,WBMMR); {"svg_tt(`(,,WBMMR)')" at last [].s Below}
    move right_
    dswitch(,,WBMM); {"svg_tt(`(,,WBMM)')" at last [].s Below}
    move right_
    dswitch(,,WBMR); {"svg_tt(`(,,WBMR)')" at last [].s Below}
    move right_
    dswitch(,,WBEL); {"svg_tt(`(,,WBEL)')" at last [].s Below}
    move right_
    dswitch(,,WBLE); {"svg_tt(`(,,WBLE)')" at last [].s Below}
    move right_
    dswitch(,,WBoKEL); {"svg_tt(`(,,WBoKEL)')" at last [].s Below}
    }
# Row 6
  move down moveht+2bp__; right_; {
    dswitch(,,WBTh); {"svg_tt(`(,,WBTh)')" at last [].s Below}
    move right_
    dswitch(,,WBKC); {"svg_tt(`(,,WBKC)')" at last [].s Below}
    thinlines_
    { arrow <- from last [].C.c left 0.2; "svg_tt(`C')" rjust }
    thicklines_
    move right_
    dswitch(,,WBM); {"svg_tt(`(,,WBM)')" at last [].s Below}
    move right_
    dswitch(,,WBCO); {"svg_tt(`(,,WBCO)')" at last [].s Below}
    move right_
    dswitch(,,WBMP); {"svg_tt(`(,,WBMP)')" at last [].s Below}
    move down_ 2bp__ then right_
    dswitch(,,WBoKCP); {"svg_tt(`(,,WBoKCP)')" at last [].s Below}
    }
# Row 7
  move down moveht*7/6; right_; {
    dswitch(,,WBCY); {"svg_tt(`(,,WBCY)')" at last [].s Below}
    move right_
    dswitch(,,WBCZ); {"svg_tt(`(,,WBCZ)')" at last [].s Below}
    move right_
    dswitch(,,WBCE); {"svg_tt(`(,,WBCE)')" at last [].s Below}
    move right_
    dswitch(,,WBRH); {"svg_tt(`(,,WBRH)')" at last [].s Below}
    move right_
    dswitch(,,WBRdH); {"svg_tt(`(,,WBRdH)')" at last [].s Below}
    move right_
    dswitch(,,WBRHH); {"svg_tt(`(,,WBRHH)')" at last [].s Below}
    }
# Row 8
  move down moveht; right_; {
    move down_ 2bp__; right_
    dswitch(,,WBPr); {"svg_tt(`(,,WBPr)')" at last [].s Below}
    move right_
    dswitch(,,WBPrT); {"svg_tt(`(,,WBPrT)')" at last [].s Below}
    move down_ 6bp__ then right_
    dswitch(,,WBPrM); {"svg_tt(`(,,WBPrM)')" at last [].s Below}
    move right_
    dswitch(,,WBDIGX,text=W); #{"svg_tt(`(,,WBDIGX,W)')" at last [].s Below}
      {"svg_tt(`(,,WBDIGX,')" ljust at last line.start+(0,-15bp__) \
        "svg_tt(`text=W)')" ljust}
    move right_
    dswitch(,,WBDIGC,text=M)
      {"svg_tt(`(,,WBDIGC,')" ljust at last line.start+(0,-15bp__) \
        "svg_tt(`text=M)')" ljust}
    move right_
    dswitch(,,WBcDIGC,text=M) #
      {"svg_tt(`(,,WBcDIGC,')" ljust at last line.start+(0,-15bp__) \
        "svg_tt(`text=M)')" ljust}
    }

 command "</g>')" # end font
.PE
