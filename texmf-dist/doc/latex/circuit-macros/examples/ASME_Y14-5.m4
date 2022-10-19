divert(-1)
#                                   `datumarrow(linespec,wid,ht)'
define(`datumarrow',`line `$1'
  M4_E: last line.end
  datum_ht = ifelse(`$3',,`textht',`$3')
  M4_P: vperp(last line,(datum_ht*2/sqrt(3)))
  M4_X: datum_ht/lin_leng(last line) between M4_E and last line.start 
  {ifsvg(,`m4fshade(m4fill,')line from M4_E to M4_E+M4_P/2 dnl
     then to M4_X then to M4_E-M4_P/2 then to M4_E ifsvg(`fill_(0)',`)')}')

#                          `Y14_frame( arg1, arg2, ... )
                             Each arg is a ;-separated sequence of 1 or more of
                               "string"[ wid val],
                               "(letter)",
                               or tolerance symbol.
                             The term "(letter)" expands to the circled letter.
                             The frame contains as many boxes as arguments.'
                            `Symbol definitions from ASME Y14.5 Appendix C'
define(`Y14_frameht',`textht*2')
define(`Y14_defaultwid',`textht*2')
#
define(`Y14_frame',`[ tmpthick = linethick; thicklines_
  right_; B:[ Y14_fram_($@) ]
  box wid B.wid ht Y14_frameht at B
  linethick = tmpthick ]')
define(`Y14_fram_',`ifelse(`$1',,,
`stacksplit_(`Y14',`$1',;) stackreverse_(`Y14')
 Bx: [stackdo_(`Y14',
 `[ifelse(index(Y14,`"('),0,
    `circle diam textht*5/3
     patsubst(Y14,`"(\(.\))"',`"\1"') ht textht*0.8 at last circle',
   index(Y14,`"'),0,
    `Y14 ifinstr(Y14,`wid ',,`wid textht*2/3*(len(Y14)-2)')',
   `Y14')]
   move right max(last [].wid+textht/2,Y14_defaultwid) with .c at last []; ')]
 ifelse(`$2',,,`{ line up Y14_frameht with .c at Here }')
 Y14_fram_(shift($@))') ')

#                           Each symbol definition has an abbreviated version
define(`Y14_straightness',
`line right textht*2 ')
define(`Y14_str_',`Y14_straightness($@)')

define(`Y14_flatness',
`line right textht*3/4 then down textht left textht/2 \
   then left textht*3/2 then up textht right textht/2 \
   then right textht*3/4 ')
define(`Y14_fla_',`Y14_flatness($@)')

define(`Y14_circularity',`circle diam textht*3/2 ')
define(`Y14_cir_',`Y14_circularity($@)')

define(`Y14_cylindricity',
`circle diam textht
 Y14_C: last circle
 Y14_R: (Rect_(last circle.rad,-30))
 Y14_A: (Rect_(textht,60))
 line from Y14_C+Y14_R+Y14_A to Y14_C+Y14_R-Y14_A/2
 line from Y14_C-Y14_R-Y14_A to Y14_C-Y14_R+Y14_A/2 ')
define(`Y14_cyl_',`Y14_cylindricity($@)')

define(`Y14_lineprofile',`arc from (textht,0) to (-textht,0) with .c at Here ')
define(`Y14_lin_',`Y14_lineprofile($@)')

define(`Y14_surfaceprofile',
`arc from (textht,0) to (-textht,0) with .c at Here
 line from last arc.start to last arc.end ')
define(`Y14_sur_',`Y14_surfaceprofile($@)')

define(`Y14_perpendicularity',
`line from (-textht,0) to (textht,0)
 line from (0,0) to (0,textht*3/2) ')
define(`Y14_per_',`Y14_perpendicularity($@)')

define(`Y14_angularity',
`line from (textht*3/2,0) to (0,0) then to (textht*3/2,textht*sqrt(3)/2) ')
define(`Y14_ang_',`Y14_angularity($@)')

define(`Y14_parallelism',
`line up textht*3/2*sqrt(3)/2 right textht*3/4
 move right textht*0.6
 line down textht*3/2*sqrt(3)/2 left textht*3/4 ')
define(`Y14_par_',`Y14_parallelism($@)')

define(`Y14_symmetry', dnl obsolete!
`line from (-textht/2,0) to (textht/2,0)
 line from (-textht/3,textht/4) to (textht/3,textht/4)
 line from (-textht/3,-textht/4) to (textht/3,-textht/4) ')
define(`Y14_sym_',`Y14_symmetry($@)')

define(`Y14_position',
`circle diam textht
 line up    textht*3/2 with .c at last circle
 line right textht*3/2 with .c at last circle ')
define(`Y14_pos_',`Y14_position($@)')

define(`Y14_concentricity', dnl obsolete!
`circle diam textht
 circle diam textht/2 at last circle ')
define(`Y14_con_',`Y14_concentricity($@)')

define(`Y14_circularrunout',
`arrow ht textht*0.8 wid textht*0.6 up textht*3/2 right textht*3/2 ')
define(`Y14_cir_',`Y14_circularrunout($@)')

define(`Y14_totalrunout',
`arrow <-> ht textht*0.8 wid textht*0.6 \
 down textht*3/2 left textht*3/2 then right textht*1.1 \
 then up textht*3/2 right textht*3/2 ')
define(`Y14_tot_',`Y14_totalrunout($@)')

define(`Y14_diameter',
`circle diam textht
 line up textht*3/2 right textht*3/4 with .c at last circle')
define(`Y14_dia_',`Y14_diameter($@)')

#                             The following are not Y14.5 but go well with them:

                             `r_box(angle,pos,string)
                              Rotated text on a white background
                              (requires pstricks)'
define(`r_box',
 `ifpstricks(`M4tmp: ifelse(`$2',,Here,`$2')
  command sprintf("\rput{%g}(%g,%g){",`$1',crl(M4tmp.x),crl(M4tmp.y))
  f_box(`$3') at Orig
 command "}%"')')
define(`crl',`int(`($1)'/scale*1000000)/1000000')

                             `r_dimen(linespec,offset,label,tic offset,<->,pos)
                              dimension_ with rotated text on white background'
define(`r_dimen',
 `M4tmp: dimension_(`$1',`$2',,,`$4',`$5')
  r_box(rp_ang*rtod_,ifelse(`$6',,M4tmp+vec_(0,`$2'),`$6'),`$3')')

                             `ctrline(linespec,cycle len)
                              Centerline'
define(`cdashl',0.1*scale)
define(`cgapl',0.03*scale)
define(`ctrline',`rpoint_(ifelse(`$1',,`to rvec_(linewid,0)',`$1'))
  define(`m4h',ifelse(`$2',,1*scale,`$2'))dnl
  m4n = int(rp_len/2/(m4h))*2+1
  for i=1 to m4n do {
    line to rvec_(rp_len/m4n/2-cdashl/2-cgapl,0)
    move to rvec_(cgapl,0); line to rvec_(cdashl,0); move to rvec_(cgapl,0)
    line to rvec_(rp_len/m4n/2-cdashl/2-cgapl,0) } ')

                             `ctrarcr(pos,radius,startang,endang,len)
                              Arc cr centerline'
define(`ctrarcr',`dnl
  define(`m5h',ifelse(`$5',,1*scale,`$5'))dnl
  rp_len = abs((`$2')*(`$4'-(`$3')))
  m5n = int(rp_len/2/(m5h))*2+1
  m5a = (rp_len/m5n/2-cdashl/2-cgapl)/(`$2')
  m5s = cdashl/(`$2')
  m5sa = `$3'
  for m4irr=1 to m5n do {
    arc from `$1'+(rect_(`$2',m5sa)) to `$1'+(rect_(`$2',m5sa+m5a)) \
      with .c at `$1'
    m5sa = m5sa+m5a+cgapl/(`$2')
    arc from `$1'+(rect_(`$2',m5sa)) to `$1'+(rect_(`$2',m5sa+m5s)) \
      with .c at `$1'
    m5sa = m5sa+m5s+cgapl/(`$2')
    arc from `$1'+(rect_(`$2',m5sa)) to `$1'+(rect_(`$2',m5sa+m5a)) \
      with .c at `$1'
    m5sa = m5sa+m5a
    } ')

divert(0)dnl
