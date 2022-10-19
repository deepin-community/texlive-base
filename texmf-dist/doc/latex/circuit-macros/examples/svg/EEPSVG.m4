.PS
# EEPSVG.m4
# https://electrical-engineering-portal.com/single-line-diagrams-symbols-drawings-analysis

cct_init
divert(-1)

# This section defines *DRAFT* SLD elements with or without attached
# circuit breakers.  Many other elements applicable to SLD drawings are
# already in libcct.m4.  The contributions and suggestions of Benjamin
# Vilmann are acknowledged with thanks.

# 1-terminal SLD elements:
# Argument 1 is normally the linespec of the stem to set the element direction
#   and length. See also: PtoL defined below.
# For a 0-length stem (which has undefined direction):
#   arg1 can also be U, D, L, R (for up, down, left, right),
#   or a number to set the direction in degrees, optionally followed by
#   `at position' to set the position (Here by default).
#   Zero-length stem examples: sl_box(U), sl_box(45 at Here+(1,0))
# Argument 2 contains semicolon (;)-separated key-value attributes
#   of the element head as applicable: e.g., name=Name; text="text"; lgth=expr 
# A non-blank argument 3 is C for a default closed breaker in the stem, O for
#   an open breaker, or key-value pairs to specify breaker details.
# The element body (head) can be named. It is overlaid with or contained in
#   a [] block.

# 2-terminal SLD elements:
# These obey the normal Circuit_macro two-terminal conventions.
# They can be labelled using rlabel() or llabel() as well as directly.
# Argument 2 contains key-value pairs to customize the element body,
#   e.g., name=Name; text="text"; wdth=expr; ...
# Nonblank arguments 3 and 4 put a breaker in the input and output respectively.

# Attached breakers:
# Nonblank arguments 3 and 4 of the two-terminal elements and argument 3 of
#   the 1-terminal elements specify a breaker in the input, output, and stem
#   respectivlely. An O creates a default-size open breaker, and C a closed
#   breaker, otherwise the argument contains key-value pairs to specify the
#   details of the box; e.g., box=dotted 2bp__ shaded "green"

# The SLD current transformer macro sl_ct is composite, within a [] block.
# Internal labels L (for inductor) and terminals Ts, Tc, and Te are defined.

define(`sldlib_')
ifdef(`libcct_',,`include(libcct.m4)divert(-1)')

# Default size parameters.  These can be redefined in a diagram.

define(`brksiz_',`dimen_*3/16')   # Default inline box breaker size
define(`drosiz_',`dimen_/4')      # Default sl_drawout (chevron) size

# One-terminal elements ###################################################

                            `sl_disk( stem linespec, keys, breaker )
                                 keys: name=Name;
                                       text="text";
                                       diam=expr;
                                       circle=circle attributes; eg diam expr'
                                `default breaker name Bd'
define(`sl_disk',
 `sl_eleminit_(`$1')
  setkeys_(`$2',`name::N; circle::N; text::N; diam:dimen_*2/3')dnl
  ifelse(`$3',,
   `ifelse(m4name,,,m4name:) circle diam m4diam \
      at last line.end + vec_(m4diam/2,0) m4circle m4text
    [ box invis wid_ m4diam ht_ m4diam ] at last circle
    line from last line.end  to last line.start',
   `m4br_one(`sl_disk',`$1',`$2',m4brk_(`$3',Bd))') ')

                            `sl_box( stem linespec, keys, breaker )
                                 keys: name=Name; lgth=expr; wdth=expr;
                                       text="text";
                                       box= box attributes; (e.g. shade "red")'
                                `default breaker name Bb'
define(`sl_box',
 `sl_eleminit_(`$1')
  setkeys_(`$2',`name::N; wdth:dimen_*2/3; lgth:dimen_*2/3; box::N; text::N')dnl
  ifelse(`$3',,
   `line from last line.end to last line.start 
    { ifelse(m4name,,,m4name:) [S:Here; lbox(m4lgth,m4wdth,m4box)] \
        with .S at last line.start }
    ifelse(m4text,,,`{m4text at last []}')',
   `m4br_one(`sl_box',`$1',`$2',m4brk_(`$3',Bb))') ')

                            `sl_grid( stem linespec, keys, breaker )
                                 keys: name=Name; lgth=expr; wdth=expr;'
                                `default breaker name Bgr'
define(`sl_grid',
 `sl_eleminit_(`$1')
  setkeys_(`$2',`name::N; wdth:dimen_*4/5; lgth:dimen_*2/3; box::N; text::N')dnl
  ifelse(`$3',,
   `line from last line.end to last line.start 
    { ifelse(m4name,,,m4name:) [S:Here
      { ifelse(m4name,,,m4name:) lbox(m4lgth,m4wdth) }
      { line to rvec_(m4lgth/2, m4wdth/2)
        line to rvec_(m4lgth/2,-m4wdth/2)
        line to rvec_(-m4lgth/2,-m4wdth/2)
        line to rvec_(-m4wdth/2, m4wdth/2) }
      { line from rvec_(0,m4wdth/2) to rvec_(m4lgth,-m4wdth/2) }
      line from rvec_(0,-m4wdth/2) to rvec_(m4lgth,m4wdth/2)
      ] with .S at last line.start } ',
   `m4br_one(`sl_grid',`$1',`$2',m4brk_(`$3',Bgr))') ')

                            `sl_load( stem linespec, keys, breaker )
                                 keys: name=Name; lgth=expr; wdth=expr;
                                       head= arrowhead attributes;'
                                `default breaker name Bl'
define(`sl_load',
 `sl_eleminit_(`$1')
  setkeys_(`$2',`name::N; wdth:dimen_*0.32; lgth:dimen_*0.45; head::N')dnl
  ifelse(`$3',,
   `line from last line.end to last line.start 
    { ifelse(m4name,,,m4name:) [S:Here; line to rvec_(0,m4wdth/2) \
        then to rvec_(m4lgth,0) then to rvec_(0,-m4wdth/2) \
        then to Here m4head ] with .S at last line.start } ',
   `m4br_one(`sl_load',`$1',`$2',m4brk_(`$3',Bl))') ')

                            `sl_meterbox( stem linespec, keys, breaker )
                                  keys: sl_box attributes'
                                `default breaker name Bm'
define(`sl_meterbox',
 `sl_eleminit_(`$1')
  setkeys_(`$2',`name::N; wdth:dimen_*2/3; lgth:dimen_*2/3; box::N; text::N')dnl
  ifelse(`$3',,
   `line from last line.end to last line.start 
    {ifelse(m4name,,,m4name:) [S:Here;
      { B: rotbox( m4lgth, m4wdth, m4box ) with .W at S }
      a = rp_ang*rtod_
      if (abs(a-90) < 45) || (abs(a-180) < 45) || (abs(a+180) < 45) then { 
        C: rvec_(m4lgth*2/5,0)
        line from rvec_(m4lgth*4/5,m4wdth/2) to rvec_(m4lgth*4/5,-m4wdth/2) } \
      else { C: rvec_(m4lgth*3/5,0)
         line from rvec_(m4lgth/5,m4wdth/2) to rvec_(m4lgth/5,-m4wdth/2) }
      ifelse(m4text,,,`m4text at C')
      ] with .S at last line.start}',
   `m4br_one(`sl_meterbox',`$1',`$2',m4brk_(`$3',Bm))') ')

                            `sl_generator( stem linespec, keys, breaker )'
                                `default breaker name Bd'
define(`sl_generator',`sl_disk($@)
  { ACsymbol(at last circle,,,R)
    m4lcd = last circle.diam
    [ box invis wid_ m4lcd ht_ m4lcd ] at last circle } ')

                            `sl_syncmeter( stem linespec, keys, breaker )'
                                `default breaker name Bd'
define(`sl_syncmeter',`sl_disk($@)
  { Syncsymb(at last circle)
    m4lcd = last circle.diam
    [ box invis wid_ m4lcd ht_ m4lcd ] at last circle } ')

                            `sl_lamp( stem linespec, keys, breaker )'
                                `default breaker name Bd'
define(`sl_lamp',`sl_disk($@)
  { line from last circle.ne to last circle.sw
    line from last circle.nw to last circle.se
    m4lcd = last circle.diam
    [ box invis wid_ m4lcd ht_ m4lcd ] at last circle } ')

# One-terminal utilities ##################################################

                            `Syncsymb(at position, rad)
                                Symbol for sync meter'
define(`Syncsymb',`[ define(`m4ssrad',`ifelse(`$2',,(dimen_/4),`($2)')')dnl
 Origin: Here
 {arc <-> ht arrowht/2 wid arrowwid*2/3 \
   from Rect_(m4ssrad,30) to Rect_(m4ssrad,150) with .c at Here}
 line from (0,m4ssrad) to (0,-m4ssrad/2)
 `$3' ] with .Origin ifelse(`$1',,`at Here',`$1')')

                            `m4br_one( `name', stem linespec, body keys,
                               breaker keys )'
                            `Draw the breaker in the stem then the element'
define(`m4br_one',
 `M4_S: last line.start
  setkey_(`$4',lgth,brksiz_)dnl
  line from M4_S to last line.end+vec_(-(m4lgth)*5/2,0)
  sl_breaker(to rvec_(m4lgth,0),`$4')
  $1(to rvec_((m4lgth)*3/2,0),`$3')
  move to M4_S ')

                            `sl_eleminit_(linespec or (for zero length)
                                U|D|L|R|number [at location])'
define(`sl_eleminit_',
 `ifelse(regexp(`$1',^ *[UDLR0123456789]),-1,
   `eleminit_(`$1',dimen_)',
   `pushdef(`M4pos',`ifinstr(`$1',` at ',`patsubst(`$1',^.* at *)')')dnl
    ifelse(M4pos,,,`move to M4pos;') setdir_(patsubst(`$1',` at.*'))
   line invis from Here to Here popdef(`M4pos')')')

# Two-terminal elements ###################################################

                            `sl_transformer(linespec,keys,
                              input breaker keys, output breaker keys)
                             keys:
                               type=I|S
                               (type=I) scale=expr; (default 1.5)
                                        cycles=n; (default 4)
                               (type=S) body=shaded "color";
                               name=Body name;
                               (breaker default names BrI, BrO)'
define(`sl_transformer',
 `setkeys_(`$2',name::N; type:I:N; cycles:4:N; body::N;  scale:1.5:; )dnl
  ifelse(`$3'`$4',,
   `ifinstr(m4type,S,
     `source(`$1',G,,,m4body)',
     `eleminit_(`$1'); m4atmp = rp_ang; m4slen = rp_len
      define(`m4swd',`dimen_*3/16*m4scale')dnl
      { line to rvec_((m4slen-m4swd)/2,0)
        {ifelse(m4name,,SL_box,m4name): [ linewid = linewid*m4scale
          {L1: inductor(to vec_(0,-m4cycles*dimen_/8),,m4cycles)}
          {point_(m4atmp)
           L2: inductor(from vec_(dimen_*3/16,-m4cycles*dimen_/8) \
             to vec_(dimen_*3/16,0),,m4cycles)}
           C2: last line.c; point_(m4atmp) ] with .L1.c at Here}
        line from rvec_(m4swd,0) to rvec_((m4slen+m4swd)/2,0) }
      line invis to rvec_(rp_len,0)') ',
   `m4br_two(`sl_transformer',`$1',`$2',m4brk_(`$3',BrI),m4brk_(`$4',BrO),
      ifelse(`$3',,,I)`'ifelse(`$4',,,O))') ')

                            `Two-terminal box'
                            `sl_ttbox(linespec,keys,breaker keys,breaker keys)
                             keys= lgth=expr; wdth=expr; box=attributes;
                               supp=additional rotbox commands; name=Body name;
                               text="text";
                               (breaker default names BrI, BrO)'
define(`sl_ttbox',
 `setkeys_(`$2',`lgth:dimen_*3/4; wdth:dimen_*3/4;
    name::N; box::N; text::N; supp::N')dnl
  ifelse(`$3'`$4',,
   `eleminit_(`$1')
    {line to rvec_((rp_len-m4lgth)/2,0)
      {ifelse(m4name,,,m4name:)rotbox(m4lgth,m4wdth,m4box,,m4supp) \
        with .W at Here }
      {ifelse(m4text,,,`{m4text at rvec_(m4lgth/2,0)}') }
     line from rvec_(m4lgth,0) to rvec_((rp_len+m4lgth)/2,0)}
    line invis to rvec_(rp_len,0) ',
   `m4br_two(`sl_ttbox',`$1',`$2',m4brk_(`$3',BrI),m4brk_(`$4',BrO),
      ifelse(`$3',,,I)`'ifelse(`$4',,,O))') ')

define(`m4brk_',`ifelse(`$1',,,
  `ifelse(`$1',C,,`$1',O,box=fill 0,`$1')`'ifelse(`$2',,,;name=`$2')')')

                            `sl_rectifier(ttbox args)'
define(`sl_rectifier',
 `sl_ttbox(`$@')
  { line from last [].Line.ne to last [].Line.sw
    AC: ACsymbol(at last [].C+(-m4lgth/6, m4wdth/4),,,R)
    DC: DCsymbol(at 2nd last [].C+( m4lgth/6,-m4wdth/4),,,R) } ')

                            `sl_inverter(ttbox args)'
define(`sl_inverter',
 `sl_ttbox(`$@')
  { line from last [].Line.ne to last [].Line.sw
    DC: DCsymbol(at last [].C+(-m4lgth/6, m4wdth/4),,,R)
    AC: ACsymbol(at 2nd last [].C+( m4lgth/6,-m4wdth/4),,,R) } ')

                            `sl_breaker(linespec, type=[A|C][D]; ttbox keys)
                               C is for curved breaker
                               D is for sl_drawout'
define(`sl_breaker',
 `setkeys_(`$2',`lgth:brksiz_; wdth:brksiz_; name::N; type::N')dnl
  ifinstr(m4type,C,
   `ifinstr(m4type,D,
     `m4ch_two(`cbreaker',`$1')',
     `ifelse(m4name,,,m4name:) cbreaker(`$1')')',
   `ifinstr(m4type,D,
     `m4ch_two(`sl_ttbox',`$1',lgth=m4lgth;wdth=m4wdth;`$2';name=Br)',
     `sl_ttbox(`$1',lgth=m4lgth;wdth=m4wdth;`$2')') ') ')

                            `sl_reactor(linespec,keys,breaker keys,breaker keys)
                             keys=
                               diam=expr,
                             (Default breaker names BrI and BrO)'
define(`sl_reactor',
 `setkeys_(`$2',`diam:sourcerad_*4/3; type::N')dnl
  ifelse(`$3'`$4',,
   `eleminit_(`$1')
    { line to rvec_(rp_len/2,0) then to rvec_(rp_len/2,-m4diam/2); round
      arc rad m4diam/2 cw from Here to rvec_(m4diam/2,m4diam/2) \
        with .c at rvec_(0,m4diam/2); round
      line to rvec_(rp_len/2-m4diam/2,0) }
    {[ box invis ht m4diam wid m4diam ] at rvec_(rp_len/2,0)}
    line invis to rvec_(rp_len,0) ',
   `m4br_two(`sl_reactor', `$1', lgth=m4diam*2;`$2',
      m4brk_(`$3',BrI),m4brk_(`$4',BrO),ifelse(`$3',,,I)`'ifelse(`$4',,,O))')')

                            `sl_busbar( linespec, nports, keys )
                             Labels P1, P2 ... Pnports are defined on the line.
                                  keys: line=line attributes;
                                        port=D; (dotted ports)
                             The bus extends beyond the first and last points
                              by dimen_/5 which can be redefined as
                                line=chop -(expr)'
define(`sl_busbar',
 `define(`m4npoints',`ifelse(`$2',,2,`$2')')dnl
  setkeys_(`$3',`line:thick 1.6 chop -dimen_/5:N; port::N')dnl
  [ tmp_ang = rp_ang
    eleminit_(`$1',(m4npoints-1)*dimen_)
    Start: last line.start; End: last line.end
    for_(1,m4npoints,1,
     `P`'m4x: (m4x-1)/(m4npoints-1) between Start and End dnl
     ifinstr(m4port,D,` ;dot(at P`'m4x)')')
    Line: line from Start to End m4line
    Start: last line.start; End: last line.end
    point_(tmp_ang) ] ')

                            `sl_drawout(linespec, keys, R)
                             Drawout (i.e. plugin) chevron element;
                               keys:  type=T; (truncated leads)
                                      lgth=expr; (body size)
                                      wdth=expr;
                                      name=Name; (body name)
                                      line= line attributes (e.g. thick 2)
                               arg3=R reverse direction'
define(`sl_drawout',
  `setkeys_(`$2',`lgth:drosiz_; wdth:drosiz_; type::N; name::N; line::N')dnl
   eleminit_(`$1',ifelse(m4type,T,m4lgth))
   ifelse(`$3',R,`{M4ds: Here; move to last line.end; rp_ang = rp_ang+pi_')
   {line to rvec_(rp_len/2,0)
    ifelse(m4name,,,m4name:) [
     S: Here; {line from rvec_(-m4lgth/2,m4wdth/2) to Here then
       to rvec_(-m4lgth/2,-m4wdth/2) m4line }
     E: rvec_(m4lgth/2,0); line from rvec_(0,m4wdth/2) to E then
       to rvec_(0,-m4wdth/2) m4line ] with .S at Here
     ifelse(m4type,T,,
      line from last [].E to last [].E+vec_((rp_len-m4lgth)/2,0))}
    ifelse(`$3',R,`rp_ang = rp_ang-pi_; move to M4ds}')
   line invis to rvec_(rp_len,0) ')

# Two-terminal utilities ##################################################

                            `Breakers in the input and output lines:'
                            `m4br_two(`2-term element macroname in quotes',
                                linespec, body keys,
                                input breaker keys,
                                output breaker keys,
                                I|O|IO)'
                            `(Default breaker names are BrI and BrO)'
define(`m4br_two',
 `define(`m4il',`ifinstr(`$6',I,`setkey_(`$4',lgth,brksiz_) m4lgth',0)')dnl
  define(`m4ol',`ifinstr(`$6',O,`setkey_(`$5',lgth,brksiz_) m4lgth',0)')dnl
  define(`m4bl',`setkey_(`$3',lgth,dimen_*4/3) m4lgth')dnl
  eleminit_(`$2',dimen_*3)
  M4start: Here; M4end: last line.end
  M4cc: last line.c+vec_(((m4il*3/2)-(m4ol*3/2)),0)
  M4ii: M4cc+vec_(-min((m4bl/2+m4il/2),distance(M4start,M4cc)-m4il),0)
  line from M4start to ifinstr(`$6',I,
   `M4ii+vec_(-m4il,0); sl_breaker(to M4ii,`$4';name=BrI)',M4ii)
  M4oi: M4cc+vec_(min((m4bl/2+m4ol/2),distance(M4end,M4cc)-m4ol),0)
  $1(from M4ii to M4oi,`$3')
  ifinstr(`$6',O,`sl_breaker(to M4oi+vec_(m4ol,0),`$5';name=BrO)')
  line to M4end
  line invis from M4start to M4end ')

                            `Chevrons in the input and output lines:'
                            `m4ch_two(`2-term element macroname in quotes',
                                linespec, body keys,
                                input breaker keys,
                                output breaker keys,
                                I|O|IO)'
define(`m4ch_two',
 `define(`m4bl',`setkey_(`$3',lgth,dimen_*3/8) m4lgth')dnl
  eleminit_(`$2',dimen_*3)
  M4start: Here; M4end: last line.end
  M4elem: $1(to rvec_(m4bl+2*drosiz_,0) with .c at last line.c,`$3')
  sl_drawout(from last line.start-vec_(drosiz_,0) to last line.start,type=T,R)
  line from last line.start to M4start
  sl_drawout(from M4elem.end to M4elem.end+vec_(drosiz_,0),type=T)
  line to M4end
  line invis from M4start to M4end')

# Composite elements ###################################################

                            `sl_ct( at position, stem length, U|D|L|R|expr,
                                scale=expr) (default scale is 1.5)'
define(`sl_ct',
 `[ setdir_(`$3'); setkey_(`$4',scale,1.5); linewid = linewid*m4scale
    L: inductor(to vec_(2*dimen_/8,0),,2)
      stemlen = ifelse(`$2',,dimen_/5,`$2')
      line from L.start to L.start+vec_(0,-stemlen)
    Ts: Here
      line from L.end to L.end+vec_(0,-stemlen)
    Te: Here
      line from L.c to L.c+vec_(0,-stemlen)
    Tc: Here
    resetdir_ ] with .L.c at ifelse(`$1',,Here,patsubst(`$1',^ *at *)) ')

# #######################################################################

divert(0)dnl


  u = dimen_

  svg_font(sans-serif,9.0bp__,textoffset)

define(`ctb',`[CT: sl_ct(,,`$1')
      L: line up_ u/2 with .c at CT.L.c
      BU: sl_breaker( up_ u*2/3,box=fill_(0))
      BR: sl_breaker( right_ ifelse(`$1',U,,-)u*3/4 \
        from CT.ifelse(`$1',U,Te,Ts),box=fill_(0))]')

define(`tsbx',`sl_ttbox(`$1',`$2';lgth=u*0.4;wdth=u/2;text="TS")')
define(`lcdiam',u*0.85)
define(`lcirc',`[C: circle diam lcdiam ifelse(`$1',,,`$1')
  line right C.diam*3/4 with .c at C
  ifelse(`$2',,,`$2' at C.ne above )
  ifelse(`$3',,,`$3' at C.se below )
 ]')

define(`Svee',`[S: Here; line from (sqrt(3),1)*(`$1') to S \
   then to (sqrt(3),-1)*(`$1')]')

Box1: [
  V: line down_ u
    {`"13.8 kV 3 ph + GND 60 Hz"' at V.start rjust}
    { ellipse wid u/6 ht u/10 at Here+(0,u/3)
      line right_ u/2 from last ellipse.e
      ellipse wid u*4/3 ht u/2 "M1-00" }
    AT: open_arrow(ToPos(,U,u), u/3*sqrt(3)/2, u/3)
    dot(at 2nd last line.start)
    { line left_ u then up_ u/3 ht u/10 wid u/10; dot }
    line down_ u
    { line up_ u/2 from last line.end+(-u/6,u/8)
      sl_disk( left_ u/2 from last line.c,diam=u/3;name=L ); move to L.c
      for_(45,315,90,`{line to L.c+(Rect_(L.diam,m4x)) chop u/5 chop 0}') }
    T: dot
    { sl_transformer(right_ 2*u,cycles=2;name=Tr1)
      {"14400:120` 'V" at last [].n above}
      { Svee(u/7) with .ne at Tr1.sw+(-u/15,-u/15)
        Svee(u/7) with .nw at Tr1.se+( u/15,-u/15); ground(at last [].S) }
      dot; fuse(right_ u,C)
      line to (Here,1st ellipse)
      MB: box wid 3/4*u ht 3/4*u with .sw at Here+(-u/8,0) 
      circle diam 5/8*u at last box "M" }
    line down u/2
    CT1: ctb(U) with .BU.end at Here
    {"500:5" rjust at CT1.CT.w }
    { Svee(u/7) with .S at CT1.CT.Ts+( u/4,0); ground(at last [].S) }
    line from MB.se+(-u/8,0) down_ MB.s.y-CT1.BR.y then to CT1.BR.end
    line from CT1.L.start down_ 3/4*u
    T2: dot
    { line left_ u from T2; sl_drawout(,type=T,R); fuse(left_ u,C)
      sl_transformer(left_ u/2,cycles=2;name=Tr2)
      {"14400:120` 'V" at last [].n above}
      {Ysymbol(with .ne at Tr2.sw+(u/8,0),type=G;size=u/6)}
      {Ysymbol(with .nw at Tr2.se+(u/15,0),type=G;size=u/6)}
      fuse(left_ u,C); sl_drawout(,type=T)
      TS1: tsbx(left_ u*3/4) }
    CT2: ctb(U) with .BU.end at Here
    {"800:5" rjust at CT2.CT.w }
    {Ysymbol(at CT2.CT.Ts+(u/2,-u/8),type=G;size=u/5)}
    sl_breaker(up_ 2.0*u with .end at CT2.L.start,
      lgth=u*0.75;wdth=u*0.8;name=M1;type=D)
    {`"52-M1" "1200 A"' at M1}
    CT3: ctb(D) with .BU.end at last line.start
    {"800:5" ljust at CT3.CT.e }
    BT3: CT3.BR.end
    {Ysymbol(at CT3.CT.Te+(-u/2,-u/8),type=G;size=u/5)}
    CT4: ctb(D) with .BU.end at CT3.L.start
    {"600:5 MR" ljust at CT4.CT.e }
    {Ysymbol(at CT4.CT.Te+(-u/2,-u/8),type=G;size=u/5)}
    line from CT4.L.start down_ u; dot;
    { line left_ u then up_ u/3 ht u/10 wid u/10; dot }
    AB: arrow down_ u*2/3 ht u/3*sqrt(3)/2 wid u/3
    tsbx(left_ u from CT3.BR.end,text="SB")
    line to (TS1.start,Here)
    tsbx(left_ u*3/4); line left_ u/2+lcdiam/2 then up_ u/5
    CEDR3: lcirc("59" "M1","(3)") with .C.s at Here
    Q: line left_ u*3/4 from CEDR3.C.w
    { line left_ u/8 from Q.c+(u/8,CEDR3.C.rad) \
        then down_ CEDR3.C.diam then right_ u/8 }
    CEDR4: lcirc("22" "M1","(1)") with .C.e at Here
    { arrow right_ 3/2*u from CEDR3.C.e
      lcirc("86" "M1","(1)") with .C.w at Here
      arrow right_ u from last [].C.e
      "TRIP M1" ljust above "TRIP S1" ljust }
    { CEDR1: lcirc("59" "M1",,"(3)") with .C.w at (Q.c,T2)
      { line from TS1.end to CEDR1.C.e }
      CEDR2: lcirc("22" "M1",,"(3)")
      arrow up u*2/3 from (CEDR2.e.x,CEDR2.n.y+u/3)
      "TRIP S1" above; "TRIP M1" at last "".n above
      move to last arrow.start
      line from CEDR2.n to (CEDR2,Here) then to (CEDR1,Here) then to CEDR1.n
      }
    EDR5000: box wid TS1.end.x-CEDR4.C.w.x-u/8 ht last arrow.y-CEDR4.C.s.y+u/2 \
      with .n at last arrow "EDR-5000-M1"
    M2: box wid u*1.1 ht u*0.85 at (TS1,CT4.BR) "PXM6000" "METER"
    { line from M2.e to CT4.BR.end }
    line from M2.w left_ u*3/4
    BT: dot
    line to (EDR5000.w,Here)+(-u/5,0); Lft: Here
    continue to (Here,CEDR2.C) then to CEDR2.C.w
    Head: line down_ u*3/4 from AB.end
    { ellipse wid u/6 ht u/10 at Here+(0,u/3)
      line left_ u/2 from last ellipse.w
      ellipse wid u*4/3 ht u/2 "M1-00" }
    { line right_ u*3/4 then down_ u/8;
      {line right_ u/10 with .c at Here}
      {line right_ u/10 with .c at Here+(0,-u/8)}
      pushdef(`dimen_',u/2) ground(at last line.c) popdef(`dimen_') }
    { line down_ u/8 from Here+(u/2,0)
      { pushdef(`dimen_',u/2) ground(at Here+(0,-u/8)) popdef(`dimen_') }
      pushdef(`dotrad_',dotrad_/2) gap(down_ u/8,1) popdef(`dotrad_') }
    BB: arrow <- down_ u/2 ht u/3*sqrt(3)/2 wid u/3
    sl_transformer(down_ u,name=Tr3)
    { CUR2: lcirc("21" "T1",,"(1)") with .C.c at Tr3.e+(u,0)
      CUR3: lcirc("49" "T1",,"(1)") with .C.w at CUR2.C.e
      CUR1: lcirc("21" "T1","(1)") with .C.c at CUR2.C.c+(Rect_(CUR2.C.diam,60))
      }
    line from BT to (BT.x,AB.y+u/10); X: Here; corner
    CT5: ctb(U) with .BU.end at Tr3.L2.end
    {"600:5" ljust below at CT5.CT.e }
    corner(,at CT5.CT.Ts); ground
    line from CT5.BR.end to (CUR3.C.e,CT5.BR.end)+(u/6,0)
    continue to (Here,X)
    tsbx(up_ u*4/3)
    CUR5: lcirc("51G" "T1","(1)") with .C.s at Here
    CUR6: lcirc("87" "T1","(1)") with .C.c at CUR5.C.c+(2*u,0)
    arrow up_ u*2/3 from CUR5.C.n
    CUR4: lcirc("86" "T1","(1)") with .C.s at Here
    arrow up_ u*2/3 from CUR4.C.n
    arrow <- from CUR4.C.w left CUR4.C.w.x-CUR1.C.x; corner
    J2: line to CUR1.C.n
    arrow from CUR6.C.w left_ u/3 then up_ CUR4.C.y-CUR6.C.y then to CUR4.C.e
    tsbx(up_ u from CUR6.C.n)
    line to (Here,CT2.BR) then to CT2.BR.end
    crossover(from X to (CUR5,X)-(u*2/3,0),L,AB,J2); corner
    tsbx(up_ u*4/3); dot
    ETR5000: box wid CUR6.C.e.x-CUR1.C.x + u/5 ht CUR5.C.diam+u/2 \
      with .nw at (CUR1.C.n.x-u/8,CUR5.C.n.y+u/6)
    {"   ETR-5000-T1" wid 72bp__ at ETR5000.s above }
    AL: arrow from Tr3.L2.c down_ u ht u/3*sqrt(3)/2 wid u/3; BX: Here
    { line down_ u*2/3 from Here+( u/12,0) }
    { line down_ u*2/3 from Here+(-u/12,0) }
    { line down_ u*2/3; Bbot: Here }
    { ellipse wid u/6 ht u/10 at Here+(0,-u/6)
      line left_ u/2 from last ellipse.e
      ellipse wid u*2 ht u/2 `"2000 A BUSWAY"' }
    line from (CUR6,Bbot) to (CUR6,X); tsbx(to CUR6.C.s)
    Outer: box ht AT.end.y-AB.end.y wid ETR5000.e.x-Lft.x + u/3 \
      with .nw at (Lft.x-u/6,AT.end.y)
    `"USG-1A"' ljust \
    `"13.8 KV 1200 A"' ljust \
    `"50 kA SYM S.C."' ljust \
    `"(15 kV - 95 kV BIL RATED)"' ljust at Outer.nw+(0,-u*2/3)
  ]

  command "</g>"

.PE
