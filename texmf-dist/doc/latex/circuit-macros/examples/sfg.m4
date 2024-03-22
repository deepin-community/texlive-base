.PS
# sfg.m4
sfg_init( 1.2 )   # default edge length = 1.2

  iflatex(`textoffset = 1bp__; ifpsfrag(`textht = 9.5bp__',
          `latexcommand({\small)') ')

[
# Graph 1
T:[
 Ft: sfgnode(,f(t),sfgbelow,shaded "red")
     sfgline(,1/K)
 Y1: sfgnode(,y_1,sfgbelow rjust)
     sfgline(,K/M)
 DDY2: sfgnode(,\ddot{y}_2,sfgbelow rjust)
     sfgline(,s^{-1})
 DY2: sfgnode(,\d`'ot{y}_2=x_2,sfgbelow ljust) dnl dot is an m4 macro
     sfgline(,s^{-1})
 Y2: sfgnode(,y_2=x_1,sfgbelow ljust,shaded "green")
 
 sf = 1
   sfgarc(from DY2 to DDY2,-B/M,below,,sf,outlined "gray")
   sfgarc(from Y2 to DDY2,-K/M,above,ccw,sf,outlined "gray")
   sfgarc(from Y2 to Y1,1,sfgabove,,sf,outlined "gray")
 ]
#showbox_(,"T")

# Graph 2
B: [
 R1: sfgnode(,r_1,sfgabove)
     sfgline(,1)
 X1: sfgnode(,\;x_1,ljust)
 R2: sfgnode(at R1+(0,-1),r_2,sfgabove)
     sfgline(,1)
 X2: sfgnode(,\;x_2,ljust)
     sfgarc(from X1 to X2,a_{21}\;,rjust,ccw)
     sfgarc(from X2 to X1,\;a_{12},ljust,ccw)
 
     sfgself(at X1,,q_{11})
     sfgself(at X1,R,\;a_{11},ljust,cw,1.5)
     sfgself(at X2,-90,a_{22},sfgbelow)
 ] with .w at T.e + (linewid/2,-linewid/4)
#showbox_(,"B")

# Graph 3
G3: [#sfg_init( 0.85,0.35/2 )   # change node spacing and size
  sfg_wid = 0.85
  sfg_rad = 0.35/2
  NeedDpicTools
 cmyktorgb(96,0,0,0,r,g,b)
 for_(1,4,1,`N`'m4x: ColoredV(circle,(r,g,b),"m4x" rad sfg_rad)
   sfgself(at N`'m4x,-90,P_{m4x},,cw)
   ifelse(m4x,4,,`sfgline(,G_{m4x},sfgbelow)') ')
 sfgarc(from N2 to N1,F_2,sfgabove,ccw,)
 sfgarc(from N3 to N1,F_3,sfgbelow,ccw,1.4)
] with .nw at T.sw
#showbox_(,"G3")

A: [#sfg_init( 0.75,0.15 )
  sfg_wid = 0.75
  sfg_rad = 0.15
   arrow right linewid*2/3
 P: sfgnode(,p)
   sfgself(,90,a,sfgbelow,cw)
   arrow from P.e "b" below
 Q: sfgnode(,q)
 R: sfgnode(at Q+(Q.x-P.x,Q.y-P.y),r) # for gpic
   sfgarc(from Q to R,c,sfgabove,cw)
   sfgarc(from R to Q,d,sfgbelow,cw)
   sfgself(at R,-90,e,sfgabove,cw)
   arrow right linewid*2/3 from R.e
 ] with .w at G3.e+(linewid/2,0)
#showbox_(,"A")

G4: [sfg_init( 2.0,0.25/2 )   # change node spacing and size
 s1 = 0.9
 s2 = 1.2
 N0: sfgnode(,\hbox{\Large 0},,invis)
   sfgline(right_ sfg_wid,\nu,below,->)
 N1: sfgnode(,\hbox{\Large 1},,invis)
 { sfgarc(to N0 ->,(1{-}p)\gamma{+}\nu,above,ccw,s1) } 
 sfgline(right_ sfg_wid,\nu+\lambda,below,->)
 N2: sfgnode(,\hbox{\Large 2},,invis)
 { sfgarc(to N1 ->,{{2}\choose{1}}p(1{-}p)\gamma{+}2\nu,above,ccw,s1) } 
 { sfgarc(to N0 ->,(1{-}p)^2\gamma,above,ccw,s2) } 
 sfgline(right_ sfg_wid,\nu+2\lambda,below,->)
 N3: sfgnode(,\hbox{\Large 3},,invis)
 { sfgarc(to N2 ->,{{3}\choose{2}}p^2(1{-}p)\gamma{+}3\nu,above,ccw,s1) } 
 { sfgarc(to N1 ->,{{3}\choose{1}}p(1{-}p)^2\gamma,above,ccw,1.2) } 
 { sfgarc(to N0 ->,(1{-}p)^3\gamma,above,ccw,s2) } 
 sfgline(right_ sfg_wid/2,\nu+3\lambda,below,->)
 {"$\ldots$" wid 0.3 ljust}
 ] with .nw at G3.sw+(0,-0.15)
#showbox_(,"G4")

# https://tex.stackexchange.com/questions/637455/tikz-how-to-set-exact-position-of-node
G5: [sfg_init( 1.75,0.25/2 )   # change node spacing and size
 Dstar: sfgnode(,*,,shaded "green")
 D0: sfgnode(at Dstar+(2,0),\diamond_0,,shaded "green")
 sfgline(,`1-r_{x{-}1,x}-q^i_{x{-}1,x}',,->)
 Ddots: sfgnode(,\cdots,,shaded "green")
 sfgline(,`1-r_{x{-}4,x}-q^i_{x{-}4,x}',,->)
 D5: sfgnode(,\diamond_5,,shaded "green")
 DD: sfgnode(at D0+(0,-1.0),\dagger,,shaded "green")
 sfgself(at Dstar,L,,,,0.5)
 "$`1-i_x-q^a_x'$" wid 45bp__ at Dstar + (-0.3,0.25)
 sfgself(at DD,D,1\mathstrut,above_,,0.5)
 sfgself(at D5,R,,,,0.5)
 "$`1-q^i_x-r_x'$" wid 47bp__ at D5 + (0.3,0.25)
 sfgarc(from D0 to Dstar ->,`r_{x,x}\mathstrut',below_,ccw)
 sfgarc(from Dstar to D0 ->,`i_x\mathstrut',above_,ccw)
 sfgarc(from Dstar to DD ->,`q^a_x\mathstrut',above_ ljust_,ccw)
 sfgline(from D0 to DD,`\;q^i_{x,x}',ljust,->)
 sfgarc(from Ddots to Dstar,`r_{j,x}\mathstrut',below_,ccw,,->)
 sfgarc(from Ddots to DD ->,`q^i_{x{-}j,x}\mathstrut',above_ rjust_,)
 sfgarc(from D5 to Dstar ->,`r_x\mathstrut',below_,ccw)
 sfgarc(from D5 to DD ->,`q^i_x\mathstrut',above_ rjust_,)
 ] with .nw at G4.sw+(0,-0.15)
#howbox_(,"G5")

 move from (T.w,G4.s)-(7bp__,6bp__) to B.ne+(15bp__,6bp__)
]
#showbox_

  iflatex(ifpsfrag(,`latexcommand(})'))
.PE
