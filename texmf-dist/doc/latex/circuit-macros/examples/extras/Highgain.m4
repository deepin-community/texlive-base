.PS
# Highgain+.m4
sinclude(tst.dim)
s_init(Highgain)
darrow_init

fillval = 0.8
circlerad = 0.35/2
linewid = linewid*3/4

command "
\newcommand{\Ds}{D(s)}
\newcommand{\Gs}{G(s)}
\newcommand{\Hs}{H(s)}
\newcommand{\Ms}{M(s)}
\newcommand{\Ns}{N(s)}
\newcommand{\Ps}{P(s)}
\newcommand{\Qs}{Q(s)}
\newcommand{\Rs}{R(s)}
\newcommand{\Ss}{S(s)}
\newcommand{\Us}{U(s)}
\newcommand{\Ys}{Y(s)}
\newcommand{\Xs}{X(s)}
\newcommand {\mat}[1]{\left[\matrix{#1}\right]}
\newcommand {\adj}{\mathop{\hbox{adj}}\nolimits}
\newcommand {\coldim}{\mathop{\hbox{col dim}}\nolimits}
\newcommand {\colrank}{\mathop{\hbox{column rank}}\nolimits}
\newcommand {\column}{\mathop{\hbox{column}}\nolimits}
\newcommand {\diag}{\mathop{\hbox{diag}}\nolimits}
\newcommand {\trace}{\mathop{\hbox{trace}}\nolimits}
\newcommand {\image}{\mathop{\hbox{image}}\nolimits}
\newcommand {\kernel}{\mathop{\hbox{kernel}}\nolimits}
\newcommand {\opsim}[1]{\mathinner{\raise-.5ex\hbox{\scriptsize #1}\atop%
  \raise1.5ex\hbox{$\sim$}}}
\newcommand {\order}{\mathop{\hbox{order}}\nolimits}
\newcommand {\rank}{\mathop{\hbox{rank}}\nolimits}
\newcommand {\rowdim}{\mathop{\hbox{row dim}}\nolimits}
\newcommand {\rowimage}{\mathop{\hbox{row image}}\nolimits}
\newcommand {\row}{\mathop{\hbox{row}}\nolimits}
\newcommand {\rowrank}{\mathop{\hbox{row rank}}\nolimits}
\newcommand {\zeros}{\mathop{\hbox{zeros}}\nolimits}
"

define(`vectorsize',
 `{"$\phantom{\displaystyle `$1'}%
    \atop{{\displaystyle /}\atop{\displaystyle `$1'}}$"\
    `$2' }')

[
R: darrow(right linewid,,,,,,|-)
  { "$R$" dabove(at R.start+(5pt__,0)) }
Sum: circle invis "$\sum$"
  darrow(right_ linewid*5/4)
  { "$E$" dabove(at last line) }
  vectorsize(p,at 1/4 along_(last line))
Gain: shadebox(box "$G = \diag\mat{g_i}$" wid boxwid*1.5 ht boxht*0.75 )
  darrow(,,,,,,!-)
  { "$U^{\prime}$" dabove(at last line) }
Compensator: shadebox(box wid boxwid*1.5 "\sl Compensator" "$K(s)$")
  darrow(right_ linewid*5/4,,,,,,!-)
  vectorsize(m,at 1/4 along_(last line))
  { "$U$" dabove(at last line) }
Plant: shadebox(box "\sl Plant" "$H(s)$" )
  dline(right_ linewid*3/4 from Plant.e,,,,!-)
  vectorsize(p,at last line)
Y: dtee(R)
  {"$Y$" dabove}
  darrow(right_ linewid*2/3,t)

  dline(down boxht from Y,t)
  dright
  dline(to (Sum,Here),,t)
  dright
  darrow(to Sum.s)
  "$-$" at Here+(0.10,-0.05)

  circle at Sum
]
# blockbox(N)
.PE
