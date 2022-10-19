set table "gnuplot/bodegraph/87.table"; set format "%.5f"
set samples 2; set parametric; plot [t=-1:0.3] 10**((20*log10(abs(4/sqrt(1+(0.5*10**t)**2)))+0)/20)*cos(3.1415957/180*(-180/3.1415957*atan(0.5*10**t)+-1.8*10**t)),10**((20*log10(abs(4/sqrt(1+(0.5*10**t)**2)))+0)/20)*sin(3.1415957/180*(-180/3.1415957*atan(0.5*10**t)+-1.8*10**t))
