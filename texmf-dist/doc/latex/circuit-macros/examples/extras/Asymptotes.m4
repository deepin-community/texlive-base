.PS
# Asymptotes.m4
# https://tex.stackexchange.com/questions/706340/create-an-asymptotes-summary-diagram-for-a-function
gen_init

definergbcolor(armygreen,0.29,0.33,0.13)
definergbcolor(vlightgray,0.95,0.95,0.95)
boxrad = 7bp__

define(`greenbox',`box wid 90bp__ \
  outlined "armygreen!90" shaded "armygreen!90" \
  "{\color{white} `$1'}" ')

define(`graybox',`box thick 0.4 outlined "gray" shaded "vlightgray" \
  `$1'')

  changequote(,) command "\newcommand{\eace}{\'e}
    \newcommand{\squote}{\char39}
    \newcommand{\dequation}{d'\'equation}"
  changequote(`,)

foreach_(`txt',`L`'m4Lx: graybox(wid 72bp__ ht 130 bp__ \
  "\parbox{72bp}{\begin{centering}
   {\sf txt \\ \vfill\vbox{}}
   \end{centering}}")
   ifelse(m4Lx,6,,`move 10bp__')',

  `$(C_f)$ admet\\ Une asymptote\\ horizontale\\ \dequation:\\
   $y = a$\\ au voisinage\\ de $\infty$',

  `$(C_f)$ admet\\ Une asymptote\\ oblique\\ \dequation:\\
   $y = ax+b$\\ au voisinage\\ de $\infty$',

  `\hbox{}\vspace*{0.5\baselineskip}
   $(C_f)$ admet\\ Une branche\\ parabolique\\ de direction\\
   la droite\\ \dequation:\\
   $y = ax$\\ au voisinage\\ de $\infty$',

  `$(C_f)$ admet\\ Une branche\\ parabolique\\ de direction\\
   l\squote{}axe des\\ ordonn\eace{}s\\ au voisinage\\ de $\infty$',

  `$(C_f)$ admet\\ Une branche\\ parabolique\\ de direction\\
   l\squote{}axe des\\ abscisses\\ au voisinage\\ de $\infty$',

  `\vspace*{1ex}$(C_f)$ admet\\ Une \\ asymptote\\ verticale\\
   \dequation:\\[1ex]
   $x = a$\\ \hbox{}\hfill\hbox{}')

 M: [ M1: graybox(wid 105bp__ \
         "$\lim\limits_{x\rightarrow\infty} [f(x)-ax] = b$")
         move 3bp__
      M2: graybox(wid 105bp__ \
         "$\lim\limits_{x\rightarrow\infty} [f(x)-ax] = \infty$")
     ] with .s at ((L2.x+L4.x)/2,L2.n.y+boxht)

 U:[ foreach_(`txt',`U`'m4Lx:graybox(wid 100bp__ ifelse(m4Lx,1,`+20bp__') "txt")
      ifelse(m4Lx,4,,`move 2bp__')',
      `$\lim\limits_{x\rightarrow\infty} [f(x)-(ax{+}b)] = 0$',
      `\(\lim\limits_{x\rightarrow\infty} \frac{f(x)}{x} =
        \raisebox{-0.5ex}{$a \atop {(a \neq 0)}$}\)',
      `\(\lim\limits_{x\rightarrow\infty} \frac{f(x)}{x} = \infty \)',
      `\(\lim\limits_{x\rightarrow\infty} \frac{f(x)}{x} = 0 \)')
     ] with .s at ((L1.x+L6.x)/2,M.n.y+boxht)

  T1: greenbox($\lim\limits_{x\rightarrow\infty} f(x) = a$) \
        with .s at (L1.x,U.n.y+boxht)
  T2: greenbox($\lim\limits_{x\rightarrow\infty} f(x) = \infty$) \
        with .s at ((L1.x+L6.x)/2,T1.s.y)
  T3: greenbox($\lim\limits_{x\rightarrow a} f(x) = \infty$) \
        with .e at (L6.e.x,T2.y)

  linethick_(1)
  arrow from (U.w.x-5bp__,T1.s.y) down T1.s.y-L1.n.y
  A: (T2.w.x,T2.s.y+boxrad); B1: U.U1.n+(boxht,0)
  move to A; arcto((B1,A),B1,boxrad*3/2); arrow to B1
  A: (U.U3.w.x+boxrad,T2.s.y); arrow from A to (A,U.U3.n)
  B2: (1/2 between M.M1.e and M.M2.w,U.U2.n)
  line from A+(-5bp__,0) down_ 10bp__ then left 10bp__
  arcto((B2,Here),B2,boxrad*3/2); arrow to B2 
  B3: (L5.e.x-2*boxrad,U.U4.n.y)
  line from A+( 5bp__,0) down_ 10bp__ then right_ 10 bp__
  arcto((B3,Here),B3,boxrad*3/2); arrow to B3
  arrow from (B3,U.U4.s) to (B3,L5.n)
  arrow from (U.U4.e.x+5bp__,T3.s.y) down T3.s.y-L6.n.y
  line from U.U2.s+(-5bp__,0) down_ 10bp__ then left_ 10bp__
  arcto((M.M1.n,Here),M.M1.n,boxrad*3/2); arrow to M.M1.n
  arrow from (Here,M.M1.s) down M.M1.s.y-L2.n.y
  line from U.U2.s+( 5bp__,0) down_ 10bp__ then right_ 10bp__
  arcto((M.M2.n,Here),M.M2.n,boxrad*3/2); arrow to M.M2.n
  arrow from (L3.e.x-boxrad*3/2,M.M2.s.y) down M.M2.s.y-L3.n.y
  arrow from (M.M2.e.x+5bp__,U.U3.s.y) down U.U3.s.y-L4.n.y
  arrow from (M.w.x-5bp__,U.U1.s.y) down U.U1.s.y-L2.n.y
.PE
