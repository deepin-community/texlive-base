.PS
# Hexagon.m4
# https://tex.stackexchange.com/questions/640000/how-to-draw-hexagonal-lattice-with-links-and-string-using-latex?noredirect=1&lq=1
gen_init
  scale = 4
  circlerad = 1/4
  s3 = sqrt(3)

define cline { line $1
  { if "$2"=="" then { circle thick 0.8 at last line fill_(1) } \
    else { circle thick 0.8 at last line $2 } } }

define topline {
  cline(from $1 up s3 right 1)
  cline(right 2)
  cline(down s3 right 1)
  }

define botline {
  cline(from $1 down s3 right 1)
  cline(right 2)
  cline(up s3 right 1)
  cline(right 2)
  }

define hexagon { line $2 from $1 \
  for_(1,6,1,`to $1+(2,0)+(Rect_(2,180-m4x*60)) \')
  move to $1 + (2,0)
  for i=1 to 6 do {{circle $3 at Here+(Rect_(s3,210-i*60))}}
  if "$4"!="" then {$4 at $1+(2,0)}
  }
  

  nrows = 4
  ncols = 3
for i=1 to nrows do {
  for j=1 to ncols do { topline((3+(j-1)*6,-s3*(2*i-1)))
                        topline((0+(j-1)*6,-s3*2*i)) }
  cline(from (6*ncols,-2*i*s3) up s3 right 1)
  if i != nrows then { cline(from (0,-2*i*s3) down s3 right 1) } \
  else { for j=1 to ncols do { botline(((j-1)*6,-2*nrows*s3)) } }
  }
  linethick = 2
  cline(from (3,-s3) outlined "red" down_ s3 right_ 1,fill_(0)) 
    { "$\sigma^x$" at last circle.w rjust }
    { "\large $I$" above ljust }
  { cline(right_ 2 outlined "red",fill_(0)) 
    { "$\sigma^x$" at last circle.n above ljust } }
  cline(left_ 1 down_ s3 outlined "red",fill_(0)) 
    { "$\sigma^x$" at last circle.e ljust }

  hexagon((12,-4*s3),thick 2 outlined "blue",shaded "white",)
  for a=90 to 360 by 180 do {{
   "\large $\sigma^x\!{=}{-}1$" at (14,-4*s3)+(Rect_(2.25,a)) }} 
  for a=30 to 360 by 180 do {{
   "\large $\sigma^x\!{=}{-}1$" at (14,-4*s3)+(Rect_(2.75,a)) }} 
  for a=150 to 360 by 180 do {{
   "\large $\sigma^x\!{=}{-}1$" at (14,-4*s3)+(Rect_(2.75,a)) }} 
  hexagon(( 3,-7*s3),thick 2 outlined "red" shaded "gray",shaded "black",
   "\large $p$")
  for a=30 to 360 by 60 do {{
   "\large $\sigma^z$" at (5,-7*s3)+(Rect_(2.5,a)) }} 

.PE
