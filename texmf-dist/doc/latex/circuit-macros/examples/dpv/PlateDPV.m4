.PS
# ASME_Y14-5.m4
# https://en.wikipedia.org/wiki/Geometric_dimensioning_and_tolerancing
# See the ASME Y14.5 standard, Figure 6-30. 
scale = 100/3
cct_init
include(../ASME_Y14-5.m4def)
ifsvg(`svg_font(sans-serif,9.5bp__)',
`textht = 10bp__*2/3
 iflatex(`command "{\sf"')')
# ASME Y14.5 specs:
 arrowht = textht*0.8
 arrowwid = textht*0.6
 maxpswid = 12

#                           Diameters
 d1 = (20.13+20.00)/2
 d2 = 31.7
 d3 = 36
 d4 = (40.60+40.45)/2
 d5 = 57
 d6 = 86
 d7 = 100
 d8 = 8.0
 adj = 1.5

Section: [
 Orig: (0,0)
 T0: (0,-d7/2)
 T1: (6,-d5/2)
 T2: (15.5,-d3/2)
 T3: (22,-d3/2-adj)
 T4: (32,-d2/2)
 T5: (41.3,0)
 T6: (9.5,-d4/2)
# for_(0,5,1,`"m4x" at T`'m4x')
#                           Hatching
 H: hatchbox(invis ht d7 wid 41.3,2,thick 0.4,-45) with .w at Orig
 box invis fill_(1) wid T5.x-T1.x ht T1.y-H.s.y with .se at H.se
 box same with .ne at H.ne
 box invis fill_(1) wid T3.x-T2.x ht T2.y-T1.y with .nw at T2
 box same with .sw at (T2.x,-T2.y)
 box invis fill_(1) wid T4.x-T3.x ht T3.y-T1.y with .nw at T3
 box same with .sw at (T3.x,-T3.y)
 box invis fill_(1) wid T5.x-T4.x ht T4.y-T1.y with .nw at T4
 box same with .sw at (T4.x,-T4.y)
#                           Section outline lower
 line from (0,-d4/2) to T0 then right T1.x-T0.x then up 1
 arcto(T1,(T2,T1),1)
 line to (T2,T1) then up 1
 arcto(T2,(T3,T2),1)
 arcto((T3,T2),T3,0.5)
 arcto(T3,(T4,T3),0.5)
 arcto((T4,T3),T4,1)
 arcto(T4,(T5,T4),1)
 line to (T5,T4) then to (T5.x,-T4.y) then left 1
#                           Section outline upper
 line from (0,d4/2) to (0,-T0.y) then right T1.x-T0.x then down 1
 arcto((T1.x,-T1.y),(T2.x,-T1.y),1)
 line to (T2.x,-T1.y) then down 1
 arcto((T2.x,-T2.y),(T3.x,-T2.y),1)
 arcto((T3.x,-T2.y),(T3.x,-T3.y),0.5)
 arcto((T3.x,-T3.y),(T4.x,-T3.y),0.5)
 arcto((T4.x,-T3.y),(T4.x,-T4.y),1)
 arcto((T4.x,-T4.y),(T5.x,-T4.y),1)
 line to (T5.x,-T4.y)

 box wid 6 ht d8 fill_(1) with .w at (0,d6/2)
 box wid 6 ht d8 fill_(1) with .w at (0,-d6/2)
 box invis wid T6.x ht d4 fill_(1) with .w at Orig
 box wid T5.x-T6.x ht d1 fill_(1) with .e at T5

 line from (Orig.x,-T6.y) to (Orig.x,T6.y)
 arcto(T6,(T6,Orig),1)
 arcto((T6.x,-T6.y),(0,-T6.y),1)
 line to (0,-T6.y) 

define(`dialabel',
`[tmpthick = linethick; linethick_(1)
  [Y14_dia_]; [$1 wid ifelse(`$2',,textht,`$2')] with .w at last [].e+(0.5,0)
  linethick_(tmpthick)]')

thinlines_
 dimension_(from (0,T6.y) to (0,-T6.y),40,dialabel("40.60" "40.45",12),textht*3)
 line up 4 from AE_dimen_.end
 Y14_frame(Y14_per_,Y14_dia_;"0";"(M)","A") with .sw at Here
 Y14_frame("B") with .s at last [].n+(0,6)
thicklines_(1)
 datumarrow(from last [].s to 2nd last [].n)
thinlines_
 dimension_(from T2 to (T2.x,-T2.y),30,
   dialabel("35.5" "36.0",12),textht*3)
 dimension_(from T0 to T0+(T1.x,0),-8," 6.1 " " 5.9 ",textht)
 dimension_(from S_dimen_.end to S_dimen_.end+(T2.x,0),-9,
   "15.4" "15.6",textht*4)
   line from E_dimen_.start to (T2,T1) chop 0 chop 1
 dimension_(from S_dimen_.end to S_dimen_.end+(T3.x,0),-9,
   "21.9" "22.1",textht*4)
   line from E_dimen_.start to T3 chop 0 chop 1
 dimension_(from S_dimen_.end to S_dimen_.end+(T4.x,0),-9,
   "31.9" "32.1",textht*4)
   line from E_dimen_.start to (T4,T3) chop 0 chop 1
 dimension_(from S_dimen_.end to S_dimen_.end+(T5.x,0),-9,
   "41.2" "41.4",textht*4)
   line from E_dimen_.start to (T5,T4) chop 0 chop 1
   line from S_dimen_.start to T0 chop 0 chop 1
 dimension_(from (0,d7/2) right T6.x,8,"9.6" "9.4",3*textht)
   line from E_dimen_.start to (T6.x,d4/2) chop 0 chop 1
 ctrline(from (-3,0) to T5+(3,0),T5.x/2)
 ctrline(from (-3,d6/2) right T1.x+6)
 ctrline(from (-3,-d6/2) right T1.x+6)
 dimension_(from T5-(0,d1/2) to T5+(0,d1/2),-14,
  dialabel("20.13" "20.00",4*textht),textht*3)
 dimension_(from T5-(0,d2/2) to T5+(0,d2/2),-35,
  dialabel("31.8" "31.6",3*textht),textht*3)
 arrow <- from (T5.x+6,d1/2) by (Rect_(20,75)) then right 6
 Y14_frame(Y14_cir_,"0.06" wid 3*textht,"A","B") with .w at Here
 Y14_frame("C") with .n at last [].se+(-6,-8)
thicklines_(1)
 datumarrow(from last [].n up 8)
thinlines_
 arrow <- from (T5.x+6,-d2/2) by (Rect_(10,-75)) then right 4
 Y14_frame(Y14_cir_,"0.1" wid textht*2,"C") with .w at Here
 arrow <- from ((T3.x+T4.x)/2,d3/2+adj) by (Rect_(30,75)) then right 4
 "M42 X 1.5 - 6g" wid 9*textht ljust
 Y14_frame(Y14_pos_,Y14_dia_;"0.1" wid textht*2;"(M)","C";"(M)") \
   with .nw at last "".sw+(0,-2)
 line from (T2.x,-T1.y) up 25 chop 1 chop 0
 Y14_frame(Y14_par_,"0.06" wid 3*textht,"A") with .sw at Here
 Y14_frame(Y14_sur_,"  0.1 " wid 3*textht,"A") with .sw at last [].nw
 arrow <- from (0,-d6/2+10) left 13
 Y14_frame(Y14_fla_,"0.02" wid 4*textht) with .e at Here
 Y14_frame("A") with .n at last [].s+(0,-6)
 datumarrow(from last [].n up 6)
 ]

Topview:[
 C: circle diam d7
 for i=0 to 7 do { circle diam d8 at C+(Rect_(d6/2,i/8*360)) }
 C5: circle diam d5 at C
 C4: circle diam d3+2*adj at C
 C3: circle dashed diam d3 at C
 C2: circle diam d2 at C
 C1: circle diam d1 at C

thinlines_
 dimension_(from C.w-(0,10) to C.e-(0,10),-C.rad-15,
   dialabel("100" "99",textht*3),textht*5)
 dimension_(from C5.w-(0,5) to C5.e-(0,5),-C.rad-5,
   dialabel("57.2" "56.8",textht*4),textht*5)
 arrow <-> from C+(Rect_(d6/2,-120)) to C+(Rect_(d6/2,60))
 line from last arrow.end to C+(Rect_(d7/2+6,60)) then right 4
   dialabel("86.2" "85.8",textht*4) with .w at Here+(1,0)
 ctrline(from (C.x-(d6-d7/2),C.y) to (C.x+(d6-d7/2),C.y))
 ctrline(from (C.x,C.y-d6/2+d8/2) to (C.x,C.y+d6/2-d8/2))
 for_(0,315,45,`ctrarcr(C,d6/2,(m4x-22.5)*dtor_,(m4x+22.5)*dtor_)
  ctrline(from C+(Rect_(d6-d7/2,m4x)) to C+(Rect_(d7/2,m4x))) ')
 arcdimension_(from C+(0,d7/2) to C+(Rect_(d7/2,135)) with .c at C,
   8,"8X 45`'iflatex($^\circ$)" wid textht*3.5,15,1)
 ifsvg("svg_deg" wid textht*2/3 with .w at last "".e)
 move to C+(0,d6/2)
 arrow <- from Here+(Rect_(8/2,75)) to Here+(Rect_(25,75)) then right_ 3
 "8X" wid 2*textht ljust
 linethick_(1); [Y14_dia_] with .w at last "".e+(1,0)
 "7.9 - 8.1" wid 8*textht ljust
 Y14_frame(Y14_pos_,Y14_dia_;"0.14" wid 3*textht;"(M)","A","C") \
   with .nw at 2nd last "".sw+(0,-2)

 ] with .C at Section.Orig+(4.5*scale,0)


command iflatex(`"}"',ifsvg(`"</g>"'))
.PE
