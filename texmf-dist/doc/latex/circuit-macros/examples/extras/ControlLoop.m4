.PS
# ControlLoop.m4
# https://tex.stackexchange.com/questions/636839/how-to-draw-multi-blocks-block-diagram 
gen_init
scale = 25.4

 boxwid = 18
 boxrad = 3
 define summer { $1: circle diam 10 fill_(0.8)
  { line from $1.ne to $1.sw; line from $1.nw to $1.se }
  { "$+$" at $1.nw rjust } }

 TPG: box ht 22 shaded "Peach" "Transient" "Profile" "Generator" 
  arrow <- left_ 8 from TPG.w "r" above
  arrow right_ 10 from TPG.e+(0,TPG.ht/4) "$r_1$" above
  summer(S1)
  line right_ 10 from TPG.e+(0,-TPG.ht/4) "$r_2$" above
  arrow right_ S1.diam
  summer(S2)
  arrow right_ 10 from S2.e "$e_2$" above
  arrow from S1.e to (Here,S1) "$e_1$" above
 NLSF: box ht 22 "Nonlinear" "State Error" "Feedback" shaded "lime" \
  with .w at (Here,TPG)
  arrow right_ 10 "$u_o$" below
  summer(S3)
 {ESO: box ht 30 shaded "Goldenrod" "Extended" "State" "Observer" \
  with .w at (Here.x+5,NLSF.s.y-15) } 
  arrow right_ 40
 P: box ht 15 shaded "blue!50!white!50" "Plant"
  arrow right_ 10 "$y$" above
  arrow <- right_ 10 from ESO.e+(0,-ESO.ht/4) "$y$" above
  line to (2nd last arrow,Here) then to 2nd last arrow
  arrow <- right_ 10 from ESO.e+(0,ESO.ht/4) "$u$" above; corner
  line to (Here,P)
  for_(1,3,1,
 `arrow from ESO.w+(0,ESO.ht*(m4x-2)/3) left_ ESO.w.x-S`'m4x.x then to S`'m4x.s
    "$z_`'m4x$" at last arrow.start-(5,0) above
    "$-$" at last arrow.end rjust below ')

.PE
