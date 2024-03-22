.PS
# `SRffMan.m4'
log_init

#                             Here is how to include an arbitrary circuit
#                             (an SR-flipflop, for example)
#                             that is not one of the standard gates.
#                             First, define the circuit with a name ending
#                             in _gate.  Put its inputs named In1, In2, ...
#                             on the left and the output Out on the right.
define(`SR_gate',`[ u = 2*L_unit
  S: NOR_gate
    line right_ 2*u from S.Out
  Out: Here
  R: NOR_gate at S+(0,-5*u)
  TS: S.In2-(u,0)
  TR: (TS,R.In1)
    dot(at S.Out+(u,0))
    line down u*3/2 then to TR+(0,u) then to TR then to R.In1
    line from R.Out right u then up u*3/2 then to TS+(0,-u) \
      then to TS then to S.In2
  In1: S.In1
  In2: R.In2 ]')
#                             Now define the function by which the circuit
#                             will be invoked using the built-in _AutoGate:
define(`SRff',`_AutoGate(SR,$@)')

#                             You are done.  Here is an example:
G: [ 
  F: Autologix(SRff(And(x,y),Nand(x,y)),LRV)

  "$x$" at F.Inx rjust
  "$y$" at F.Iny rjust
  "\sl Out" at F.Out ljust
  ] 
  `"{\tt Autologix(SRff(And(x,y),Nand(x,y)),LRV)}"' wid 253pt__ ht 7pt__ \
    with .w at last [].sw+(0,-10pt__)

.PE
