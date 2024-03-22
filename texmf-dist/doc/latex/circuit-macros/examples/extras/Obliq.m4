.PS
threeD_init
scale = 2.54

divert(-1)
                                   `ProjectObliq(x,y,z,x scale,degrees)
                                    oblique projection
                                    arg4= x scale (default 1/2)'
define(`ProjectObliq',`(`$2'-dnl
(`$1')ifelse(`$4',,/2,*(`$4'))*cosd(ifelse(`$5',,obliqueangle_,(`$5'))),dnl
`$3'-(`$1')ifelse(`$4',,/2,*(`$4'))*sind(ifelse(`$5',,obliqueangle_,(`$5'))))')
define(`obliqueangle_',45)

divert(0)dnl

define(`Pr',`ProjectObliq(`$1',`$2',`$3')')

  d = 2
define(`cube',`[ # w, h, d, scale, degrees
  define(`cubewd',ifelse(`$1',,linewid,`$1'))dnl
  define(`cubeht',ifelse(`$2',,cubewd,`$2'))dnl
  define(`cubedp',ifelse(`$3',,cubewd,`$3'))dnl
  for_(0,7,1,`P`'binary_(m4x,3): \
    Pr(ifelse(eval(m4x/4),1,cubedp,0),
       ifelse(eval((m4x%4)/2),1,cubewd,0),
       ifelse(eval(m4x%2),1,cubeht,0))')
# {command "{\small"
#  for_(0,7,1,`"binary_(m4x,3)" at P`'binary_(m4x,3)')
#  command "}"
# }
  {"000" at P000}
  if obliqueangle_ > 0 then {
  line dashed from P100 to P000 chop linethick bp__ * 2 chop 0
  line dashed from P010 to P000 chop linethick bp__ * 2 chop 0
  line dashed from P001 to P000 chop linethick bp__ * 2 chop 0
  line from P101 to P001
  line to P011
  line to P111
  line to P101
  line to P100
  line to P110
  line to P010
  line to P011
  line from P110 to P111
  } else {
  line dashed from P101 to P001 chop linethick bp__ * 2 chop 0
  line dashed from P011 to P001 chop linethick bp__ * 2 chop 0
  line dashed from P000 to P001 chop linethick bp__ * 2 chop 0
  line from P100 to P101
  line to P111
  line to P110
  line to P100
  line to P000
  line to P010
  line to P011
  line to P111
  line from P010 to P110
  }
 ]')

  Cube: cube(1,2,3)
#
##{arrow from Cube.P001 to 3/2 between Cube.P000 and Cube.P001; "$z$" ljust }
##{arrow from Cube.P010 to 3/2 between Cube.P000 and Cube.P010; "$y$" below }
##{arrow from Cube.P100 to 3/2 between Cube.P000 and Cube.P100; "$x$" ljust }

  move define(`obliqueangle_',30); cube(1,2,3)
  move define(`obliqueangle_',15); cube(1,2,3)
  move define(`obliqueangle_',-15); cube(1,2,3)
  move define(`obliqueangle_',-30); cube(1,2,3)

.PE
