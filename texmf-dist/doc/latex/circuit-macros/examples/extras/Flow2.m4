.PS
# https://tex.stackexchange.com/questions/661461/flowchart-with-overlapping-of-the-rows
sinclude(FlowchartDefs.m4def)
sinclude(../FlowchartDefs.m4def)

down_
  smallsep = boxht/3
  testw = flowboxwid*7/4
  testh = flowboxht*9/4
  Start: Fbox("Start",,rad boxht/8 shaded "red!30")
    arrow down_ smallsep "False" ljust
  Input: Fdata(`"Input: $f(), a, b, \epsilon$"',wid boxwid*5/4,,
    shaded "blue!30")
    arrow down_ smallsep
  Formula1: Fbox(`"$c=(a+b)/2$"',,shaded "orange!30")
    arrow down_ smallsep
  Test1: Ftest("if:" `"$f(a)*f(b) > 0$" "\vphantom{\vrule height6pt}"',
    wid testw ht testh, shaded "green!30")
  A2: arrow down_ smallsep "False" ljust
  Test2: Ftest("while:" `"$f(c)\neq 0 \;\&$" "$|f(b)-f(a)| > \delta$" \
    "\vphantom{\vrule height6pt}"',wid testw ht testh, shaded "green!30")
    arrow down_ smallsep "True" ljust
  Formula2: Fbox(`"$c=(a+b)/2$"',,shaded "orange!30")
    arrow down_ smallsep
  Test3: Ftest("if:" `"$f(a)*f(c) < 0$" "\vphantom{\vrule height6pt}"',
    wid testw ht testh, shaded "green!30")
  { arrow from Test3.W left_ boxht*2/3 "True" below 
    Formula3: Fbox(`"$b=c$"',,shaded "orange!30")
    arrow from Formula3.N to (Formula3.N,A2) }
    arrow down_ smallsep "False" ljust then left Test3.x-Formula3.E.x
  Formula4: Fbox(`"$a=c$"',,shaded "orange!30") with .E at Here
  { arrow from Formula4.W left_ Formula4.W.x-Formula3.W.x + smallsep \
      then up_ A2.y-Formula4.y then to A2 }
  down_
  Output: Fdata(`"Output: $H, v, t$"',wid boxwid*5/4,,shaded "blue!30") \
    with .N at (Test1.E+(3*smallsep,0),Formula4.N)
  { arrow from Test1.E right_ Output.N.x-Test1.E.x "True" above \
      then to Output.N
    arrow from Test2.E right_ Output.N.x-Test1.E.x "False" above }
    arrow down_ smallsep
  Plot: Fbox(,wid boxwid*5/4,shaded "orange!30")
  { ["Plot:" ljust "H on T and V on T" ljust] with .w at Plot.W+(3bp__,0) }
    arrow down_ smallsep
  Stop: Fbox("Stop",,rad boxht/8 shaded "red!30")


.PE
