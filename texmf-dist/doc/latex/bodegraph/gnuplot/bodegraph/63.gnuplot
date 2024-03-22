set table "gnuplot/bodegraph/63.table"; set format "%.5f"
set samples 100.0; set parametric; plot [t=-1:4] [] [] log10(10**t),(t<log10(15)? 0:-180) -(t<log10(1./(0.01))? 0:-90)
