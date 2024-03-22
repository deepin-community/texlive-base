.PS
# https://github.com/circuitikz/circuitikz/issues/515
# `Fefets.m4'
cct_init

textht = 0.1
define(`rmove',0.75)

Row1: [
  J: Fe_fet(right_ dimen_)
  {`"{\tt $\;$ Fe\_fet}"' at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  move right_
  J: Fe_fet(up_ dimen_)
  {`"{\tt (up\_ dimen\_)}"' at J.s+(0,-0.15) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  move right_
  J: Fe_fet(left_ dimen_)
  {`"{\tt (left\_ dimen\_)}"' at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S ljust
    "$D$" at J.D rjust }
  move right_
  J: Fe_fet(down_ dimen_)
  {`"{\tt (down\_ dimen\_)}"' at J.s+(0,-0.15) below
    "$G$" at J.G ljust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  ]
Row2: [
  J: Fe_fet(right_ dimen_,R)
  {`"{\tt $\;$ Fe\_fet}"' at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  move right_
  J: Fe_fet(up_ dimen_,R)
  {`"{\tt (up\_ dimen\_,R)}"' at J.s+(0,-0.15) below
    "$G$" at J.G ljust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  move right_
  J: Fe_fet(left_ dimen_,R)
  {`"{\tt (left\_ dimen\_,R)}"' at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S ljust
    "$D$" at J.D rjust }
  move right_
  J: Fe_fet(down_ dimen_,R)
  {`"{\tt (down\_ dimen\_,R)}"' at J.s+(0,-0.15) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  ] with .nw at last [].sw+(0,-0.5)
Row3: [
  J: Fe_fet(right_ dimen_)
  {`"{\tt $\;$ Fe\_fet}"' at J.s+(0,-0.05) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  move right_
  J: Fe_fet(right_ dimen_,,TEDQSuB)
  {`"{\tt $\;$ Fe\_fet(,,TEDSQuB)}"' at J.s+(0,-0.15) below
    "$G$" at J.G rjust
    "$S$" at J.S rjust
    "$D$" at J.D ljust }
  ] with .nw at last [].sw+(0,-0.5)
#Row4: [
#  ] with .nw at last [].sw+(0,-0.5)

.PE
