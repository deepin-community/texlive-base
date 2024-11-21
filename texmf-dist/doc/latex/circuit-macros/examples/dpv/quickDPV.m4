.PS                            # Pic input begins with .PS
# quickDPV.m4
cct_init                       # Set defaults

elen = 0.75                    # Variables are allowed; default units are inches
move right 0.4
   svgLink(SourcesDPV.svg,Vs: source(up_ elen))
   llabel(-,svg_it(v`'svg_sub(s)),+)
   svgLink(ResistorsDPV.svg,resistor(right_ elen));  rlabel(,svg_it(R),)
   dot
   {                           # Save current position and direction
      capacitor(down_ Vs.len); rlabel(+,svg_it(v),-); llabel(,svg_it(C))
      dot
      }                        # Restore position and direction
   line right_ elen*2/3
   {move right 0.2}
   inductor(down_ Vs.len); rlabel(,svg_it(L),); b_current("svg_it(i)")
   line to (Vs,Here)           # (Vs,Here) = (Vs.x,Here.y)
.PE                            # Pic input ends
