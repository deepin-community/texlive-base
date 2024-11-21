%%
%%  longmath-doc.cls is part of longmath version 1.0. 
%%
%%  (c) 2024 Hans-Jürgen Matschull
%%
%%  This work may be distributed and/or modified under the
%%  conditions of the LaTeX Project Public License, either version 1.3
%%  of this license or (at your option) any later version.
%%  The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%%  and version 1.3 or later is part of all distributions of LaTeX
%%  version 2005/12/01 or later.
%% 
%%  This work has the LPPL maintenance status 'maintained'.
%%  
%%  The Current Maintainer of this work is Hans-Jürgen Matschull
%% 
%%  see README for a list of files belonging to longmath.
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{longmath-doc}[2024/07/04]
\LoadClass[a4paper,10pt]{scrartcl}
\RequirePackage{geometry}
\geometry{hmargin=20mm,vmargin={20mm,30mm}}
\RequirePackage{tikz}

\let\codefont\normalsize
\let\execfont\normalsize

\definecolor{pcol}{rgb}{0.1 0.0 0.3}
\definecolor{pcol}{rgb}{0.1 0.0 0.3}

\RequirePackage[no-math]{fontspec}
\setmainfont{Linux Libertine}
\setmonofont[Scale=0.80]{Cascadia Mono PL}
\setsansfont[Scale=0.85]{Droid Sans}


\RequirePackage{unicode-math}
\setmathfont{Tex Gyre Pagella Math}

\RequirePackage{amsmath}

\def\p#1{\textcolor{pcol}{\textsf{#1}}} 

\definecolor{code}{rgb}{0.4 0.6 0.8}
\definecolor{exec}{rgb}{0.8 0.6 0.3}

\colorlet{codeback}{code!02!white}
\colorlet{execback}{exec!03!white}
\colorlet{whiteback}{white}

\colorlet{codebord}{code!50!gray}
\colorlet{execbord}{exec!50!gray}
\colorlet{whitebord}{white}

\definecolor{codetext}{rgb}{0.0 0.0 0.1}
\definecolor{codeword}{rgb}{0.2 0.0 0.2}
\definecolor{codedefn}{rgb}{0.1 0.2 0.1}
\definecolor{codenumb}{rgb}{0.1 0.0 0.3}
\definecolor{codepunc}{rgb}{0.4 0.2 0.0}
\definecolor{codestring}{rgb}{0.4 0.0 0.0}
\definecolor{codekey}{rgb}{0.5 0.3 0.0}
\definecolor{codemacro}{rgb}{0.2 0.0 0.2}
\definecolor{codeluac}{rgb}{0.3 0.0 0.1}
\definecolor{codemath}{rgb}{0.4 0.2 0.0}
\definecolor{codeoper}{rgb}{0.2 0.0 0.2}
\definecolor{codegroup}{rgb}{0.6 0.3 0.0}
\definecolor{coderest}{rgb}{0.9 0.0 0.9}
\definecolor{codespace}{rgb}{0.0 0.0 0.0}
\definecolor{codecomm}{rgb}{0.3 0.3 0.3}

\newcatcodetable\longmathdoc@cctable@
\savecatcodetable\longmathdoc@cctable@
\newcount\longmathdoc@ccnum@
\longmathdoc@ccnum@=\the\longmathdoc@cctable@

\setbox0\hbox{\codefont\texttt{0}}
\newdimen\ttwidth\ttwidth=\wd0

\directlua{ longmathdoc = require 'longmath-doc.lua' }

\newsavebox{\codebox}
\newsavebox{\execbox}
\newdimen\boxsize 
\newdimen\codesize 
\newdimen\execsize 
\newdimen\halfsize 
\newdimen\fullsize 

\newif\ifcode 

\def\skipin{\ifhmode\par\fi\ifdim\prevdepth>\dp\strutbox\relax\vskip-0.5\fboxsep\fi}
\def\skipex{\ifhmode\par\fi\ifdim\prevdepth>\dp\strutbox\relax\vskip 1.0\fboxsep\fi}

\def\xpar{\vskip 0.5\fboxsep\par}

\fboxsep = 1.1mm

\def\codeframe#1{\fcolorbox{#1bord}{#1back}{\box\codebox}}
\def\execframe#1{\fcolorbox{#1bord}{#1back}{\box\execbox}}

\def\.{\strut\\}
\def\:{\strut\\[-1.9\baselineskip]}

\def\startcode#1{\begingroup\let\do\@makeother\dospecials\@makeother\"\directlua{longmathdoc.readcode('#1')}}
\def\startexec{\begin{lrbox}{\execbox}\begin{minipage}[t]{\execsize}
\execfont\abovedisplayskip 5pt \abovedisplayshortskip 5pt }
\def\stopexec{\end{minipage}\end{lrbox}\dp\execbox = \dimexpr \dp\execbox + 2pt \relax }

\def\makecodebox{\begin{lrbox}{\codebox}\begin{minipage}[t]{\codesize}\codefont\ttfamily
                  \directlua{longmathdoc.writecode()}\end{minipage}\end{lrbox}}

\newenvironment{code*}
{\xpar\startcode{code*}}
{\codesize = \dimexpr \linewidth - 2 \fboxrule - 2 \fboxsep \relax 
  \makecodebox\skipin\par\codeframe{code}\xpar}
 
\newenvironment{code+}
{\par\startcode{code+}}
{\global\codetrue \global\codesize = \codesize }
 
\newenvironment{code}
{\par\startcode{code}}
{\halfsize = \dimexpr 0.5 \linewidth - 2 \fboxrule - 2 \fboxsep - 0.5 \parskip \relax
 \global\codetrue \ifdim \codesize < \halfsize \relax \global\codesize = \halfsize \fi}
 
\def\makesize{
  \ifcode 
    \execsize = \dimexpr \linewidth - 4 \fboxrule - 4 \fboxsep - 1.2 \parskip - \codesize \relax   
  \else 
    \execsize = \dimexpr \linewidth - 2 \fboxrule - 2 \fboxsep \relax 
  \fi 
}

\newenvironment{exec}
{\makesize\makecodebox\startexec\raggedright}
{\stopexec\skipin\ifcode\doublebox{code}{exec}\else\xpar\execframe{exec}\fi\global\codefalse\xpar} 

\newenvironment{exec*}
{\makesize\makecodebox\startexec}
{\stopexec\skipin\ifcode\doublebox{code}{exec}\else\xpar\execframe{exec}\fi\global\codefalse\xpar} 
 
\def\doublebox#1#2{%
  \ifdim \ht\codebox>\ht\execbox \ht\execbox=\ht\codebox \else  \ht\codebox=\ht\execbox \fi 
  \ifdim \dp\codebox>\dp\execbox \dp\execbox=\dp\codebox \else  \dp\codebox=\dp\execbox \fi 
  \xpar\codeframe{#1}\hfill\execframe{#2}
}

\def\ecomm{\quad}
\def\bcomm{\egroup}
\begingroup\catcode`\{=\active\global\let{\bcomm\endgroup
\def\comm{\par\skipex\noindent $\bullet$ \bgroup\aftergroup\ecomm\bgroup\catcode`\{=\active}

\begingroup
\catcode`"\active 
\gdef\verbA{\begingroup\let\do\@makeother\dospecials\let"\verbB\directlua{ longmathdoc.readstring() }}
\gdef\verbB{\endgroup\directlua{ longmathdoc.writestring() }}
\gdef"{\verbA}
\endgroup

\def\verbC#1{\texttt{\textcolor{codetext!50!black}{#1}}}

\catcode`°\active \def°#1°{\textsl{#1}}

\AtBeginDocument{\catcode`"\active}

\endinput 
