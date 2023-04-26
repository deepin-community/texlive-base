.PS
# Thermal.m4
cct_init
define(`thermalsw',
 `dswitch(`$1',`$2',WDdBTh)
  circle rad distance(last [].T,last line.c) at last line.c')
thermalsw
.PE
