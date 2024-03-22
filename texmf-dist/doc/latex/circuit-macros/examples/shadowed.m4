.PS
# shadowed.m4
gen_init
NeedDpicTools
divert(-1)

divert(0)dnl

Boxes: [
movewid = movewid/2
B1: shadowed(,,
    rad=0bp__; shadowthick=lthick*4; shadowcolor="lightgray"; shadowangle=-60; \
    attrib=fill_(0.85) "box")

move
R: shadowed(box,, rad=6bp__; shadowthick=lthick*4; \
    attrib=wid boxht*2 shaded "orange" outlined "red" thick 2 \
    `"\tt box\char44\char44" "\tt rad=6bp\_\_"')

move
C: shadowed(circle,,
    shadowthick=lthick*4;shadowcolor="blue";\
      attrib=outlined "green" shaded "green" diam 0.75 "circle")

move
 E: shadowed(ellipse,,
     shadowthick=lthick*4; attrib=ht boxwid wid boxht shaded "yellow" \
     dashed "ellipse")

 b = boxht
 move to (E.e.x+b,E.s.y)
 F: shadowed(line,,
     attrib=left b then up b right b then down b right b then to Here \
       shaded "orange" outlined "red" thick 3;shadowthick=4.5bp__;\
       shadowangle=45)
    "line" at F.n+(0,-0.3)
]

Others:[
movewid = movewid*0.4

 cmyktorgb(96,0,0,0,r,g,b)
 ColoredV(circle,(r,g,b), rad 0.4 "Hello" outlined "cyan")

move
 s = 0.5; v = 0.8
 hsvtorgb(0,s,v,r0,g0,b0)
 hsvtorgb(90,s,v,r1,g1,b1)
 hsvtorgb(180,s,v,r2,g2,b2)
 ColoredV(box,((0,r0,g0,b0, 0.5,r1,g1,b1, 1,r2,g2,b2)),
   outlined "blue" rad 0.1 ht 2*boxht "Hmm...") 

move
 ColoredV(ellipse,(g,r,b),wid 0.75 ht 1 outlined "magenta" "OK")

move
 ColoredV(ellipse,,outlined "magenta" shaded "yellow" "Goodbye")
] with .nw at Boxes.sw #+(0,-moveht)

.PE
