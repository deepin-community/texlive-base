.PS
# ex06.m4
gen_init

F: box invis wid 1.6i ht 1.8i
E: box invis wid F.wid ht F.ht
G: box invis wid 1i ht F.ht

  ell = F.ht-0.6i
  r = 0.3i
  offset = 8bp__
  hatch = 0.1i
  dhs = hatch * sqrt(2)
  qmell = F.ht - ell
  kwid = F.wid-qmell-r

  hatchbox(wid G.e.x-F.w.x ht F.ht,hatch) with .sw at F.sw
  box invis fill_(1) ht ell wid E.e.x-F.w.x with .nw at F.nw

  box wid G.e.x-F.w.x ht F.ht with .sw at F.sw thick linethick*3/2
  Loopover_(`B',
   `B`'T: B.se + (-qmell,qmell)
    line invis fill_(1) from B.se to (B.se,B`'T) then to B`'T then to B.se
    line from (B.w,B`'T) to B`'T chop 0 chop -offset
    line from B`'T up ell chop -offset chop 0
    line from B`'T + (-r,0) up ell
    line dashed from B`'T to B.se
    "\large $0$" at B`'T + (-r/2,ell/2)
    "\large $0$" at B`'T + (qmell/2,ell/2)
    "$t$" at (B`'T,B.n) + (-offset/2,offset)
    sprintf("$\overbrace{\phantom{\hbox to %gin{}}}^{\hbox{$k$}}$",kwid) \
      at B.nw + (kwid/2,0) above
    hatchbox(wid kwid ht ell,hatch,,90) with .nw at B.nw
    line from B.ne to B.se thick linethick*3/2
   ',F,E)

  line from (G.w,ET) right G.wid
  line from ET + (0,r) left ET.x-E.w.x
  hatchbox(wid r ht r,hatch,,0) with .se at ET

  "$q$" at F.sw + (-offset,offset/3)
  "$\ell$" at (F.w,FT) + (-offset,offset/3)

  "$n{+}p{+}m$" at G.ne + (0,offset)
  
  Loopover_(`B',`"\Large $B$" ht 0.2 with .n at B.s + (0,-offset/2)',F,E,G)

                           # extra left brace to avoid a psfrag problem (bug?)
  sprintf(\
   "$\vphantom{\{}\left.\vrule height %gin depth0pt width0pt\right\}r$",r/2) \
   at ET + (offset,r/2)

#  Adjust the bounding box without using s_box:
  move from F.nw+(-12bp__,21bp__) to G.se+(20bp__,-15bp__)
.PE
