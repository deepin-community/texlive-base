set table "gnuplot/bodegraph/13.table"; set format "%.5f"
set samples 100.0; set parametric; plot [t=-2:2] [] [] log10(10**t),(t < log10(1./0.3) ? 20*log10(6) : 20*log10(0.1*10.0*6/(0.3))-20*log10(10**t))
