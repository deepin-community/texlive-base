.PS
# parallel-series.m4
# https://tex.stackexchange.com/questions/709074/how-to-plot-a-block-diagram-with-tikz
cct_init

 dot; line right_ dimen_/2
 parallel_(
   parallel_(
     `ebox(,wdth=0.2;text="$x_1$")',
     `Sep=dimen_*3/4;ebox(,wdth=0.2;text="$x_2$")'),
   Sep=dimen_;series_(
     `ebox(,wdth=0.2;text="$x_3$")',
     `ebox(,wdth=0.2;text="$x_4$")'))
 line right_ dimen_/2; dot
.PE
