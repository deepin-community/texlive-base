set table "gnuplot/bodegraph/40.table"; set format "%.5f"
set samples 201.0; set parametric; plot [t=0:3] [] [] log10(10**t),-90+((t<log10(1./(0.08))? 0:-90))*(-1)
