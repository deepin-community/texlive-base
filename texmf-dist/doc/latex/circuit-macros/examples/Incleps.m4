.PS
# Incleps.m4 : Illustrating one way to import and overwrite .eps graphics
# Note: gpic doesn't fill the arrows
darrow_init
s_init(Incleps)
sinclude(F_Incleps.dim) # Inserted for the web-page version.
sinclude(tmp.dim) # for psfrag
sinclude(examples.dim)  # Change examples to the name of the main LaTeX file.

define(`backarrow',`darrow(`$1',,,2pt__,6pt__,6pt__,<-|)')

S: s_box(`\includegraphics[width=3in]{Incl}')
#                           A blank box the size of the included eps figure:
#S: s_box("\hskip %gin\vrule width 0pt height %gin",\
#   boxdim(InclA,w),boxdim(InclA,v))
ifgpic(`S: box invis ht s_ht wid s_wd with .c at S.n')

thinlines_
  backarrow( from boxcoord(S,0.4,0.95) up 0.4 right 0.7 )
    s_box(\sf Basket) ljust
  backarrow( from boxcoord(S,0.9,0.41) up 0.2 right 0.5 )
    s_box(\sf Ball) ljust
  backarrow( from boxcoord(S,0.85,0.32) up 0.2 right 0.5 )
    s_box(`\sf\shortstack[l]{Star\\ player}') ljust
.PE
