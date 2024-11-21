.PS
# `AlogixMan.m4'
log_init
 
#                             A modest expression in default form
A: Autologix(
    Nand(And(Or(A,C),Or(B,~C),Or(~A,B,C)),Ck);
    Nand(~A,B)@with .n at last [].s+(0,-2bp__))
    move left 10bp__ from A.InCk
    "\sl Out1" at A.Out1 ljust
    "\sl Out2" at A.Out2 ljust
    Loopover_(`v_', `"$v_$" at A.In`'v_ above ', A,B,C,Ck)
 `"\shortstack[l]{
  \tt Autologix( \\ \tt \quad
     Nand(And(Or(A,C),Or(B,\~{}C),Or(\~{}A,B,C)),Ck);\\ \tt \quad
     Nand(\~{}A,B))@with .n at last [].s+(0,-2bp\_\_))}"'\
     wid 288bp__ ht 32bp__ with .nw at A.sw+(0,-0.10)

#                             Draw a tree of gates only.  The ~ has been
#                             replaced by NOT gates.
B: Autologix(Or(And(B,Not(C)),And(Not(A),B,C)),N) \
  with .sw at A.e+(0.4,0.25)
  "{\sl B.Out}" at B.Out above ljust
  `"\shortstack[l]{\tt B: Autologix( \\ \tt \
     Or(And(B,Not(C)),And(Not(A),B,C)),N)}"' \
    wid 242pt__ ht 20pt__ at B.s+(0,-0.2)
  for_(1,4,1,`"{\sf\small\sl B.In`'m4x}" at B.In`'m4x rjust')
  "{\sf\small\sl B.In5}" at B.In5+(0,-1.5bp__) rjust

ifelse(0,1,`
#                             Here is how to include an arbitrary circuit
#                             (an SR-flipflop, for example)
#                             that is not one of the standard gates.
#                             First, define the circuit with a name ending
#                             in _gate.  Put its inputs named In1, In2, ...
#                             on the left and the output Out on the right.
define(`SR_gate',`[ v = 2*L_unit
  S: NOR_gate
    line right_ 4*L_unit from S.Out
  Out: Here
  R: NOR_gate at S+(0,-10*L_unit)
  TS: S.In2-(v,0)
  TR: (TS,R.In1)
    dot(at S.Out+(v,0))
    line down v*3/2 then to TR+(0,v) then to TR then to R.In1
    line from R.Out right v then up v*3/2 then to TS+(0,-v) \
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
  ] with .sw at A.n+(0.0,-0.25)
  `"{\tt Autologix(SRff(And(x,y),Nand(x,y)),LRV)}"' wid 253pt__ ht 7pt__ \
    with .w at last [].sw+(0,-10pt__)
')

.PE
