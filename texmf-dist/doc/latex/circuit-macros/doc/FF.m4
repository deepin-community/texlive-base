.PS
# `FF.m4'
log_init
Sg: NOR_gate
  left_
Rg: NOR_gate at Sg+(0,-L_unit*(AND_ht+1))
  line from Sg.Out right L_unit*3 then down Sg.Out.y-Rg.In2.y then to Rg.In2
  line from Rg.Out left L_unit*3 then up Sg.In2.y-Rg.Out.y then to Sg.In2
  line left 4*L_unit from Sg.In1 ; "$S$" rjust
  line right 4*L_unit from Rg.In1 ; "$R$" ljust
.PE
