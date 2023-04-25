.PS
# keyboardSVG.m4
  gen_init
  scale=25.4 # unit is mm

divert(-1)

define(`kbd_u',(11mm__))
define(`kbdrowsep',`movewid')
define(`kbdshadewid',`(kbd_u/9)')

                            `kbdkey(name|text=chars,keys)
                             chars: string or string string
                             keys: wdth=expr;  # base wid
                                   hght=expr;  # base ht
                                   rad=expr; # base rad
                                   shadewid=expr; # base shade wid
                                   base=attribs; # base attributes
                                   top=attribs;  # top attributes '
define(`kbdkey',
 `pushkeys_(`$2',
    wdth:kbd_u; hght:kbd_u*14/13+lthick; rad:kbd_u/10;
    shadewid:kbdshadewid; base:fill_(0.3):N; top:fill_(0.9):N)dnl
  [ Base: box wid m4wdth ht m4hght rad m4rad m4base 
    Top:  box wid m4wdth-2*m4shadewid ht m4hght-m4shadewid-lthick \
      rad m4rad*(kbd_u-2*m4shadewid)/(kbd_u) with .n \
      at Base.n-(0,lthick) m4top 
    move to Top.w
    ifelse(`$1',,,`pushkey_(`$1',text,,N)ifelse(m4text,,
     `"iflatex(\sf) `$1'" above ljust',
     `m4text');') `$3'
    popdef(`m4wdth', `m4hght', `m4shadewid', `m4rad', `m4base', `m4top') dnl
    popdef(`m4text') ] ')

define(`tsmall',
 `iflatex(`"{\sf\scriptsize `$1'}"',
  ifelse(`$3',,")svg_fsize(`$1',ifelse(`$2',,75,`$2'))ifelse(`$3',,"))')

define(`stkbdkey',
 `iflatex(`command "{\sf\scriptsize"',`m4tmp=textht
   textht = ifelse(`$1',,0.66*textht,`$1') ')
  kbdkey(shift($*))
  iflatex(`command "}%"',`textht = m4tmp')')

                            `enterkey(name|text=chars,keys)
                             chars: string or string string
                             keys: wdth=expr;  # base wid
                                   hght=expr;  # base ht
                                   bhght=expr;  # ht of bottom part
                                   rad=expr; # base rad
                                   shadewid=expr; # base shade wid
                                   base=attribs; # base attributes
                                   top=attribs;  # top attributes '
define(`enterkey',
 `pushkeys_(`$2',
    wdth:kbd_u*2.26;
    hght:kbd_u*14/13*2+kbdrowsep+linethick bp__;
    bhght: kbd_u*14/13;
    twdth: kbd_u*3/2;
    rad:kbd_u/10;
    shadewid:kbdshadewid;
    base:fill_(0.3):N;
    top:fill_(0.9):N)dnl
  [ ltx = lthick; r = m4rad*(kbd_u-2*m4shadewid)/(kbd_u)
# thick outer
    linethick = (m4shadewid+r)/(1bp__); lth2 = lthick/2
    NEx: Here; NE: NEx-(lth2,lth2); SE: NE-(0,m4hght-lth2*3-ltx*3/2)
    SW: SE-(m4wdth-lthick,0)
    W: SW+(0,m4bhght-lthick+ltx*3/2); NW: NE-(m4twdth-lthick,0); X: (NW,W)
    d = 0.3; ro = m4rad-lth2
    move to W; arcto(X,NW,m4rad+lth2,outlined graystring(d)); Tx:NW
    Loopover_(`PK',`arcto(Tx,PK,ro,outlined graystring(d));Tx:PK',NE,SE,SW,W,X)
    linethick = ltx
# outer outline
    NE: NEx; SE: NE-(0,m4hght+ltx); SW: SE-(m4wdth,0)
    W: SW+(0,m4bhght); NW: NE-(m4twdth,0); X: (NW,W)
    m4enteroutline(m4rad,,m4rad)
# thick inner
    linethick = m4shadewid/(1bp__)+linethick; lth2 = lthick/2
    NE: NEx-(m4shadewid+lth2,lth2+ltx); SE: (NE,SE)+(0,m4shadewid*3/2)
    SW: SE-(m4wdth-m4shadewid*3,0); W: SW+(0,m4bhght-m4shadewid*2-ltx*3/2);
    NW: NE-(m4twdth-m4shadewid*3,0); X: (NW,W)
    c = 0.9; ri = r-lth2
    move to W; arcto(X,NW,ri+lth2*2,outlined graystring(c)); Tx:NW
    Loopover_(`PK',`arcto(Tx,PK,ri,outlined graystring(c));Tx:PK',NE,SE,SW,W,X)
    N: 1/2 between NW and NE
    line from N to (N,SE) thick (NE.x-NW.x)/(1bp__) outlined graystring(c)
    SSW: 1/2 between SW and W
    line from SSW to (SE,SSW) thick (W.y-SW.y)/(1bp__) outlined graystring(c)
# inner outline
    NE: NE+(lth2,lth2); SE: SE+(lth2,-lth2); SW: SW-(lth2,lth2)
    W: W+(-lth2,lth2); NW: NW+(-lth2,lth2); X: (NW,W)
    linethick = ltx
    m4enteroutline(ri,,ri+lth2*2)
    move to (X,(1/2 between SW and W));
    ifelse(`$1',,,`pushkey_(`$1',text,,N)dnl
      ifelse(m4text,,`"iflatex(\sf) `$1'" above ljust',`m4text')')
    popdef(`m4wdth', `m4hght', `m4bhght', `m4twdth', `m4shadewid', `m4rad',
     `m4base', `m4top', `m4bhght' ) popdef(`m4text')dnl
    `$3' ] ')
define(`m4enteroutline',`move to W+(`$1',0); arcto(X,NW,`$3',`$2'); Tx: NW 
  Loopover_(`PP',`arcto(Tx,PP,`$1',`$2'); Tx: PP',NE,SE,SW,W,X)')
define(`m4enterup',`[ u = ifelse(`$1',,kbd_u*0.3)
  line right u/4 then up u/2 then right u/6 then up u/2 left u/4+u/6 \
  then down u/2 left u/4+u/6 then right u/6 then down u/2 then right u/4 
  ]')

define(`kbdsymb',`iflatex("\tt\char`$1'",`dsvg_symb(`$1')')')
define(`m4kbdarrow',`arrow thick 1.5 ht kbd_u/5 wid kbd_u/5')

divert(0)dnl

define dsvg_symb {"&#$1;"}

maxpswid = 25*kbd_u
movewid = kbd_u/11

define(`rshift',` at Here+(ifelse(`$1',,`kbd_u/8',`$1'),0) ')

iflatex(`command "{\small\sf"',
 `ifsvg(svg_font(Arial,kbd_u*16/13/4,0bp__))
  textht=kbd_u/4 ')
   
Row2: [
  textoffset = kbd_u/8
  Loopover_(`KK',`kbdkey(text=KK); move',
    kbdsymb(126) ljust kbdsymb(96) ljust,
    Loopover_(`NN',`kbdsymb(NN) ljust "m4Lx" ljust,',33,64,35,36,37,94,38,42,40)
    kbdsymb(41) ljust "0" ljust,
    kbdsymb(95) ljust "-" ljust,
    kbdsymb(43) ljust "=" ljust,
    kbdsymb(124) ljust kbdsymb(92) ljust,
    "" )
    m4kbdarrow left kbd_u*0.5 at last [].Top
    ]
Row1: [
  kbdkey(tsmall(Esc,,N)); move right_ last [].wid+movewid*2
  Loopover_(`KK',`kbdkey(KK); move',F1,F2,F3,F4)
  move right_ last [].wid/2
  Loopover_(`KK',`kbdkey(KK); move',F5,F6,F7,F8)
  move right_ Row2.wid-Here.x-4*last [].wid-4*movewid
  Loopover_(`KK',`kbdkey(KK); move',F9,F10,F11,F12)
  ] with .sw at Row2.nw+(0,2*kbdrowsep)
Row3: [
# Uparrow: kbdkey(,,m4kbdarrow up kbd_u/2 at Top)
  Tab: kbdkey(text=tsmall(Tab) rshift ljust,wdth=kbd_u*1.6,
   [ A: m4kbdarrow left kbd_u/2; line thick A.thick up A.wid at A.end
     A: m4kbdarrow right A.len at A-(0,kbd_u/2)
     line thick A.thick up A.wid at A.end ] with .w at Top ); move
  Loopover_(`KK',`KK: kbdkey(KK); move',Q,W,E,R,T,Y,U,I,O,P)
  textoffset = kbd_u/8
  kbdkey(text=kbdsymb(123) ljust kbdsymb(91) ljust); move
  kbdkey(text=kbdsymb(125) ljust kbdsymb(93) ljust); move
  w = Row2.wid-Here.x
  R: box invis wid w-movewid ht last [].Base.ht 
  ] with .nw at Row2.sw-(0,kbdrowsep)
Row4: [
  Capslock: kbdkey(text=tsmall(Caps Lock) rshift ljust,
   wdth=Row3.Tab.wid+Row3.Q.wid/3;); move
  Loopover_(`KK',`KK: kbdkey(KK); move',A,S,D,F,G,H,J,K,L)
  textoffset = kbd_u/8
  kbdkey(text=kbdsymb(58) ljust kbdsymb(59) ljust); move
  kbdkey(text=kbdsymb(34) ljust kbdsymb(39) ljust); move
  ] with .nw at Row3.sw-(0,kbdrowsep)
  Enter: enterkey(text=tsmall(Enter),,
    m4kbdarrow <- from last ""+(kbd_u/2,0) \
      right kbd_u/2 then up kbd_u/5 ) \
    with .ne at (Row2.e,Row3.n)-(movewid,0)
Row5: [
  ShiftL: kbdkey(text=tsmall(Shift) at 0.4 between Top.w and Top.e,
    wdth=kbd_u*2.4, m4enterup at 0.15 between Top.w and Top.e); move
  Loopover_(`KK',`KK: kbdkey(KK); move',Z,X,C,V,B,N,M)
  textoffset = kbd_u/8
  kbdkey(text=kbdsymb(60) ljust kbdsymb(44) ljust); move
  kbdkey(text=kbdsymb(62) ljust kbdsymb(46) ljust); move
  kbdkey(text=kbdsymb(63) ljust kbdsymb(47) ljust); move
  v = Row2.wid-Here.x-kbd_u-movewid*2
  ShiftR: kbdkey(text=tsmall(Shift) at 1/2 between Top.w and Top.e,wdth=v,
    m4enterup at 0.15 between Top.w and Top.e); move
  kbdkey(); move
  ] with .nw at Row4.sw+(0,-kbdrowsep)
Row6: [
  w = 22/18*kbd_u
  CtrlL: kbdkey(text=tsmall(Ctrl) rshift ljust,wdth=w); move
  kbdkey(,wdth=w); move
  kbdkey(text=tsmall(Alt) rshift ljust,wdth=w); move
  s = Row2.wid-(7*w+8*movewid)
  kbdkey(,wdth=s); move
  kbdkey(text=tsmall(Alt) rshift ljust,wdth=w); move
  kbdkey(,wdth=w); move
  kbdkey(,wdth=w); move
  CtrlR: kbdkey(text=tsmall(Ctrl) rshift ljust,wdth=w); move
  ] with .nw at Row5.sw+(0,-kbdrowsep)
Arrowkeys: [ iflatex(`command "{\sf\scriptsize"',`textht *=0.66')
Row1:[ textoffset = kbd_u/20
  kbdkey(text=`"Print" ljust "Screen" ljust "SysRQ" ljust'); move
  textoffset = kbd_u/12
  kbdkey(text="Scroll" ljust "Lock" ljust); move
  kbdkey(text="Pause" ljust "Break" ljust); move
  ]
Row2: [ textoffset = kbd_u/12
  kbdkey(text="Insert" ljust); move
  kbdkey(text=tsmall(Home) ljust); move
  kbdkey(text="Page" ljust "Up" ljust); move
  ] with .nw at Row1.sw-(0,2*kbdrowsep)
Row3: [ textoffset = kbd_u/12
  Delete: kbdkey(text="Delete" ljust); move
  End: kbdkey(text="End" ljust); move
  kbdkey(text="Page" ljust "Down" ljust); move
  ] with .nw at Row2.sw+(0,-kbdrowsep)
Row5: [
  move right Row3.End.w.x + movewid
  Uparrow: kbdkey(,,m4kbdarrow up kbd_u/2 at Top)
  ] with .nw at Row3.sw-(0,Row3.Delete.ht+2*kbdrowsep)
Row6: [
  kbdkey(,,m4kbdarrow left kbd_u/2 at Top); move
  kbdkey(,,m4kbdarrow down kbd_u/2 at Top); move
  kbdkey(,,m4kbdarrow right kbd_u/2 at Top); move
  ] with .nw at Row5.sw-(0,kbdrowsep)

  iflatex(`command "}%"',`textht *=(1/0.66)')
  ] with .nw at Row1.ne+(movewid,0)
Keypad: [ move down_ Arrowkeys.n.y-Arrowkeys.Row2.e.y; right_
  textoffset = kbd_u/8
Row2:[
  kbdkey(text=tsmall(Num) ljust tsmall(Lock) ljust); move
  iflatex(`command "{\large"',`textht *=1.5')
  kbdkey(text=kbdsymb(47) ljust); move
  kbdkey(text=kbdsymb(42) ljust); move
  kbdkey(text=kbdsymb(45) ljust); move
  iflatex(`command "}"')
  ]
Row3:[ textoffset = kbd_u/12
  kbdkey(text="7" ljust tsmall(Home) ljust); move
  kbdkey(text="8" ljust "" ljust,,m4kbdarrow up_ kbd_u/3 \
   at 3/4 between Top.ne and Top.sw); move
  kbdkey(text="9" ljust tsmall(PgUp) ljust); move
  ] with .nw at Row2.sw+(0,-kbdrowsep)
Row4:[ textoffset = kbd_u/12
  kbdkey(text="4" ljust "" ljust,,m4kbdarrow left kbd_u/3 \
   at 0.7 between Top.ne and Top.sw); move
  kbdkey(text="5" ljust "" ljust); move
  Six: kbdkey(text="6" ljust "" ljust,,m4kbdarrow right kbd_u/3 \
   at 0.7 between Top.ne and Top.sw); move
  ] with .nw at Row3.sw+(0,-kbdrowsep)
Row5:[ textoffset = kbd_u/12
  kbdkey(text="1" ljust tsmall(End) ljust); move
  kbdkey(text="2" ljust "" ljust,,m4kbdarrow down kbd_u/3 \
   at 0.7 between Top.ne and Top.sw); move
  kbdkey(text="3" ljust tsmall(PgDn) ljust); move
  ] with .nw at Row4.sw+(0,-kbdrowsep)
Row6:[ textoffset = kbd_u/12
  kbdkey(text="0" ljust tsmall(Ins) ljust,
    wdth=Row4.wid-Row4.Six.wid-2*movewid); move
  kbdkey(text=kbdsymb(46) ljust tsmall(Del) ljust); move
  ] with .nw at Row5.sw+(0,-kbdrowsep)
Col4: [ textoffset = kbd_u/12
  iflatex(`command "{\large"',`textht *=1.5')
  kbdkey(text="+" ljust,hght=Row3.n.y-Row4.s.y); move
  iflatex(`command "}"',`textht /=1.5')
  kbdkey(text=tsmall(Enter) ljust,hght=Row5.n.y-Row6.s.y) \
    with .nw at last [].sw - (0,kbdrowsep)
  ] with .ne at (Row2.e,Row3.n)

  ] with .nw at Arrowkeys.ne+(movewid,0)

iflatex(`command "}%"',
ifsvg(`command "</g>"'))
.PE
