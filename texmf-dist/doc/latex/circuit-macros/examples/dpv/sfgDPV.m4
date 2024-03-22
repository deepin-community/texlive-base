.PS
# sfgDPV.m4
gen_init(svg_font(Times,11bp__))
sfg_init( blen=1.2 )   # default edge length

textht = textht*0.9
define(`celadon',`0.67,0.88,0.69')dnl

# Graph 1
move right 0.15
T:[
 Ft: sfgnode(,f(t),sfgbelow,shaded "red")
     sfgline(,1/K)
 Y1: sfgnode(,y`'svg_sub(1),sfgbelow rjust)
     sfgline(,K/M)
 DDY2: sfgnode(,y`'svg_sub(2),sfgbelow rjust)
     {".." at DDY2 +(-3,-1)*textoffset}
     sfgline(,1/s)
 DY2: sfgnode(,y`'svg_sub(2) = x`'svg_sub(2),sfgbelow ljust)
     {"." at DY2 +(2,-1)*textoffset}
     sfgline(,1/s)
 Y2: sfgnode(,y`'svg_sub(2) = x`'svg_sub(1),sfgbelow ljust,
      shaded rgbstring(celadon))
 
 sf = 1
   sfgarc(from DY2 to DDY2,-B/M,below,,sf,outlined "gray")
   sfgarc(from Y2 to DDY2,-K/M,above,ccw,sf,outlined "gray")
   sfgarc(from Y2 to Y1,1,sfgabove,,sf,outlined "gray")
 ]

# Graph 2
B: [
 R1: sfgnode(,r`'svg_sub(1),sfgabove)
     sfgline(,1)
 X1: sfgnode(,x`'svg_sub(1),ljust)
 R2: sfgnode(at R1+(0,-1),r`'svg_sub(2),sfgabove)
     sfgline(,1)
 X2: sfgnode(,x`'svg_sub(2),ljust)
     sfgarc(from X1 to X2,a`'svg_sub(21),rjust,ccw)
     sfgarc(from X2 to X1,a`'svg_sub(12),ljust,ccw)
 
     sfgself(at X1,,q`'svg_sub(11))
     sfgself(at X1,R,a`'svg_sub(11),ljust,cw,1.5)
     sfgself(at X2,-90,a`'svg_sub(22),sfgbelow)
 ] with .w at T.e + (linewid/2,-linewid/4)

# Graph 3
G3: [
  # change node spacing and increase node size
  sfg_wid = 0.85; sfg_rad = 0.35/2
  NeedDpicTools
  cmyktorgb(96,0,0,0,r,g,b)
  for_(1,4,1,`N`'m4x: ColoredV(circle,(r,g,b),rad sfg_rad "m4x")
   sfgself(at N`'m4x,-90,P`'svg_sub(m4x),,cw)
   ifelse(m4x,4,,`sfgline(,G`'svg_sub(m4x),sfgbelow)') ')
 sfgarc(from N2 to N1,F`'svg_sub(2),sfgabove,ccw,)
 sfgarc(from N3 to N1,F`'svg_sub(3),sfgbelow,ccw,1.4)
] with .nw at T.sw

A: [ sfg_wid = 0.75; sfg_rad = 0.15
   arrow right linewid*2/3
 P: sfgnode(,p)
   sfgself(,90,a,below,cw)
   arrow from P.e "b" below
 Q: sfgnode(,q)
 R: sfgnode(at Q+(Q-P),r) # for dpic
   sfgarc(from Q to R,c,above,cw)
   sfgarc(from R to Q,d,below,cw)
   sfgself(at R,-90,e,above,cw)
   arrow right linewid*2/3 from R.e
 ] with .w at G3.e+(linewid/2,0)

define(`svg_choose',`[ P:"svg_fsize(( ),150)"
  "svg_small(`$1')" at P+(0,7bp__)
  "svg_small(`$2')" at P-(0,3bp__)
  ]')

G4: [sfg_init( blen=2;rad=0.25/2 )   # change node spacing and size
 s1 = 0.9
 s2 = 1.2
 N0: sfgnode(,svg_fsize(0,120),,invis)
   sfgline(right_ sfg_wid,`svg_nu',below,->)
 N1: sfgnode(,svg_fsize(1,120),,invis)
 { sfgarc(to N0 ->,(1-p)`svg_gamma'+`svg_nu',above,ccw,s1) } 
 sfgline(right_ sfg_wid,`svg_nu'+`svg_lambda',below,->)
 N2: sfgnode(,svg_fsize(2,120),,invis)
 { sfgarc(to N1 ->,,,ccw,s1) } 
   { "p(1-p)svg_gamma+2`'svg_nu" at last [].M+(11bp__,0) above }
   { svg_choose(2,1) at last [].M+(-19bp__,8bp__) }
 { sfgarc(to N0 ->,(1-p)svg_sup(2)`svg_gamma',above,ccw,s2) } 
 sfgline(right_ sfg_wid,`svg_nu'+2`svg_lambda',below,->)
 N3: sfgnode(,svg_fsize(3,120),,invis)
 { sfgarc(to N2 ->,,,ccw,s1) } 
   { "p`'svg_sup(2)(1-p)svg_gamma+3`'svg_nu" at last [].M+(0bp__,0) above }
   { svg_choose(3,2) at last [].M+(-33bp__,8bp__) }
 { sfgarc(to N1 ->,,,ccw,s2) } 
   { "p(1-p)`'svg_sup(2)`'svg_gamma" at last [].M+(8bp__,0) above }
   { svg_choose(3,1) at last [].M+(-16bp__,8bp__) }
 { sfgarc(to N0 ->,(1-p)svg_sup(3)`svg_gamma',above,ccw,s2) } 
 sfgline(right_ sfg_wid*2/3,`svg_nu'+3`svg_lambda',below,->)
 {"..." wid 0.3 ljust}
 ] with .nw at G3.sw+(0,-0.1)

# https://tex.stackexchange.com/questions/637455/tikz-how-to-set-exact-position-of-node
G5: [sfg_init( blen=1.75;rad=0.25/2 )   # change node spacing and size
 Dstar: sfgnode(,*,,shaded rgbstring(celadon))
 D0: sfgnode(at Dstar+(2,0),svg_small(&lt;&gt;)svg_sub(0),,
       shaded rgbstring(celadon) )
 sfgline(,
  svg_it(1-r`'svg_sub(`x-1`'svg_comma`'x')-q`'svg_sup(i)svg_sub(x-1`'svg_comma`'x,,,-0.8ex)),,->)
 Ddots: sfgnode(,...,,shaded rgbstring(celadon) )
 sfgline(,svg_it(1-r`'svg_sub(x-4`'svg_comma`'x)-q`'svg_sup(i)svg_sub(x-4`'svg_comma`'x,,,-0.8ex)),
  ,->)
 D5: sfgnode(,svg_small(&lt;&gt;)svg_sub(5),,shaded rgbstring(celadon) )
 DD: sfgnode(at D0+(0,-1.0),svg_symbol(&``#''8224;),,
       shaded rgbstring(celadon) )
 sfgself(at Dstar,L,,,,0.5)
 "svg_it(1-i`'svg_sub(x)-q`'svg_sub(x)svg_sup(a,,,-0.8ex))" wid 45bp__ \
   at Dstar + (-0.3,0.25)
 sfgself(at DD,D,1,above_,,0.5)
 sfgself(at D5,R,,,,0.5)
 "svg_it(1-q`'svg_sub(x)svg_sup(i,,,-0.8ex)-r`'svg_sub(x))" wid 47bp__ \
   at D5 + (0.3,0.25)
 sfgarc(from D0 to Dstar ->,svg_it(r`'svg_sub(x`'svg_comma`'x)),below_,ccw)
 sfgarc(from Dstar to D0 ->,svg_it(i`'svg_sub(x)),above_,ccw)
 sfgarc(from Dstar to DD ->,svg_it(q`'svg_sub(x)svg_sup(a,,,-0.8ex)),
  above_ ljust_,ccw)
 sfgline(from D0 to DD,svg_it(q`'svg_sup(i)svg_sub(x`'svg_comma`'x,,,-0.8ex)),ljust,->)
 sfgarc(from Ddots to Dstar,svg_it(r`'svg_sub(j`'svg_comma`'x)),below_,ccw,,->)
 sfgarc(from Ddots to DD ->,svg_it(q`'svg_sup(i)svg_sub(x-j`'svg_comma`'x)),
   above_ rjust_,)
 sfgarc(from D5 to Dstar ->,svg_it(r`'svg_sub(x)),below_,ccw)
 sfgarc(from D5 to DD ->,svg_it(q`'svg_sup(i)svg_sub(x,,,-0.8ex)),
   above_ rjust_,)
 ] with .nw at G4.sw+(0,-0.15)
#howbox_(,"G5")


 move from (T.w,G4.s)-(7bp__,6bp__) to B.ne+(15bp__,6bp__)
 command "</g>" # end font
.PE
