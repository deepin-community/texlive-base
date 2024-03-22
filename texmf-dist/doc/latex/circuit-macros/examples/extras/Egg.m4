.PS
# Egg.m4
# https://tex.stackexchange.com/questions/74168/how-can-i-draw-an-egg-using-tikz
threeD_init
NeedDpicTools

define Eggshape { (0.78*cos(($2)/4)*sin($2),-cos($2))*($1) } # -pi < arg2 < pi

  size = 2
  npts = 41

  HL: Eggshape(size*0.4,-pi_*3/4)  # Highlight
  P: Eggshape(size,pi_/4)
  d = zabs(P)
  nlines = int(d/lthick*1.5)
                            # This way of blending colors is not the
                            # simplest for a single postprocessor but it
                            # works for multiple postprocessors, e.g. SVG
define(`Orange',`1,   0.5, 0')
define(`Gray',  `0.5, 0.5, 0.5')
define(`White', `1,   1,   1')
define(`eggblend',
 `sum3D(sprod3D($1,Orange),
  sum3D(sprod3D($2,White),
        sprod3D($3,Gray)))')

define(`normalize',`($1)/($1+$2+$3), ($2)/($1+$2+$3), ($3)/($1+$2+$3)')

define EggLine {
  for i=0 to npts do {
    P[i]: HL*(1-($1))+Eggshape(size*($1),i/npts*twopi_-pi_) }
  fitcurve(P,npts,outlined rgbstring($2,$3,$4))
  }

  ShadeObject(EggLine, nlines,
    0,    eggblend(normalize(0.3,    1,    0)),
    0.2,  eggblend(normalize(0.5,  0.5,    0)),
    0.5,  eggblend(normalize(0.5,  0.4,  0.2)),
    1,    eggblend(normalize(0.5,    0,  0.7))
    )

.PE
