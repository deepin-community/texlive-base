set table "gnuplot/bodegraph/30.table"; set format "%.5f"
set samples 50.0; set parametric; plot [t=0:3] [] [] log10(10**t),-0.08*10**t
