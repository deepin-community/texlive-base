.PS
# FlowSVG.m4
gen_init(svg_font(sans-serif,11bp__,2.5bp__))
ifdef(`FlowchartDefs_',,`include(../FlowchartDefs.m4)')

define(`Thistle',`rgbstring(0.85,0.75,0.85)')dnl
define(`RubineRed',`rgbstring(0.81,0,0.35)')dnl
define(`YellowGreen',`rgbstring(0.68,1,0.18)')dnl
define(`SeaGreen',`rgbstring(0.13,0.70,0.67)')dnl
define(`Goldenrod',`rgbstring(0.85,0.65,0.13)')dnl
define(`Beaublue',`rgbstring(0.74,0.83,0.9)')dnl
define(`Celadon',`rgbstring(0.67,0.88,0.69)')dnl

# Accented characters
define(`svg_ccedilla',`svg_symbol(&`#'231;)')dnl
define(`svg_atilde',`svg_symbol(&`#'227;)')dnl

  linethick_(1.0)
  arrowwid = 0.05
  arrowht = 0.1
  fillval = 0.9
  maxpsht = 20

define(`shad',`shaded rgbstring(0.9,0.8,0.7)')
define(`Below',`with .nw at last [].sw+(0,-0.25)')
TL: Here
Simple: [
  Fbox("svg_tt(`Fbox')",,shad)
  Ftest("svg_tt(``Ftest'')",,shad) Below
  Fdata("svg_tt(``Fdata'')",,,shad) Below
  Fprep("svg_tt(``Fprep'')",) Below
  Fkeying("svg_tt(``Fkeying'')") Below
  Fkeyboard("svg_tt(``Fkeyboard'')") Below
  Fdocument("svg_tt(``Fdocument'')",,shaded rgbstring(0.9,0.8,0.7)) Below
  Fdelay("svg_tt(``Fdelay'')",,shaded Beaublue) Below
  Fdisplay("svg_tt(``Fdisplay'')",,shaded Celadon) Below
  Fstored("svg_tt(``Fstored'')",,shaded Thistle) Below
  Fconnect(,,shaded Thistle) Below
  Fconnect("45",wid boxwid ht boxht:45,shaded Thistle) \
    with .w at last [].e+(boxht/8,0)
  "svg_tt(`Fconnect')" at last [].nw + (0,boxht/6)
  ] with .nw at TL+(0.1,0); move from Simple.nw to TL

#showbox_
Complex: [
Case: Fcase(,
  "Test 1",[Fbox("Task 1",, shaded Thistle); W:last [].W; N:last [].N
            arrow down linewid/3 from last [].S
            Fbox("Task 1.5",, shaded Thistle) with .N at Here
            E:last [].E; S:last [].S],
  "Test 2",Fbox("Task 2" "is bigger", wid fboxwid*1.2 ht fboxht*3/2, \
                shaded SeaGreen),
  "Test 3",Fbox("Task 3",, shaded RubineRed)dnl
  )

  "svg_it(.N)" at Case.N rjust above
  "svg_it(.S)" at Case.S rjust below
  "svg_it(.E)" at Case.E ljust
  "svg_it(.W)" at Case.W rjust
  "svg_tt(`Fcase')" below at Case.s #+(0,-0.1)

Whiledo: Fwhiledo("svg_it(i svg_lt n)",,,Fbox("Task"),"T" above ljust at Test.E) \
  with .nw at Case.ne+(0.25,0)

  "svg_it(.N)" at Whiledo.N rjust
  "svg_it(.S)" at Whiledo.S rjust below
  "svg_it(.E)" at Whiledo.E ljust
  "svg_it(.W)" at Whiledo.W rjust
  "svg_tt(`Fwhiledo')" below at Whiledo.s

Repeatuntil: Frepeatuntil("svg_it(n svg_gt 5)",,,Fbox("Task"),
   "T" at Test.E above ljust) with .nw at Whiledo.sw + (0.25,-0.5)

  "svg_it(.N)" at Repeatuntil.N rjust above
  "svg_it(.S)" at Repeatuntil.S rjust below
  "svg_it(.E)" at Repeatuntil.E ljust
  "svg_it(.W)" at Repeatuntil.W rjust
  "svg_tt(`Frepeatuntil')" below at Repeatuntil.se +(-0.0,0.2)

Ifthenelse: Fifthenelse("svg_it(A svg_lt B)",,,
     Fbox("False"),
     Fbox("True",ht fboxht*1.2 wid fboxwid)dnl
     ) with .nw at Repeatuntil.sw +(-0.5,-0.3)

  "svg_it(.N)" at Ifthenelse.N rjust above
  "svg_it(.S)" at Ifthenelse.S below rjust
  "svg_it(.E)" wid 12bp__ at Ifthenelse.E ljust
  "svg_it(.W)" at Ifthenelse.W rjust
  "svg_tt(`Fifthenelse')" below at Ifthenelse.s+(0,-0.15)

Compound: [ right 
  ellipse shaded YellowGreen "Start"
  arrow right linewid/2

  Fbox("First task") with .W at Here
  arrow down linewid/2 from last [].S

  Fifthenelse("Test 1",,,
    Frepeatuntil("svg_it(i svg_geq 5)",,shaded Goldenrod,Fbox("Task")),
    Fifthenelse("svg_it(A svg_lt B)",,shaded Goldenrod,
      Fbox("Left"),
      Fbox("Right"),
    "T" at Test.E above ljust),
    "T" at Test.E above ljust) with .N at Here

  A: arrow down 0.25 from last [].S ] with .nw at Case.sw + (-12bp__,-0.3)

  "svg_it(Compound statements)" at last [].A.end+(0.1,0) ljust above

  ] with .nw at Simple.ne+(0.1,0)

Example: [ fillvalue = 0.8; awid = linewid/2; right_
  Start: ellipse wid boxwid/2 ht boxwid/3 shaded "green"
  arrow right_ awid
  B1: Fbox("Planejamento")
  B2: Fbox("Execu`'svg_ccedilla`'svg_atilde`'o") with .W at B1.E+(awid*3,0)
  B3: Fbox("Sele`'svg_ccedilla`'svg_atilde`'o") with .W at B2.E+(awid*3,0)
  LT: Ftest("Avalia`'svg_ccedilla`'svg_atilde`'o do" "Planejamento",
    wid fboxwid*1.5 ht fboxht*2.0,
    shaded YellowGreen,
    "Correto" at Box.e above ljust;
    "Incompleto" at Box.w above rjust) with .S at 0.5 between B1.ne and B2.nw
  arrow from B1.E to (LT.S,B1.E) then to LT.S
  arrow from LT.W to (B1.N,LT.W) then to B1.N
  arrow from LT.E to (B2.N,LT.E) then to B2.N
  RT: Ftest("Avalia`'svg_ccedilla`'svg_atilde`'o da" \
    "Execu`'svg_ccedilla`'svg_atilde`'o",
    wid fboxwid*1.5 ht fboxht*2.0,
    shaded YellowGreen,
    "Correto" at Box.e below ljust;
    "Incompleto" at Box.w below rjust) with .N at 0.5 between B2.se and B3.sw
  arrow from B2.E to (RT.N,B2.E) then to RT.N
  arrow from RT.W to (B2.S,RT.W) then to B2.S
  arrow from RT.E to (B3.S,RT.E) then to B3.S
  B4: Fbox("Extra`'svg_ccedilla`'svg_atilde`'o") with .S at B3.N+(0,awid)
  arrow from B3.N to B4.S
  arrow up_ awid from B4.N
  B5: Fbox("Conclus`'svg_atilde`'o")
  arrow up_ awid from B5.N
  ellipse wid boxwid/2 ht boxwid/3 shaded "red"
] with .nw at last [].Compound.sw+(0,2.5*fboxht)

 command "</g>" # end font
.PE
