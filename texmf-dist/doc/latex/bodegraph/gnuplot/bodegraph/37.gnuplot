set table "gnuplot/bodegraph/37.table"; set format "%.5f"
set samples 50.0; set parametric; plot [t=0:3] [] [] log10(10**t),20*log10(abs(1/(10**t)))+20*log10(2/0.08)-20*log10(abs(1/sqrt(1+(0.08*10**t)**2)))
