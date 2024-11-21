.PS
# person.m4
gen_init

divert(-1)
                                    `person(
                                       hght=expr;wdth=expr;fill="colorname")
                                     e.g. person(hght=1;fill="gray")'
define(`person',
 `[ pushkeys_(`$1',hght:linewid;wdth:m4hght*2/5;fill:"black":N)dnl
  bodywid = m4wdth/2
  bodyrad = bodywid/8
  bodyht = (m4hght - bodywid - bodywid/16 + bodyrad*2)/2
  tmplth = linethick; linethick = 0
  Head: circle diam bodywid colored m4fill
  Body: box rad bodyrad ht bodyht wid bodywid colored m4fill  \
   with .n at Head.s+(0,-Head.diam/16)
  armwid = bodywid/3
  Armleft: box wid armwid rad armwid/2 ht Body.ht-bodyrad colored m4fill \
    with .w at Body.e + (armwid/2,0) 
  Armright: box same with .e at Body.w + (-armwid/2,0) 
  Legleft: box wid bodywid/2.5 rad armwid/2 ht Body.ht colored m4fill \
    with .n at (Body.w,Body.s)+(bodywid/5,bodyrad*2)
  Legright: box same with .n at (Body.e,Body.s)+(-bodywid/5,bodyrad*2)
  linethick_(tmplth) popdef(`m4hght',`m4wdth',`m4fill') ]')

divert(0)dnl

  linewid = 3*linewid
  movewid = 0.2

  setrgb(0.54,0.81,0.94,babyblue)
  person(fill="babyblue")
  move
  person(wdth=linewid*3/4;fill="babyblue")
  move
  person(wdth=linewid;fill="babyblue")
  move
  person
  move
  resetrgb
  person(hght=1;fill="gray")

  line up linewid with .c at last [].e+(linewid/10,0)
.PE
