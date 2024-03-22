set table "gnuplot/bodegraph/60.table"; set format "%.5f"
set samples 50.0; set parametric; plot [t=-2:2] [] [] log10(10**t),-180/3.1415957*atan(0.5*10**t)+-90
