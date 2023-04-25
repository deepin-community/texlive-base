.PS
# Escher.m4
# https://tex.stackexchange.com/questions/129274/showcase-of-optical-illusions-made-with-tex-latex-luatex-context
threeD_init
[]
ifelse(1,1,`
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
')

ifelse(1,1,`
define(`DPL',`(project(`$1',`$2',`$3'))')
define(`ISL',`
  S1: `$2'; E1: `$2' + `$3'
  S2: `$4'; E2: `$4' + `$5'
  `$1': line from S2 to intersect_(S1,E1,S2,E2) ')

[
  bdp = 1.8
  bwd = 2.8
  bht = 1.5 
  bth = bwd/10
  setview(-45,20,0)

  L1: line from DPL(0,0,0) to DPL(0,0,bht) \
    then to DPL(0,bwd,bht) \
    then to DPL(bdp,bwd,bht) \
    then to DPL(bdp,bwd,0) \
    then to DPL(bdp,0,0) \
    then to DPL(0,0,0)
  L2: line from DPL(bth,bth,bht) to DPL(bth,bwd-bth,bht) \
    then to DPL(bdp-bth,bwd-bth,bht) \
    then to DPL(bdp-bth,bth,bht) \
    then to DPL(bth,bth,bht)
  L3: line from DPL(bth,bth,0) to DPL(bth,bwd-bth,0) \
    then to DPL(bdp-bth,bwd-bth,0) \
    then to DPL(bdp-bth,bth,0) \
    then to DPL(bth,bth,0)
  L4: line from DPL(bdp,bth,bht-bth) to DPL(bdp,bwd-bth,bht-bth) \
    then to DPL(bdp,bwd-bth,bth) \
    then to DPL(bth+bth,bwd-bth,bth)
  L5: line from DPL(bdp-bth,0,bht-bth) to DPL(bth,0,bht-bth) \
    then to DPL(bth,0,bth) \
    then to DPL(bth,bwd-bth-bth,bth)
  L6: line from DPL(0,0,bht) to DPL(bdp,0,bht) \
    then to DPL(bdp,bwd,bht)
  L7: line from DPL(0,0,0) to DPL(0,bwd,0) \
    then to DPL(bdp,bwd,0)
  ISL(L8,L4.start,UPy_,L4.end,UPz_)
  ISL(L9,L4.start,UPy_,DPL(0,bwd,0),UPz_)
  ISL(L10,L4.start,UPy_,L5.end,UPz_)
  ISL(L11,L5.end,UPy_,L4.start,UPz_)
  ISL(L12,L5.end,UPy_,DPL(bdp,0,bht),UPz_)
  ISL(L13,L5.end,UPy_,L5.start,UPz_)
  ISL(L14,DPL(bdp-bth,bth,bht),UPy_,DPL(bth,bwd-bth-bth,bht-bth),UPz_)
  ISL(L15,L2.start,UPx_,DPL(bth,bwd-bth-bth,bht-bth),UPy_)
  ISL(L16,DPL(bdp-bth,bth,bht),UPy_,DPL(bth,bwd-bth,bht),UPz_)
  ISL(L17,DPL(bdp-bth,bth,bht),UPy_,DPL(bth+bth,bwd-bth,bht-bth),UPz_)
  ISL(L18,DPL(bdp-bth,bth,bht),UPy_,DPL(bth+bth,bwd-bth,bht-bth),UPx_)
  ISL(L19,L3.start,UPy_,L5.start+DPL(0,0,-bht+bth+bth),UPx_)
  ISL(L20,L3.start,UPy_,L5.start+DPL(0,0,-bht+bth+bth),UPz_)
  ISL(L21,L3.start,UPy_,DPL(bdp-bth,bth,0),UPz_)
  ISL(L22,L3.start,UPy_,L4.start+DPL(0,0,-bht+bth+bth),UPz_)
  ISL(L23,DPL(bth,bwd-bth,0),UPx_,L4.start+DPL(0,0,-bht+bth+bth),UPy_)
  ISL(L24,L5.start,UPx_,DPL(bth,bth,bth),UPz_)
  ISL(L25,L4.start,UPy_,DPL(bdp-bth,bwd-bth,bth),UPz_)

ifelse(0,1,`for i=1 to 7 do { exec sprintf("\"L%g.s\" at L%g.start",i,i) }
  for i=8 to 10 do { exec sprintf("\"L%g\" at L%g",i,i) }')
] with .sw at last [].se+(0.2,0)
')
.PE
