set table "gnuplot/bodegraph/3.table"; set format "%.5f"
set samples 2.0; set parametric; plot [t=-0.99942:-0.99942] [] [] log10(10**t),20*log10(abs(3/sqrt (1+(0.3*10**t)**2)))
