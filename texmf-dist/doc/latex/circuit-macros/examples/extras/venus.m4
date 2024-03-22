.PS
# venus.m4
# https://tex.stackexchange.com/questions/576423/a-more-precise-dance-of-planets-with-metapost-and-tikz
# https://tex.stackexchange.com/questions/575986/dance-of-venus-and-variations-in-tikz-pgf

gen_init
NeedDpicTools
maxpsht = 20

thinlines_

define(`venus',
`setkeys_(`$1',
  outerlength:4;
  innerlength:2.8933;
  outerrate:8;
  innerrate:13;
  maxtimes:2880;
  increment:2;
  changephase:0 )
  sizefactor = 165/200
  nmaxtimes = 360*m4outerrate
  for x=0 to nmaxtimes by m4increment do {
    if "$2" != "" then { hue = \
        abs(sind(360*x/nmaxtimes*abs(m4innerrate-m4outerrate)+m4changephase-60))
      hsvtorgb(hue*360,1,1,r,g,b)
      line from (Rect_(m4outerlength,x))*sizefactor \
        to (Rect_(m4innerlength,x/m4outerrate*m4innerrate))*sizefactor \
        outlined rgbstring(r,g,b) } \
    else {
      line from (Rect_(m4outerlength,x))*sizefactor \
        to (Rect_(m4innerlength,x/m4outerrate*m4innerrate))*sizefactor
      }
    } ')

AA:[
  sizefactor = 1/2.54
  define(`venusA',`[
  setkeys_(`$1',
    iterations:270;
    outerdistance:5.41;
    innerdistance:7.48;
    outerperiod:123;
    innerperiod:200;
    step:5)
    for x=0 to m4iterations by m4step do {
      line from (Rect_(m4outerdistance,x))*sizefactor \
        to (Rect_(m4innerdistance,x/m4outerperiod*m4innerperiod))*sizefactor \
        outlined "gray"
      } 
    ]')
  
# 3 columns, 5 rows
  sizefactor /= 3
  Orig:(0,0)
  for i=1 to 5 do {
    iteri = 180 + (i-1)*540 
    for j=1 to 3 do {
      if (i==1) && (j==1) then { iter = 270 } \
      else { iter = iteri + (j-1)*180 }
      V[i,j]: venusA(iterations=iter) with .sw at Orig
      sprintf("%g",iter) at last [] #colored rgbstring(1,0,0)
      Orig: V[i,j].se
      }
    Orig: V[i,1].sw-(0,V[i,1].ht)
    }
  ]

BB:[
  venus(outerrate=8;innerrate=17;increment=2;innerlength=3.5;changephase=60,T)
  ] at AA
# ] with .nw at AA.sw+(0,-0.5)

.PE
