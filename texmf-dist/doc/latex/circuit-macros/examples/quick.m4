.PS                            # Pic input begins with .PS
cct_init                       # Read in macro definitions and set defaults
elen = 0.75                    # Variables are allowed; default units are inches
Vs: source(up_ elen); llabel(-,v_s,+)  # Name and label the source
   resistor(right_ elen); rlabel(,R,)  # Semicolon and line end are equivalent
   dot
   {                           # Save the current position and direction
      capacitor(down_ Vs.len); rlabel(+,v,-); llabel(,C,)
      dot
      }                        # Restore position and direction
   line right_ elen*2/3
   inductor(down_ Vs.len); rlabel(,L,); b_current(i)
   line to (Vs,Here)           # (Vs,Here) = (Vs.x,Here.y)
.PE                            # Pic input ends
