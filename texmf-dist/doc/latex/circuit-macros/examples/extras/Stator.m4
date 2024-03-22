.PS
# Stator.m4
# https://tex.stackexchange.com/questions/612620/how-to-paint-inside-a-set-of-lines
gen_init
scale = 0.5

  outerwid = 5/2
  innerwid = 3.7/2
  nteeth = 32
  toothdepth = (innerwid/2)*(twopi_/nteeth)
  statordepth = toothdepth*4
  viewangle = 30
  outershade = 0.9
  topshade = 0.8
  innershade = 0.6
  toothshade = 0.5

  cv = cosd(viewangle)
  sv = sind(viewangle)
  define ang { ($1)/nteeth*twopi_ }

  T:  (0,statordepth*cv)
  Tc: (0,toothdepth*cv)
  for i = 0 to nteeth/2 do { for j=1 to -1 by -2 do { # Shaded tooth walls
    P: (cos(ang(i)+pi_/2)*j,sin(ang(i)+pi_/2)*sv)*outerwid/2
    Q: P*innerwid/outerwid
    line from P to P+Tc then to Q+Tc then to Q then to P \
      shaded rgbstring(toothshade,toothshade,toothshade) } }
  shade(innershade,         # inner arc and teeth
    E: ellipsearc(innerwid,innerwid*sv,pi_,0,0,cw) with .C at T
    move to (innerwid/2,0)
    toothht = toothdepth*cv
    for i = 0 to nteeth/2 do {
      line up toothht
      ellipsearc(innerwid,innerwid*sv,ang(i),ang(i+1),0,ccw) with .Start at Here
      move to last [].End
      toothht = -toothht } )
  shade(outershade,         # outer arc and teeth
    E: ellipsearc(outerwid,outerwid*sv,0,pi_,0,cw) with .C at T
    line down statordepth*cv from E.End
    toothht = toothdepth*cv
    for i = nteeth/2 to nteeth-1 do {
      line up toothht
      ellipsearc(outerwid,outerwid*sv,ang(i),ang(i+1),0,ccw) with .Start at Here
      move to last [].End
      toothht = -toothht }
    line up statordepth*cv from E.Start-T )
  for r=innerwid to outerwid by lthick*2 do { # shade the top
    ellipse wid r ht r*sv with .c at T \
      outlined rgbstring(topshade,topshade,topshade) }
  ellipse wid outerwid ht outerwid*sv with .c at T
  ellipse wid innerwid ht innerwid*sv with .c at T

.PE
