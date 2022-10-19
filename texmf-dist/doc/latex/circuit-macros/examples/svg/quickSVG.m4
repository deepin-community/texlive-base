.PS                            # Pic input begins with .PS
cct_init                       # Set defaults

elen = 0.75                    # Variables are allowed; default units are inches
move right 0.4
Origin: Here                   # Position names are capitalized
   svgLink(SourcesSVG.svg,source(up_ elen))
   llabel(-,svg_it(v`'svg_sub(s)),+)
   svgLink(CctTableSVG.svg,resistor(right_ elen));  rlabel(,svg_it(R),)
   dot
   {                           # Save current position and direction
      capacitor(down_ to (Here,Origin))     #(Here,Origin) = (Here.x,Origin.y)
      rlabel(+,svg_it(v),-); llabel(,svg_it(C))
      dot
      }                        # Restore position and direction
   line right_ elen*2/3
   {move right 0.2}
   inductor(down_ Here.y-Origin.y); rlabel(,svg_it(L),); b_current("svg_it(i)")
   line to Origin
.PE                            # Pic input ends
