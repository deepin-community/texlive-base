set table "gnuplot/bodegraph/63.table"; set format "%.5f"
set samples 150; set parametric; plot [t=1:5] 180/3.1415957*(atan((1500**2-(10**t)**2)/(2*0.1*1500*10**t))-3.1415957/2)+-90-2*-180/3.1415957*atan(0.0009*10**t),20*log10(abs(1/sqrt((1-(10**t/1500)**2)**2+(2*0.1*(10**t/1500))**2)))+20*log10(abs(0.43/0.0009/(10**t)))-2*20*log10(abs(1/sqrt(1+(0.0009*10**t)**2)))
