.PS
# Metamodel:
# https://tex.stackexchange.com/questions/615463/how-to-draw-meta-models-in-tikz
gen_init

  lineht = 0.4
  arrowht = arrowht*3/2;  arrowwid = arrowwid*2
  fillv = 0.9
  define bx {box fill_(fillv) rad 5bp__ $1}
  up_

  Event: bx(ht boxht "Event")
  sarrow(,type=D); {"{\tt<}contains{\tt>}" at last arrow rjust}
  Trace: bx(ht boxht "Trace")
  sarrow(,type=D); {"{\tt<}contains{\tt>}" at last arrow rjust}
  Log: bx(ht boxwid "Log")
  Att: bx(ht boxwid wid boxwid*5/4 "Attribute" dashed) \
    with .nw at Log.ne + (boxwid*2,0)

  fillv = 0.8
  ww = Log.ht
  move to (Att.w,Att.n) - (0,ww/9)
  { sarrow(to (Log.e,Here),type=D)
    {"{\tt<}trace-global{\tt>}" at last arrow above} }
  move down_ ww/3
  { sarrow(to (Log.e,Here),type=D)
    {"{\tt<}event-global{\tt>}" at last arrow above} }
  move down_ ww/3
  { sarrow(to (Log.e,Here),type=D) }
  T: 0.8 between last arrow.start and last arrow.end
  move down_ ww/9
  line dashed left ww/3 then down ww/2 then right ww/2
  sarrow(up ww*7/18, type=D;shaft=dashed)
  "{\tt<}contains{\tt>}" at (last arrow.end,Att.s)-(ww/4,ww*7/18) below

  line from T to (T,Event); sarrow(to Event.e,type=D)
  sarrow(from (T,Trace) to Trace.e,type=D)

  ellipsewid = boxwid*0.9
  ellipseht = ellipsewid/2
  move to (Att.e,Att.s)+(ww/6,-ww/8)
  y = Here.x-Att.c.x-boxwid/2
  down_
  Loopover_(`Z',`Z: bx(ht boxht*3/4 "Z")
   {sarrow(from Z.e+(y,0) to Z.e,type=D)}
   {ifelse(Z,Boolean,
     `move to last arrow.start; line to (Here,String)
      line from Z.w to (Att,Z.w); sarrow(to Att.s,type=O)',
    `line from Z.w to (Att,Z.w)')}
   move down_ ww/16',
  String,Date,Int,Float,Boolean)

  line from Int.e+(y,0) right_ ww/4; Value: ellipse fill_(fillv) "Value" 
  Key: ellipse fill_(fillv) "Key" with .w at Att.e+(y*2,0)
  sarrow(from last ellipse.w to Att.e,type=D)

  Class: bx(ht boxht*3/4 "Classifier") \
    with .s at (0.5 between Log and Att,Att.n)+(0,boxht/2)
  line from Class.w to (Log,Class); sarrow(to Log.n,type=D)
  "{\tt<}defines{\tt>}" at (0.5 between Log and Class.w,Class) above
  line from Att.n to (Att,Class); sarrow(to Class.e,type=D)
  "{\tt<}defines{\tt>}" at (0.5 between Att and Class.e,Class) above

  Ext: bx(ht boxht*3/4 "Extension") with .e at (Att.e,Class+(0,boxht*3/2))
  move to (Att.e,Att.n)-(Att.wid/8,0)
  sarrow(to (Here,Ext.s),type=D;shaft=dashed)
  "{\tt<}defines{\tt>}" at (last arrow,Ext.s)-(0,y) rjust
  line dashed from Ext.w to (Log,Ext) then to (Log,Class)
  "{\tt<}declares{\tt>}" at (0.5 between Log and Class,Ext) below

  ellipse fill_(fillv) "name" at (Key,Ext)
  sarrow(from last ellipse.w to Ext.e,type=D)
  ellipse fill_(fillv) "prefix" with .n at last ellipse.s+(0,-ww/16)
  line from last ellipse.w left y
  URI: ellipse fill_(fillv) "URI" with .n at last ellipse.s+(0,-ww/16)
  line from last ellipse.w left y then up Ext.y - URI.y
 
.PE
