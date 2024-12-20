.PS
# SampleIC.m4
log_init
command "\small\sf"

 U: box wid 18*L_unit ht 9*lg_pinsep

 lg_pin(U.nw-(0,lg_pinsep),Vin,Pin1,w)
 lg_pin(U.nw-(0,2*lg_pinsep),,,wL)

 foreach_(`x',
  `lg_pin(U.nw-(0,(m4Lx+2)*lg_pinsep),x,,w`'x)',
   M,I,O,N,E,NE)
 define(`Upin',
  `lg_pin(U.ne-(0,(17-`$1')*lg_pinsep),`$2',Pin`$1',e`$3',`$1',8*L_unit)')
 foreach_(`x',
 `Upin(patsubst(x,;,`,'))',
  16;Vin;, 15;D0;L, 14;D1;M, 13;D2;I, 12;D3;O, 11;D4;N, 10;D5;E, 9;D6;NE )
.PE
