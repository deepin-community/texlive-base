.PS
# Cylinder.m4
gen_init(SIdefaults) # lengths are in mm

define(`cylinder',`[ angle = ifelse(`$3',,20,`$3')
  w = ifelse(`$1',,boxwid,`$1')
  h = ifelse(`$2',,boxht,`$2')
  B: ellipse wid w ht sind(angle)*w
  S: box invis wid w ht h fill_(1) with .s at B
  line from S.nw to S.sw
  line from S.ne to S.se
  T: ellipse wid w ht sind(angle)*w at B+(0,h)
  ]')

define Cylinder { [ dtor = atan2(1,0)/90
  if "$1"=="" then { w = boxwid } else { w = $1 } 
  if "$2"=="" then { h = boxht } else { h = $2 } 
  if "$3"=="" then { angle = 20 } else { angle = $3 } 
  B: ellipse wid w ht sin(angle*dtor)*w
  S: box invis wid w ht h fill 1 with .s at B
  line from S.nw to S.sw
  line from S.ne to S.se
  T: ellipse wid w ht sin(angle*dtor)*w at B+(0,h)
  ] }

M4: [
  cylinder
  move
  cylinder(,,15)
  move
  cylinder(3,50)
  ]
"M4 macro" at last [].s below

Pic: [
  Cylinder
  move
  Cylinder(,,15)
  move
  Cylinder(3,50)
  ] with .w at M4.e+(5,0)
"pic macro" at last [].s below
.PE
