.PS
# ASME_Y14-5.m4
# https://en.wikipedia.org/wiki/Geometric_dimensioning_and_tolerancing
cct_init
sinclude(ASME_Y14-5.m4def)
sinclude(../ASME_Y14-5.m4def)
ifsvg(`svg_font(sans-serif,12bp__,3bp__)',
`textht = 11bp__*2/3
 iflatex(`command "{\sf"')')

 boxht = 7.5/0.5*textht
 boxwid = 15/7.5 * boxht
 circlerad = 2.3/0.5*textht*0.5
 thicklines_(1)
# ASME Y14.5 specs:
 arrowht = textht*0.8
 arrowwid = textht*0.6

 Box: box
 Circle: circle at Box.c; {CM: move from Circle.se down textht right textht}
thinlines_
CLU: ctrline( up_ Box.ht with .c at Box.c, Box.ht/2 )
CLH: ctrline( right Box.ht with .c at Box.c, Box.ht/2 )

 dimension_(from Box.nw to Box.n,Box.ht/6)
 thicklines_(1)
  {Y14_frame("10") with .s at AS_C+(0,textht/2)}
 thinlines_
 line from 3rd last line.start to CLU.end
 dimension_(from Box.w to Box.nw,Box.ht/6)
 thicklines_(1)
  {Y14_frame("5") with .e at AS_C+(-textht/2,0)}
 thinlines_
 line from 4th last line.start to CLH.start

thicklines_
 DA: Y14_frame("A") at Box.ne+(-textht*1.5,textht*5)
 datumarrow(from DA.s to (DA,Box.n)) 
 DB: Y14_frame("B") at Box.sw+(-textht*5,textht*2)
 datumarrow(from DB.e to (Box.w,DB)) 

 F: Y14_frame(Y14_pos_,
      Y14_dia_;"0.03";"(M)",
      "A","B","C") with .w at Box.se+(-textht*4,-textht*2)
 G: Y14_frame(Y14_fla_,Y14_cyl_,Y14_lin_,
              Y14_sur_,Y14_per_,Y14_ang_,
              Y14_par_) with .nw at F.sw+(0,-0.1)
 H: Y14_frame(Y14_pos_,Y14_cir_,Y14_tot_,Y14_dia_) \
      with .nw at G.sw+(0,-0.1)

 { CB: move left textht from F.w }
 arrow <- from Circle.se to Intersect_(CM,CB) then to F.w

command iflatex(`"}"',ifsvg(`"</g>"'))
.PE
