set table "gnuplot/bodegraph/61.table"; set format "%.5f"
set samples 50.0; set parametric; plot [t=-1:4] [] [] log10(10**t),(t<log10(15)?20*log10(5):+20*log10(5)+40*log10(15)-40*log10(10**t))- (t < log10(1./0.01) ? 20*log10(1) : 20*log10(0.1*10.0*1/(0.01))-20*log10(10**t))
