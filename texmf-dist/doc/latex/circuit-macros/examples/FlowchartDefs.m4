divert(-1)
  Google flowchart display symbol
  FlowchartDefs.m4
                                `Some experimental flow-chart macros.  
                                In the following, every block (subchart) is
                                in [] brackets, with .N, .S, .E and .W
                                internally defined.  Follow this convention
                                if you create compound constructs.

                                Generally, the first argument is one
                                or more strings; the second adjusts
                                the size, and the third can be used
                                to add color, dashed lines, labels,
                                or other embellishements.  Default is
                                grey fill if arg3 is blank.

                                These macros have been renamed from earlier
                                versions because of slight differences of
                                arguments.'

define(`FlowchartDefs_')

                               `Default sizes:'
define(`fboxwid',linewid*2)
define(`fboxht',linewid*0.75)
define(`farrowht',linewid*0.5)

                               `Fbox( "text", wid expr ht expr, attributes )
                                The basic task box: arg1 may be 1 or more
                                text strings. Attributes include box
                                line and fill specs.  To adjust the box
                                size to the size of the typeset text, see
                                the \boxdims macro in the manual. Example:
                                Fbox("$x < 1$",,
                                     shaded rgbstring(0.46,0.53,0.63))'
define(`Fbox',`[ boxwid = fboxwid; boxht = fboxht
 Box: box `$2' ifelse(`$3',,`fill_(fillval)',`$3') `$1'
  N: Box.n; S:Box.s; E:Box.e; W: Box.w
 `$4']')

                               `Fdelay("text",wid expr ht expr,attributes)'
define(`Fdelay',`[ boxwid = fboxwid; boxht = fboxht
  Box: box invis `$2'
  N: Box.n; S: Box.s; E: Box.e; W: Box.w
  arc from Box.se-(Box.ht/2,0) to Box.ne-(Box.ht/2,0) \
    with .c at Box.e-(Box.ht/2,0) `$3'
  line to Box.nw to Box.sw to Box.se-(Box.ht/2,0) `$3'
  ifelse(`$1',,,`$1' at Box)
 `$4']')

                               `Fdisplay("text",wid expr ht expr,attributes)'
define(`Fdisplay',`[ boxwid = fboxwid; boxht = fboxht
  Box: box invis `$2'
  N: Box.n; S: Box.s; E: Box.e; W: Box.w
  NE: Box.ne-(Box.ht/4,0); SE: (NE,Box.s)
  NW: Box.nw+(Box.ht/2,0); SW: (NW,Box.s)
  ifelse(`$3',,,`
  box wid NE.x-NW.x ht Box.ht with .ne at NE `$3' invis
    line from W to NW then to SW then to W `$3' invis ')
  arc from SE to NE with .c at E-(Box.ht*2/3,0) `$3'
  line to NW `$3'
  arc from NW to W with .c at (NW,Box)+(Box.ht/4,-Box.ht/4) `$3'
  arc from W to SW with .c at (NW,Box)+(Box.ht/4,Box.ht/4) `$3'
  line to SE `$3'
  ifelse(`$1',,,`$1' at Box)
 `$4']')

                               `Fstored("text",wid expr ht expr,attributes)'
define(`Fstored',`[ boxwid = fboxwid; boxht = fboxht
  Box: box invis `$2'
  r = Box.ht*7/8; d = r - sqrt(r^2-(Box.ht/2)^2)
  N: Box.n; S: Box.s; E: Box.e-(d,0); W: Box.w
  NW: Box.nw+(d,0); SW: (NW,Box.s); NE: Box.ne; SE: Box.se
  ifelse(`$3',,,`
    box wid NE.x-NW.x ht Box.ht with .nw at NW `$3' invis ')
  arc from NW to SW with .c at Box.w+(r,0) `$3'; round
  line to SE; round
  arc cw to NE with .c at E+(r,0) fill_(1); round
  line to NW `$3'; round
  ifelse(`$1',,,`$1' at Box)
 `$4']')

                               `Fconnect("text",
                                  wid expr ht expr[:U|D|L|R|angle], attributes)'
define(`Fconnect',`[ boxht = fboxht; boxwid = boxht
  define(`m4wh',`m4Leftstr(`$2')')dnl
  define(`m4wid',`patsubst(patsubst(m4wh, ht .*),^wid ,)')dnl
  ifelse(m4wid,,`define(`m4wid',boxwid)')dnl
  define(`m4ht',`patsubst(m4wh,.* *ht *,)')dnl
  ifelse(m4ht,,`define(`m4ht',boxht)')dnl
  define(`m4cpt',`m4Rightstr(`$2')')dnl
  setdir_(ifelse(m4cpt,,`ifdef(`m4a_',rp_ang*rtod_,0)',m4cpt))
# {Box: [lbox(m4wid,m4ht,invis)]}
  W: Here; NW: vec_(0,m4ht/2); N: vec_(m4wid/2,m4ht/2); NE: vec_(m4wid,m4ht/2)
  SW: vec_(0,-m4ht/2); S: vec_(m4wid/2,-m4ht/2); SE: vec_(m4wid,-m4ht/2)
  E: vec_(m4wid,0); C: 3/8 between W and E
  line from 1/2 between NW and N \
    to NW to SW to S to E to N to 1/2 between NW and N `$3'
  ifelse(`$1',,,`$1' at C)
 `$4'; resetdir_ ]')

                               `Fdata("text",wid expr ht expr,
                                  xslant,attributes)'
define(`Fdata',`[ boxwid = fboxwid; boxht = fboxht
  Box: box invis `$2'
  xs = ifelse(`$3',,fboxht/6,`($3)/2')
  NE: Box.ne+(xs,0); SE: Box.se-(xs,0)
  NW: Box.nw+(xs,0); SW: Box.sw-(xs,0)
  N: Box.n; E: Box.e; S: Box.s; W: Box.w
  line from N to NE then to SE then to SW then to NW then to N \
    ifelse(`$4',,`fill_(fillval)',`$4')
  ifelse(`$1',,,`$1' at Box)
  `$5']')

                               `Fprep("text",wid expr ht expr,attributes)'
define(`Fprep',`[ boxwid = fboxwid; boxht = fboxht
  Box: box invis `$2'
  NE: Box.ne-(fboxht/4,0); E: Box.e; SE: (NE,Box.s); N: Box.n
  NW: Box.nw+(fboxht/4,0); W: Box.w; SW: (NW,Box.s); S: Box.s
  line from N to NE to E to SE to SW to W to NW to N \
    ifelse(`$3',,`fill_(fillval)',`$3')
  ifelse(`$1',,,`$1' at Box)
  `$4']')

                               `Fkeyboard("text",wid expr ht expr,attributes)'
define(`Fkeyboard',`[ boxwid = fboxwid; boxht = fboxht
  Box: box invis `$2'
  NW: Box.nw-(0,min(Box.ht/4,Box.wid/16)); W: Box.w; SW: Box.sw; S: Box.s
  NE: Box.ne+(0,min(Box.ht/4,Box.wid/16)); E: Box.e; SE: Box.se; N: 0.5 between NW and NE
  line from N to NE to SE to SW to NW to N ifelse(`$3',,`fill_(fillval)',`$3')
  ifelse(`$1',,,`$1' at Box)
  `$4']')

                               `Fdocument("text",wid expr ht expr,attributes)'
define(`Fdocument',`[ boxwid = fboxwid; boxht = fboxht
  Box: box invis `$2'; Q: move from Box.sw to Box.se
  NE: Box.ne; E: Box.e; SE: Box.se-(0,Box.ht/4); N: Box.n
  NW: Box.nw; W: Box.w; SW: Box.sw-(0,Box.ht/4); S: Box.s-(0,Box.ht/4)
  line from SE to NE to NW to SW `$3'
  arc to S with .c at (0.5 between SW and S) + (0,Box.ht) `$3'
  arc to SE with .c at (0.5 between S and SE) -(0,Box.ht) cw \
    ifelse(`$3',,,``$3' shaded rgbstring(1,1,1)')
  ifelse(`$1',,,`$1' at Box)
  `$4']')

                               `Fkeying("text",wid expr ht expr,attributes)'
define(`Fkeying',`[ boxwid = fboxwid; boxht = fboxht
  Box: box `$2' invis
  hsq = (Box.wid/2)^2-(Box.ht/2)^2
  if hsq > 0 then { d = Box.wid/2-sqrt(hsq) } else { d = 0 }
  W: Box.w; NW: Box.nw+(d,0); N: Box.n; NE: Box.ne-(d,0)
  E: Box.e; SE: Box.se-(d,0); S: Box.s; SW: Box.sw+(d,0)
  if hsq >= 0 then { x = 0 } else { x = sqrt(-hsq) }
  box wid NE.x-NW.x ht N.y-S.y `$3' invis at Box
  arc from SE to NE with .c at Box - (x,0) `$3'; round(,,`$3')
  line to NW `$3'; round(,,`$3')
  arc to SW with .c at Box + (x,0) `$3'; round(,,`$3')
  line to SE `$3'; round(,,`$3')
  ifelse(`$1',,,`$1' at Box)
  `$4']')

                               `If-then
                                Ftest( "text", wid expr ht expr, attributes )'
define(`Ftest',`[boxwid = fboxwid*0.8; boxht = fboxht*1.4
 Box: box ifelse(`$2',,,`$2') invis
 N: Box.n; S: Box.s; E: Box.e; W: Box.w 
 line from 0.5 between last box.n and last box.e to last box.e to last box.s \
  to last box.w to last box.n to 0.5 between last box.n and last box.e \
  ifelse(`$3',,`fill_(fillval)',`$3')
  ifelse(`$1',,,`$1' at Box)
 `$4']')

                               `Fcase: case statement
                                Fcase(wid expr ht expr,
                                  "Test string 1"[:attributes],task, ...,
                                  "Test string n"[:attributes],task )'
                               `arg1 adjusts the size of the tests
                                The optional attributes for each string apply
                                to the Ftest containing the string.
                                The Ftest blocks are labeled Test1, Test2, ...
                                A task is a flow subchart with internal
                                names .E and .S defined. The tasks are
                                labeled Task1, Task2, ...  '
define(`Fcase',`[ down; S: Here; sx = S.x
  Fcaseloop_(1,$@)
  ifelse(`$2',,`E:S; W:S; N:S',
   `E:(sx+linewid/2,Task1.E.y); W:Test1.W; N:Test1.N')
  Fcasearrow_(1,$@)
  arrow from E to (E,S) then to S ]')

  define(`Fcaseloop_',`ifelse(`$3',,,
   `Test`$1': Ftest(patsubst(`$3',":.*,"),`$2',
      ifinstr(`$3',":,`patsubst(`$3',.*":,)')) with .N at S
    Task`$1': `$4' with .nw at Test`$1'.E+(linewid/2,min(Test`$1'.ht,fboxht)/2)
      arrow right linewid/4 from Test`$1'.E \
        then down Test`$1'.E.y-Task`$1'.W.y then to Task`$1'.W
    S: (Test`$1'.S.x,min(Test`$1'.S.y,Task`$1'.S.y)-linewid/3)
      ifelse(`$5',,`line',`arrow') from Test`$1'.S to S
      sx = max(sx,Task`$1'.E.x)
      Fcaseloop_(incr($1),`$2',shift(shift(shift(shift($@)))))')')
  define(`Fcasearrow_',`ifelse(`$3',,,
   `arrow from Task`$1'.E to (E,Task`$1'.E)
    Fcasearrow_(incr($1),,shift(shift(shift(shift($@)))))')')
  
                               `while statement with explicit test
                                Fwhiledo("test text", wid x ht y,
                                          attributes, task spec )
                                The task structure is given label Task '
define(`Fwhiledo',`[ down
  Test: Ftest(`$1',`$2',`$3')
    arrow right linewid/2 from Test.E
  Task: `$4' with .W at Here
  E: Task.E; W: Test.w; S: Test.S
    arrow up max(linewid/4,Test.n.y-Task.n.y+arrowht*1.5) \
      from Task.N then left Task.x-Test.x
  N: Here
    arrow to Test.n
 `$5']')

                               `repeat statement with explicit test
                                Frepeatuntil("test",wid x ht y,
                                              attributes, task spec )
                                The task structure is given label Task '
define(`Frepeatuntil',`[ N: Here
  Task: ifelse(`$4',,Here,`$4' with .N at N)
  W: Task.W
    arrow from Task.S down linewid/3
  Test: Ftest(`$1',`$2',`$3')
  E: Task.E+(linewid/2+max(0,Test.e.x-Task.e.x),0)
    arrow from Test.e to (E,Test) then to E then to Task.E
  S: Test.S
 `$5']')

                               `if-then-else
                                Fifthenelse( "test", wid x ht y, attributes,
                                              left tasks, right tasks)
                                The left task structure is given label
                                Ltask and the right task structure is
                                given label Rtask '
define(`Fifthenelse',`[ Test: Ftest(`$1',`$2',`$3')
  N: Test.N
  Ltask: ifelse(`$4',,`Test.S; W:Test.W; LS:Ltask',
      `$4 with .ne at ((Test.W.x+Test.x)/2,Test.S.y)
    W: Ltask.W; LS:Ltask.S
    arrow from Test.W to (Ltask.N,Test.W) then to Ltask.N')
  Rtask: ifelse(`$5',,`Test.S; E:Test.E; RS:Rtask',
      `$5 with .nw at ((Test.E.x+Test.x)/2,Test.S.y)
    E: Rtask.E; RS: Rtask.S
    arrow from Test.E to (Rtask.N,Test.E) then to Rtask.N')
  S: (Test.x,min(LS.y,RS.y)-linewid/3)
    arrow from LS to (LS,S)
    arrow from RS to (RS,S)
    line to (LS,Here)
  `$6']')
divert(0)dnl
