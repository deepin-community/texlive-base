set table "gnuplot/bodegraph/33.table"; set format "%.5f"
set samples 100.0; set parametric; plot [t=-2:2] [] [] log10(10**t),-(t < log10(1./0.3) ? 20*log10(1) : 20*log10(0.1*10.0*1/(0.3))-20*log10(10**t))
