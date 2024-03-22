.PS
# Switches.m4
cct_init

define(`Below',`at last [].s+(0,-(8 ifelse(`$1',,,+10*(`$1')))bp__)')

movewid = 0.25

# Row 1
  right_; {
    lswitch; {"\tt ls{}witch" at last [].s Below}
    move right_
    lswitch(,,O); {"\tt (,{,}O)" at last [].s Below}
    move right_
    lswitch(,,C); {"\tt (,{,}C)" at last [].s Below}
    move right_
    lswitch(,,DA); {"\tt (,{,}DA)" at last [].s Below}
    move right_
    lswitch(,,dDO); {"\tt (,{,}dDO)" at last [].s Below}
    move right_
    lswitch(,,uDC); {"\tt (,{,}uDC)" at last [].s Below}
    }
# Row 2
  move down 0.4; right_; {
    lswitch(,,K); {"\tt (,{,}K)" at last [].s Below}
    move right_
    lswitch(,,KD); {"\tt (,{,}KD)" at last [].s Below}
    move right_
    lswitch(,,KOD); {"\tt (,{,}KOD)" at last [].s Below}
    move right_
    lswitch(,,KCD); {"\tt (,{,}KCD)" at last [].s Below}
    move right_
    bswitch; {"\tt `bswitch'" at last [].s Below}
    move right_
    bswitch(,,C); {"\tt (,{,}C)" at last [].s Below}
    }
# Row 3
  move down 0.45; right_; {
    D: dswitch(,,); {"\tt ds{}witch(,{},)" at last [].s Below}
    thinlines_
    {spline <- from last [].B.c up 0.1 then up 0.05 left 0.1; "\tt B" rjust}
    thicklines_
    move right_
    dswitch(,,WdBK); {"\tt (,{,}WdBK)" at last [].s Below}
    thinlines_
    { spline <- from 0.5 along_(last [].B) up 0.1 then up 0.10 left 0.1
      {"\tt B" rjust} }
    { spline <- from last [].K right 0.1 then right 0.05 up 0.15
      {"\tt K" above }}
    thicklines_
    move right_
    dswitch(,,WBmdDK); {"\tt (,{,}WBmdDK)" at last [].s Below}
    move right_
    dswitch(,,WBKTr); {"\tt (,{,}WBKTr)" at last [].s Below}
    move right_
    dswitch(,,WdBL); {"\tt (,{,}WdBL)" at last [].s Below}
    move right_
    dswitch(,,WBSd); {"\tt (,{,}WBSd)" at last [].s Below}
    }
# Row 4
  move down 0.4; right_; {
    dswitch(,,WBCb); {"\tt (,{,}WBCb)" at last [].s Below}
    move right_
    dswitch(,,WBcCb); {"\tt (,{,}WBcCb)" wid 50bp__ at last [].s Below}
    move right_
    dswitch(,,WBcDI); {"\tt (,{,}WBcDI)" at last [].s Below}
    thinlines_
    {arrow <- from last [].DI.start up_ 0.1 right_ 0.15; "\tt DI" ljust}
    thicklines_
    move right_
#   dswitch(,,WBDI); {"\tt (,{,}WBDI)" at last [].s Below}
    dswitch(,,WBKCo); {"\tt (,{,}WBKCo)" at last [].s Below}
    move right_
    dswitch(,,WBFDI); {"\tt (,{,}WBFDI)" at last [].s Below}
    move right_
    dswitch(,,WBFSd); {"\tt (,{,}WBFSd)" at last [].s Below}
    }
# Row 5
  move down 0.4; right_; {
    dswitch(,,WBMMR); {"\tt (,{,}WBMMR)" at last [].s Below}
    move right_
    dswitch(,,WBMM); {"\tt (,{,}WBMM)" at last [].s Below}
    move right_
    dswitch(,,WBMR); {"\tt (,{,}WBMR)" at last [].s Below}
    move right_
    dswitch(,,WBEL); {"\tt (,{,}WBEL)" at last [].s Below}
    move right_
    dswitch(,,WBLE); {"\tt (,{,}WBLE)" at last [].s Below}
    move right_
    dswitch(,,WBoKEL); {"\tt (,{,}WBoKEL)" at last [].s Below}
    }
# Row 6
  move down moveht+2bp__; right_; {
    dswitch(,,WBTh); {"\tt (,{,}WBTh)" at last [].s Below}
    move right_
    dswitch(,,WBKC); {"\tt (,{,}WBKC)" at last [].s Below}
    thinlines_
    { arrow <- from last [].C.c left 0.2; "\tt C" rjust }
    thicklines_
    move right_
    dswitch(,,WBM); {"\tt (,{,}WBM)" at last [].s Below}
    move right_
    dswitch(,,WBCO); {"\tt (,{,}WBCO)" at last [].s Below}
    move right_
    dswitch(,,WBMP); {"\tt (,{,}WBMP)" at last [].s Below}
    move down_ 2bp__ then right_
    dswitch(,,WBoKCP); {"\tt (,{,}WBoKCP)" at last [].s Below}
    }
# Row 7
  move down moveht*7/6; right_; {
    dswitch(,,WBCY); {"\tt (,{,}WBCY)" at last [].s Below}
    move right_
    dswitch(,,WBCZ); {"\tt (,{,}WBCZ)" at last [].s Below}
    move right_
    dswitch(,,WBCE); {"\tt (,{,}WBCE)" at last [].s Below}
    move right_
    dswitch(,,WBRH); {"\tt (,{,}WBRH)" at last [].s Below}
    move right_
    dswitch(,,WBRdH); {"\tt (,{,}WBRdH)" at last [].s Below}
    move right_
    dswitch(,,WBRHH); {"\tt (,{,}WBRHH)" at last [].s Below}
    }
# Row 8
  move down moveht; right_; {
    move down_ 2bp__; right_
    dswitch(,,WBPr); {"\tt (,{,}WBPr)" at last [].s Below}
    move right_
    dswitch(,,WBPrT); {"\tt (,{,}WBPrT)" at last [].s Below}
    move down_ 6bp__ then right_
    dswitch(,,WBPrM); {"\tt (,{,}WBPrM)" at last [].s Below}
    move right_
    dswitch(,,WBDIGX,text=W)
      {"\tt (,{,}WBDIGX," ljust at last line.start+(0,-15bp__) \
        "\tt text=W)" ljust}
    move right_
    dswitch(,,WBDIGC,circle="M")
      {"\tt (,{,}WBDIGC," ljust at last line.start+(0,-15bp__) \
        "\tt circle=\"M\")" ljust}
    move right_
    dswitch(,,WBcDIGC,circle="M")
      {"\tt (,{,}WBcDIGC," ljust at last line.start+(0,-15bp__) \
        "\tt circle=\"M\")" ljust}
    }

.PE
