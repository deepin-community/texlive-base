.PS
# `VariableMan.m4'
cct_init

define(`elen_',dimen_); up_
[ { variable(`resistor(up_  dimen_)',A) };
    {"A" at last line.start below}; move right
  { variable(`resistor',N) }; {"N" at last line.start below}; move right
  { variable(`resistor',uN) }; {"uN" at last line.start below}; move right
  { variable(`resistor',NN) }; {"NN" at last line.start below}; move right
  { variable(`resistor',uNN) }; {"uNN" at last line.start below}; #; move right
  ]
[
  skp = 0.4
  hskip = linewid*0.5
  cskip = hskip
  { move right cskip+elen_+hskip
    line invis right_ elen_ "\tt C"; move right_ hskip
    line invis right_ elen_ "\tt S" }
  Loopover_(`char',
   `move down skp ifelse(char,A,*0.5)
    { line invis right_ cskip "\tt char"
      variable(`capacitor(,C)',char); move right_ hskip
      variable(`capacitor(,C)',char`'C); move right_ hskip
      variable(`capacitor(,C)',char`'S) }',
   A,P,L,N)
  ] with .w at last [].e+(0.4,0)

.PE
