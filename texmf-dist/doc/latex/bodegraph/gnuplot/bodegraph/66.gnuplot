set table "gnuplot/bodegraph/66.table"; set format "%.5f"
set samples 150.0; set parametric; plot [t=-1:3.5] [] [] 180/3.1415957*(atan((150**2-(10**t)**2)/(2*0.2*150*10**t))-3.1415957/2), 20*log10(abs(5/sqrt((1-(10**t/150)**2)**2+(2*0.2*(10**t/150))**2)))
