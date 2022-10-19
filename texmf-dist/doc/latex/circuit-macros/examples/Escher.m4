.PS
# Escher.m4
# https://tex.stackexchange.com/questions/129274/showcase-of-optical-illusions-made-with-tex-latex-luatex-context
threeD_init
[
  u=1/2.54                 # unit size; could use scale for this

  define(`treadcolor',`0.8,0.75,0.7')
  define(`darkgrn',`.1,.1,0')
  define(`lightgrn',`.7,.7,.6')

  define(`northsteps',3)
  define(`eaststeps',8)
  define(`southsteps',7)
  define(`weststeps',4)
  define(`baselayers',10)
  define(`eb',eval(baselayers+eaststeps))
  define(`ebs',eval(eb+southsteps))
  define(`under',7)

  azimuth = -45            # view angles
  elevation = 25
  setview(azimuth,elevation,0)
                           # projected unit vectors
  UX: Project(u,0,0)
  UY: Project(0,-u,0)
  UZ: Project(0,0,u)
                           # layer thickness in units of u
  f= -(eaststeps*UX.y + southsteps*UY.y - weststeps*UX.y - northsteps*UY.y)/dnl
      ((eaststeps+southsteps+weststeps+northsteps)*UZ.y)
                           # XY projection of 3D coords in units of u
define proj {UX*($1)+UY*($2)+UZ*($3)}

define tread {line from UY/2 \
  to UY then to UY+UX then to UX then to (0,0) \
  then to UY/2 shaded rgbstring(treadcolor) \
    with .start at proj($1,$2,$3)+UY/2 }

define wrect {line invis from (0,0) to UX*($4) \
  then to UX*($4)+UZ*($5) \
  then to UZ*($5) then to (0,0) with .start at proj($1,$2,$3) \
  shaded rgbstring(r,g,b)} 

define srect {line invis from (0,0) to UY*($4) then to UY*($4)+UZ*($5) \
  then to UZ*($5) then to (0,0) with .start at proj($1,$2,$3) \
  shaded rgbstring(r,g,b) } 
                           # color blending
define(`blendwht',`between3D(`$1',`$2',`$3',`$4',1,1,1)')
define makergb { r = $1; g = $2; b = $3 }
define dorgb { gg = $2
  if $1==0 then { makergb(blendwht(gg,lightgrn)) } \
  else { makergb(blendwht(gg,darkgrn)) } }

# East
  for i=-under to baselayers do {
    dorgb((i%2),0.2)
    wrect(1,1,i*f,eaststeps-2,-f) }
  for i=0 to eaststeps do {
    dorgb((i%2),0.2)
    wrect(i,1,(baselayers+i)*f,(eaststeps+1-i),-f)
    tread(i,0,(baselayers+i)*f)
    line from proj(i,1,(baselayers+i)*f) \
           to proj(i,1,(baselayers-1+i)*f) }
# South
  for i=0 to eb do {
    dorgb((i%2),0.4)
    srect(eaststeps+1,0,i*f,southsteps+1,-f) }
  for i=1 to southsteps do {
    dorgb((i%2),0.4)
    srect(eaststeps+1,i,(eb+i)*f,(southsteps+1-i),-f)
    tread(eaststeps,i,(eb+i)*f)
    line from proj(eaststeps+1,i,(eb+i)*f) \
      to proj(eaststeps+1,i,(eb+i-1)*f) }
# North
  for i=-under to baselayers-northsteps-1 do {
    dorgb((i%2),0.1)
    srect(1,1,i*f,northsteps-1,-f) }
  for i=1 to northsteps do {
    dorgb((i%2),0.1)
    srect(1,1,(baselayers-i)*f,i,-f)
    wrect(0,1+i,(baselayers-i)*f,1,-f)
    line from proj(0,1+i,(baselayers-i)*f) \
           to proj(0,1+i,(baselayers-i-1)*f)
    line from proj(1,1+i,(baselayers-i)*f) \
           to proj(1,1+i,(baselayers-i-1)*f)
    tread(0,i,(baselayers-i)*f) }
# West
  for i=0 to ebs do {
    dorgb((i%2),0.4)
    wrect(eaststeps+1,southsteps+1,i*f,-(weststeps+1),-f) }
  for i=0 to weststeps-1 do {
    dorgb((i%2),0.4)
    wrect(eaststeps-i,southsteps+1,(ebs+i+1)*f,-(weststeps-i),-f,)
    srect(eaststeps-i,southsteps,(ebs+i+1)*f,1,-f)
    if i!=weststeps-1 then {
      line from proj(eaststeps-i,southsteps,(ebs+i+1)*f) \
             to proj(eaststeps-i,southsteps,(ebs+i)*f) }
    line from proj(eaststeps-i,southsteps+1,(ebs+i+1)*f) \
           to proj(eaststeps-i,southsteps+1,(ebs+i)*f)
    tread(eaststeps-(i+1),southsteps,(ebs+i+1)*f) }
# Corner lines
  define(`dgreen',`outlined rgbstring(blendwht(0.2,darkgrn))')
  line dgreen from proj(1,1,(baselayers-1)*f) to proj(1,1,-under*f)
  line dgreen from proj(eaststeps+1,southsteps+1,ebs*f) \
         to proj(eaststeps+1,southsteps+1,-f)
  line dgreen from proj(0,northsteps+1,(baselayers-northsteps)*f) \
    to last line.end-UX*(weststeps+1) then to last line.end \
    then to proj(eaststeps+1,0,-f) then to proj(eaststeps+1,0,eb*f)
  ]

ifelse(1,1,`
[
  setview(-45,20)
  bwid = 2.8
  bh = 1.5
  bdp = 1.8
  bth = 0.3
  A: Project(0,0,0)
  AA: A+Project(bth,bth,-bth)
  B: Project(0,bwid,0)
  BB: B+Project(bth,-bth,-bth)
  C: Project(bdp,bwid,0)
  D: Project(bdp,0,0)
  E: Project(0,0,-bh)
  F: Project(bdp,0,-bh)
  G: Project(bdp,bwid,-bh)
  H: B + Project(0,0,-bh)

  line from A to B then to C then to D then to A then to E then to F \
    then to G then to H then to E
  line from C to G
  line from A+Project(bth,bth,0) to B+Project(bth,-bth,0) \
    then to C+Project(-bth,-bth,0)
  L1: line to D+Project(-bth,bth,0)
  L2: line to A+Project(bth,bth,0)
  L4: line from E+Project(bth,bth,0) to H+Project(bth,-bth,0)
  L3: line to C+Project(-bth,-bth,-bh)
  line to F+Project(-bth,bth,0) then to A+Project(bth,bth,-bh)

  L5: line from D+Project(-bth,0,-bth) to A+Project(bth,0,-bth)
  line to E+Project(bth,0,bth)
  L6: line to Here+Project(0,bwid-2*bth,0)
  L7: line from D+Project(0,bth,-bth) to C+Project(0,-bth,-bth)
    line to G+Project(0,-bth,bth)
  L8: line to Here+Project(-bdp+2*bth,0,0)
  Tmp: line invis from L8.start+Project(-bth,0,0) up bh
  line from Tmp.start to Intersect_(Tmp,L7)
  Tmp: line invis from L8.end up bh
  line from L8.end to Intersect_(Tmp,L7)
  line from Intersect_(Tmp,L1) to BB+Project(bth,0,0)
  Tmp: line invis to Here+Project(bdp,0,0)
  line from Tmp.start to Intersect_(Tmp,L1)

  Tmp: line invis from H up bh
  line from H to Intersect_(Tmp,L7)
  line from Intersect_(Tmp,L1) to B+Project(bth,-bth,0)

  Tmp: line invis from AA to AA+Project(0,bwid,0)
  Tmp2: line invis up bh from L6.end
  line from Intersect_(Tmp,L2) to Intersect_(Tmp2,Tmp) \
    then to Intersect_(Tmp2,L1)
  line from L6.end to Intersect_(Tmp2,L7)

  Tmp: line invis down bh from AA
  line from Intersect_(Tmp,L6) to Intersect_(Tmp,L5)

  Tmp: line invis down bh from D
  line from D to Intersect_(Tmp,L6)
  line from Intersect_(Tmp,L4) to F+Project(-bth,bth,0)

  Tmp: line invis from L5.start to L5.start+Project(0,0,-bh)
  move to E+Project(0,2*bth,0)
  Tmp2: line invis to Here+Project(bdp,0,0)
  line from L5.start to Intersect_(Tmp,L6)
  line from Intersect_(Tmp,L4) to Intersect_(Tmp,Tmp2) \
    then to Intersect_(Tmp2,L4)

  Tmp: line invis from L7.start to L7.start+Project(0,0,-(bh-bth))
  line from L7.start to Intersect_(Tmp,L6)

  move to G+Project(-2*bth,0,0)
  Tmp2: line invis to Here+Project(0,-bwid,0)
  line from Intersect_(Tmp2,L3) to Intersect_(Tmp,Tmp2)
  line from Intersect_(Tmp,L4) to Intersect_(Tmp2,Tmp)

] with .sw at last [].se+(0.2,0)
')
.PE
