set table "gnuplot/bodegraph/55.table"; set format "%.5f"
set samples 50.0; set parametric; plot [t=0:3] [] [] log10(10**t),-90--180/3.1415957*atan(0.08*10**t)--180/3.1415957*atan(0.02*10**t) 
