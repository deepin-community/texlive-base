set table "gnuplot/bodegraph/24.table"; set format "%.5f"
set samples 50.0; set parametric; plot [t=-2:2] [] [] log10(10**t),(t < log10(1./(70/6)) ? 20*log10((3*4/6)) : 20*log10(0.1*10.0*(3*4/6)/((70/6)))-20*log10(10**t))-(t < log10(1./(5/4)) ? 20*log10(1) : 20*log10(0.1*10.0*1/((5/4)))-20*log10(10**t))
