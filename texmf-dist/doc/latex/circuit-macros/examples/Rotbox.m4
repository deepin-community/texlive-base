.PS
# Rotbox.m4
gen_init

  Point_(-10)
  rotbox(boxwid/2,,thick 2)
  Point_(30)
  rotbox(,,shaded "yellow" outlined "blue" thick 3,r=0.1) \
    at last [].se+vec_(boxwid,0)
  "r=0.1" at last []
  move to last [].ne
  Point_(0)
  [[]; for_(2,16,2, `rotbox(,,dashed,t=m4x/10) with .nw at \
    ifelse(m4x,10,`2nd [].sw+(0,-0.1)',`last [].ne+(boxwid*0.1,0)')
    sprintf("t=%g",m4x/10) at last []') ] with .sw at last [].se+(0.1,0)

.PE
