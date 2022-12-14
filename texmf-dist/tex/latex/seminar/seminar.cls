%% BEGIN seminar.cls
%% LaTeX2e seminar class, derived by Sebastian Rahtz from
%% LaTeX document style `seminar', for use with LaTeX v2.09.
%% generated on <1993/10/8>. 
%% Fixes from David Carlisle, Denis Girou, 
%% and Frank Küster/Günter Milde (a4paper option fix)
%%
\def\fileversion{1.63a}
\def\filedate{2021/07/01}
%%
%% This is a style for typesetting notes and slides.
%%
%% COPYRIGHT 1993--, by Timothy Van Zandt, Timothy.VAN-ZANDT@insead.edu
%%
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.2 of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.2 or later is part of all distributions of LaTeX version
%% 1999/12/01 or later.
%%
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{seminar}[\filedate, \fileversion]
\typeout{%
  Documentclass: `seminar' v\fileversion \space <\filedate> (tvz,hv)}
%%%%%%%%%%%%%%%% fix hv 
\def\tx@BOL{}
%%%%%%%%%%%%%%%
\def\test@member#1#2{%
  \edef\@tempg{,#2,#1,}%
  \edef\@temph{####1,#1,}%
  \expandafter\def\expandafter\@temph\@temph##2\@nil{%
    \def\@tempg{##2}%
    \ifx\@tempg\@empty\@testfalse\else\@testtrue\fi}%
  \expandafter\@temph\@tempg\@nil}
\def\addto@hook#1#2{#1\expandafter{\the#1#2}}
\@ifundefined{reset@font}{\def\reset@font{\normalsize\rm}}{}
\def\@seminarerr#1#2{%
  \edef\@tempc{#2}\expandafter\errhelp\expandafter{\@tempc}%
  \typeout{^^JSeminar.sty error.\space\space\space
    Type \space H <return> \space for immediate help.^^J}%
  \errmessage{#1^^J}}
\def\notslide@err#1{\message{Cannot use \string#1 in slide environments}}
\def\new@slidebox{\alloc@4\box\chardef\insc@unt}
\RequirePackage{pst-ovl}
%%
%\RequirePackage{geometry}
%\geometry{dvips,paperwidth=8.5in,paperheight=11in}
\newdimen\slidewidth \slidewidth 8.5in
\newdimen\slideheight \slideheight 6.3in
\paperwidth=8.5in
\paperheight=11in
%%
\def\addto@preamblecmds#1{%
  \begingroup
    \def\do{\noexpand\do\noexpand}%
    \xdef\@preamblecmds{\@preamblecmds\do#1}%
  \endgroup}
\addto@preamblecmds{\addto@preamblecmds\do\@preamblecmds}
\def\sem@temp#1{\@ifundefined{if#1}%
  {\def\@tempa{\csname newif\endcsname}
  \expandafter\@tempa\csname if#1\endcsname}{}}
\sem@temp{article}{}
\sem@temp{slidesonly}{}
\sem@temp{notes}{}
\sem@temp{notesonly}{}
\sem@temp{notesonlystar}{}
\sem@temp{portrait}{}
\DeclareOption{article}{\articletrue}
\DeclareOption{noxcomment}{\def\xcomment@hook{}}
\DeclareOption{slidesonly}{\slidesonlytrue\notesfalse\notesonlyfalse}
\DeclareOption{notes}{\notestrue\slidesonlyfalse\notesonlyfalse}
\DeclareOption{notesonly}{\notesonlytrue\slidesonlyfalse\notesfalse}
\DeclareOption{notesonly*}{%
  \notesonlytrue\slidesonlyfalse\notesfalse\notesonlystartrue}
\DeclareOption{portrait}{\portraittrue}
\DeclareOption{a4}{%
  \paperwidth 210mm
  \paperheight 297mm
%  \geometry{paperwidth=210mm,paperheight=297mm}
  \slidewidth 222mm
  \slideheight 152mm\relax}
\DeclareOption{a4paper}{\csname ds@a4\endcsname}%
\DeclareOption{semrot}{\AtEndOfClass{\input{semrot.sty}}}
\DeclareOption{semhelv}{\AtEndOfClass{\input{semhelv.sty}}}
\DeclareOption{semcolor}{\AtEndOfClass{\input{semcolor.sty}}}
\DeclareOption{semlcmss}{\AtEndOfClass{\input{semlcmss.sty}}}
\DeclareOption{slidesec}{\AtEndOfClass{\input{slidesec.sty}}}
\DeclareOption{semlayer}{\AtEndOfClass{\input{semlayer.sty}}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\ifnotesonly\else\notesonlystarfalse\fi
\newdimen\footheight  % seminar.sty v1.0 uses it, but its not in LaTeX2e.
% Don't want these changed by article.cls:
\let\sem@paperheight\paperheight
\let\sem@paperwidth\paperwidth
\let\paperheight\footheight
\let\paperwidth\footheight
\LoadClass{article}

\RequirePackage{pst-ovl}%    hv 20131224

\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xpt\@xiipt
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@slide@listi}
\let\paperheight\sem@paperheight
\let\paperwidth\sem@paperwidth
\RequirePackage{sem-page}
\newtoks\before@document
\newtoks\after@document
\let\xcomment@hook\relax
\before@document{\the\before@document}
%\before@document{\endgroup\the\before@document\begingroup}
\after@document{\the\after@document\xcomment@hook}
\expandafter\@temptokena\expandafter{\document}
\edef\document{\the\before@document\the\@temptokena\the\after@document}
\before@document{}
\after@document{}
\newtoks\before@enddocument
\before@enddocument{\the\before@enddocument}
\expandafter\@temptokena\expandafter{\enddocument}
\edef\enddocument{\the\before@enddocument\the\@temptokena}
\before@enddocument{}
\newif\ifprintlandscape
\ifportrait
  \ifarticle\printlandscapetrue\fi
\else
  \ifarticle\else\printlandscapetrue\fi
\fi
\addto@hook\before@document{\ifprintlandscape\printlandscape\fi}
\addto@preamblecmds{\printlandscape}
\def\printlandscape{\addto@hook\before@enddocument{%
  \typeout{^^J%
  *******************************************************^^J%
  ***** !! PRINT THIS DOCUMENT IN LANDSCAPE MODE !! *****^^J%
  *******************************************************}}}
\def\slide{%
  \NestedSlide@Error{slide}%
  \landscapetrue
  \@ifnextchar[{\begin@slide}{\begin@slide[\slidewidth,\slideheight]}}
\def\endslide{\end@slide}
\@namedef{slide*}{%
  \NestedSlide@Error{slide*}%
  \landscapefalse
  \@ifnextchar[{\begin@slide}{\begin@slide[\slidewidth,\slideheight]}}%
\@namedef{endslide*}{\end@slide}
\newcounter{slide}
\def\theslide{\arabic{slide}}
\newcount\slide@count
\newbox\@slidebox
\newbox\not@slidebox
\newif\ifslide
\newif\iflandscape
\def\@landscapeonly{0}
\def\landscapeonly{\def\@landscapeonly{1}}
\def\portraitonly{\def\@landscapeonly{-1}}
\def\NestedSlide@Error#1{%
  \ifslide
    \endgroup
    \@seminarerr{Nested slide environments. Perhaps missing
      \string\end{\@currenvir}. May be fatal}\@ehd
    \expandafter\end\expandafter{\@currenvir}%
    \ifslide\expandafter\end\expandafter{\@currenvir}\fi
    \begingroup
    \def\@currenvir{#1}%
  \fi}
\def\begin@slide[#1,#2]{%
  \slide@clearpage
  \setlength\slidewidth{#1}%
  \setlength\slideheight{#2}%
  \begingroup
    \ifarticle
      \output{%
        \advance\count@ 1
        \global\setbox\not@slidebox\box\@cclv}%
      \par\@@par\penalty-\@M
    \fi
    \output{\slide@output}%
    \slidetrue
    \ifarticle\global\slide@count=\z@\fi
    \refstepcounter{slide}%
    \ifnotesonlystar\xdef\first@slidemarker{\the\c@slide}\fi
    \def\do##1{\setcounter{##1}\z@}\slide@reset
    \ifarticle\else
      \edef\page@textheight{\number\textheight sp}%
      \edef\page@textwidth{\number\textwidth sp}%
    \fi
    \set@slidesize
    \slidebox@restore
    \the\slide@hook
    \the\before@newslide
    \everyslide}
\def\end@slide{%
    \par\penalty-\@M
    \xdef\@tempg{\@currenvir}%
  \endgroup
  \ifslide
    \@seminarerr{Perhaps missing `\string\end{\@tempg}',
      \iffalse{\fi`\string}' or `\string\endgroup'}\@ehd
    \def\next{\endgroup\ifslide\expandafter\next\fi}%
    \next
  \fi
  \begingroup
    \output{\setbox\@tempboxa\box\@cclv}%
    \@@par\penalty-\@M
  \endgroup
  \global\advance\c@slide-1
  \def\do##1{\setcounter{##1}{\@nameuse{saved@c@##1}}}%
  \slide@reset
  \ifarticle\outputloop@savedslides\fi
  \the\after@slide}
\let\slideclearpagetrue\relax
\let\slideclearpagefalse\relax
\ifarticle
  \def\slide@clearpage{\par\penalty\z@}
  \ifnotes
    \def\slideclearpagetrue{\def\slide@clearpage{\clearpage}}
    \def\slideclearpagefalse{\def\slide@clearpage{\par\penalty\z@}}
  \else
    \ifnotesonly
      \def\slideclearpagetrue{\def\slide@clearpage{\clearpage}}
      \def\slideclearpagefalse{\def\slide@clearpage{\par\penalty\z@}}
    \fi
  \fi
\else
  \def\slide@clearpage{\clearpage}
\fi
\newtoks\slide@hook
\def\everyslide{}
\newtoks\after@slide
\def\slidebox@restore{%
  \def\thepage{\theslide}%
  \def\newpage{\newslide}%
  \def\clearpage{\newslide}%
  \def\thispagestyle##1{\notslide@err{\thispagestyle}}%
  \pagestyle{\slide@pagestyle}%
  \@twocolumnfalse
  \def\twocolumn{\notslide@err{\twocolumn}}%
  \def\onecolumn{\notslide@err{\onecolumn}}%
  \def\marginpar##1{\notslide@err{\marginpar}}%
  \def\thanks{\slidethanks}%
  \def\maketitle{\slidemaketitle}%
  \fix@floats
  \fix@whatsits
  \slide@footnotes
  \def\do##1{\expandafter\xdef\csname
   saved@c@##1\endcsname{\the\@nameuse{c@##1}}}%
  \slide@reset
  \topskip\z@ \maxdepth\z@
  \slide@listparameters
  \slidefonts
  \def\baselinestretch{\slidestretch}%
  \def\arraystretch{\slidearraystretch}%
  \sem@ptsize{\slide@ptsize}}
\def\date#1{\gdef\@date{#1}\gdef\thedate{#1}}
\def\author#1{\gdef\@author{#1}\gdef\theauthor{#1}}
\def\title#1{\gdef\@title{#1}\gdef\thetitle{#1}}
\date{\today}
\let\slidethanks\thanks
\def\thethanks{\@thanks}%
\def\slidemaketitle{%
  \par
  \begin{center}\bf
    {\large \thetitle}\par\vskip 1ex
    \begin{tabular}[t]{c} \theauthor \end{tabular}\par\vskip 1ex
    \thedate
  \end{center}%
  \thethanks\par}
\def\fix@floats{%
  \def\@xfloat##1[##2]{%
    \expandafter\let\csname end##1\endcsname\end@float
    \par\medskip\vbox\bgroup\def\@captype{##1}\parindent\z@
    \ignorespaces}%
  \def\end@float{\par\vskip\z@\egroup\medskip}%
  \def\@dblfloat{\@float}\def\end@dblfloat{\end@float}%
  \def\endfigure{\end@float}\def\endtable{\end@float}}
\let\normal@write\write
\let\normal@read\read
\let\normal@openout\openout
\let\normal@closeout\closeout
% changed as per DPC 1997/09/16
\def\fix@whatsits{%
  \long\def \protected@write##1##2##3{%
      \begingroup
       ##2%
       \let\protect\noexpand
       \immediate\normal@write##1{##3}%
      \endgroup
      \if@nobreak\ifvmode\nobreak\fi\fi}%
}
% end change
\newinsert\slide@footins
\skip\slide@footins=\bigskipamount
\count\slide@footins=1000
\dimen\slide@footins=4in
\def\theslidefootnote{\alph{footnote}}
\def\slide@footnotes{%
  \def\thefootnote{\theslidefootnote}%
  \let\footins\slide@footins
  \interfootnotelinepenalty\@M}
\def\slidefonts{}
\def\slidestretch{1.18}
\def\slidearraystretch{1.2}
\def\raggedslides{\@ifnextchar[{\@raggedslides}{\@raggedslides[1fil]}}
\def\@raggedslides[#1]{%
  \edef\slide@@rightskip{#1}%
  \ifslide\slide@rightskip\fi}
\def\slide@rightskip{%
  \@rightskip\z@ plus \slide@@rightskip\relax \rightskip\@rightskip}
\def\slide@@rightskip{1fil}
\newcount\slide@listdepth
\def\slide@listparameters{%
  \let\@listdepth\slide@listdepth
  \slide@listdepth\z@
  \def\@listi{\slide@listi}%
  \def\@listii{\slide@listii}%
  \def\@listiii{\slide@listiii}%
  \let\@listiv\relax\let\@listv\relax\let\@listvi\relax}
\def\slide@listi{%
  \leftmargin\leftmargini
  \labelwidth\leftmargini \advance\labelwidth-\labelsep
  \parsep\parskip \divide\parsep2
  \partopsep\slidepartopsep\relax
  \advance\partopsep-\parskip
  \ifdim\partopsep<\z@\partopsep\z@\fi
  \itemsep\slideitemsep\relax
  \ifdim\parsep<\itemsep
    \topsep\itemsep \advance\topsep-\parsep
  \else
    \itemsep\parsep \topsep\z@
  \fi}
\def\slide@listii{%
  \leftmargin\leftmarginii
  \labelwidth\leftmarginii \advance\labelwidth-\labelsep
  \divide\itemsep2 \divide\parsep2
  \divide\topsep2 \divide\partopsep2\relax}%
\def\slide@listiii{%
  \leftmargin\leftmarginiii
  \labelwidth\leftmarginiii \advance\labelwidth-\labelsep
  \itemsep \z@ \parsep\z@ \topsep\z@}%
\def\slideleftmargini{1.8em}
\def\slideleftmarginii{1.4em}
\def\slideleftmarginiii{1em}
\def\slidelabelsep{.5em}
\def\slideitemsep{.8ex minus .2ex}
\def\slidepartopsep{1ex minus .2ex}
\newbox\saved@specials
\def\save@slidespecials{%
  \begingroup
    \output{%
      \global\setbox\saved@specials=\box\@cclv
      \global\wd\saved@specials=\z@
      \global\dp\saved@specials=\z@
      \global\ht\saved@specials=\z@}%
    \hbox{}\penalty-\@M
    \global\let\saved@texttop\@texttop
    \gdef\@texttop{%
      \ifvoid\saved@specials\else\box\saved@specials\nointerlineskip\fi
      \saved@texttop
      \global\let\@texttop\saved@texttop}%
  \endgroup}
\addto@hook\after@document{\save@slidespecials}
\ifarticle\else
  \def\insert@specials{%
    \ifvoid\saved@specials\else
      \setbox\@slidebox\hbox{\box\saved@specials\box\@slidebox}%
    \fi
    \global\let\insert@specials\relax}
\fi
\def\extraslideheight#1{%
  \@tempdima #1\relax
  \edef\X@SlideHeight{\number\@tempdima sp}
  \ifslide\set@slidesize\fi}
\extraslideheight{6pt}
\def\set@slidesize{%
  \iflandscape
    \hsize=\inverseslidesmag\slidewidth
    \vsize=\inverseslidesmag\slideheight
  \else
    \hsize=\inverseslidesmag\slideheight
    \vsize=\inverseslidesmag\slidewidth
  \fi
  \edef\slide@vsize{\number\vsize sp}%
  \textheight\vsize
  \advance\vsize\X@SlideHeight\relax
  \textwidth\hsize\columnwidth\hsize\linewidth\hsize}
\def\newslide{%
  \par\penalty-\@M
  \def\do##1{\setcounter{##1}\z@}\slide@reset
  \the\before@newslide
  \set@slidesize}
\newtoks\before@newslide
\def\slide@reset{\do{footnote}}
\def\slidereset#1{\def\slide@reset{}\addtoslidereset{#1}}
\def\addtoslidereset#1{%
  \edef\@tempa{#1}\expandafter\addto@slidereset\@tempa,\@nil,}
\def\addto@slidereset#1,{%
  \ifx\@nil#1\else
    \@ifundefined{c@#1}%
      {\@seminarerr{Counter `#1' not defined}\@ehd}%
      {\expandafter\def\expandafter\slide@reset\expandafter{%
        \slide@reset\do{#1}}}%
    \expandafter\addto@slidereset
  \fi}
\def\slide@output{%
  \@makeslide
  \@testfalse
  \ifnotesonly\else
    \iflandscape
      \ifnum\@landscapeonly>-1 \os@test\fi
    \else
      \ifnum\@landscapeonly<1 \os@test\fi
    \fi
  \fi
  \if@test
    \reset@slideoutput
    \@@makeslide
    \process@slide
  \fi
  \refstepcounter{slide}}
\def\reset@slideoutput{%
  \let\par\@@par
  \reset@font
  \def\baselinestretch{1}%
  \@nameuse{1\@ptsize @semptsize}%
  \catcode`\ =10
  \let\-\@dischyph \let\'\@acci \let\`\@accii \let\=\@acciii}
\newif\ifcenterslides
\centerslidestrue
\providecommand\@begindvi{} % added 1997/04/15 SPQR, to cope with very
                            % old LaTeXs
\def\@makeslide{%
  \setbox\@slidebox\vbox{%
    \@begindvi % added 1997/04/15 SPQR
    \unvbox\@cclv
    \ifvoid\slide@footins\else
      \vskip\skip\slide@footins
      \footnoterule
      \unvbox\slide@footins
    \fi
    \vskip\z@}}
\def\@@makeslide{%
  \overfullslide@warning
  \setbox\@slidebox\hbox{%
    \vfuzz=\slidefuzz\relax
    \vbox to\slide@vsize{%
    \ifcenterslides\vskip\z@ plus .0001fil \fi
    \unvbox\@slidebox
    \vskip\z@ plus .0001fil}%
    \the\after@slidepage}%
  \wd\@slidebox\textwidth}
\def\overfullslide@warning{%
  \dimen@\ht\@slidebox
  \advance\dimen@-\slide@vsize\relax
  \ifdim\dimen@>\slidefuzz\relax
    \@warning{Slide \theslide\space overfull by \the\dimen@}%
  \fi}
\def\slidefuzz{2pt}
\newtoks\after@slidepage
\newif\ifrotateheaders
\def\sliderotation#1{\@ifundefined{semsr@#1}%
  {\@latexerr{Slide rotation `#1' not defined.}\@eha}%
  {\@nameuse{semsr@#1}}}
\def\semsr@left{%
  \def\rotate@slide{%
    \setbox\@slidebox\hbox{\leftsliderotation{\box\@slidebox}}}}
\def\semsr@right{%
  \def\rotate@slide{%
    \setbox\@slidebox\hbox{\rightsliderotation{\box\@slidebox}}}}
\def\semsr@none{\let\rotate@slide\relax}
\sliderotation{none}
\def\leftsliderotation#1{%
  \@seminarerr{\string\leftsliderotation\space has not been defined}%
  \@ehd}
\let\rightsliderotation\leftsliderotation
\def\@ifrotateslide#1{%
  \ifx\rotate@slide\relax\else
    \iflandscape\ifportrait#1\fi\else\ifportrait\else#1\fi\fi
  \fi}
\def\process@slide{%
  \slideframewidth=\inverseslidesmag\slideframewidth
  \slideframesep=\inverseslidesmag\slideframesep
  \fboxrule\slideframewidth
  \fboxsep\slideframesep
  \ifarticle
    \@ifrotateslide\rotate@slide
  \else
    \ifrotateheaders\else\@ifrotateslide\rotate@slide\fi
  \fi
  \process@@slide}
\def\process@@slide{\finish@slide\output@slide}
\def\finish@slide{%
  \theslideframe
  \add@slidelabel\slidelabel}
\ifarticle
  \def\output@slide{%
    \global\advance\slide@count1
    \@ifundefined{slidebox@\the\slide@count}%
      {{\globaldefs=1\expandafter
        \new@slidebox\csname slidebox@\the\slide@count\endcsname}}{}%
    \expandafter\global\expandafter\setbox\csname
      slidebox@\the\slide@count\endcsname\box\@slidebox}
\else
  \def\output@slide{%
    \begingroup
      \hoffset=-\inverseslidesmag in
      \voffset=-\inverseslidesmag in
      \setslidelength\@tempdima{%
        \ifportrait\paperwidth\else\paperheight\fi}
      \setslidelength\@tempdimb{%
        \ifportrait\paperheight\else\paperwidth\fi}
      \ifrotateheaders
        \@ifrotateslide{%
          \dimen@=\@tempdima
          \@tempdima=\@tempdimb
          \@tempdimb=\dimen@}
      \fi
      % \oddsidemargin, \evensidemargin, \headheight, \footheight
      % used for scratch:
      \setslidelength\oddsidemargin\slideleftmargin
      \setslidelength\evensidemargin\sliderightmargin
      \setslidelength\headheight\slidetopmargin
      \setslidelength\footheight\slidebottommargin
      % Some page styles like to know \textwidth:
      \textwidth=\@tempdima
      \advance\textwidth-\oddsidemargin
      \advance\textwidth-\evensidemargin
      \setbox\@slidebox=\hbox to \@tempdima{%
        \kern\oddsidemargin
        \vbox to\@tempdimb{%
          \ifnum\fancyput@flag>-1
            \hbox{\kern-\oddsidemargin\do@fancyput}%
          \fi
          \let\label\@gobble
          \let\index\@gobble
          \let\glossary\@gobble
          \vbox to\headheight{%
            \vfill
            \hbox{%
              \slideheadfont\relax\strut
              \hbox to\textwidth{\@oddhead}}%
            \kern\z@}%
          \vfill
          \hbox to\textwidth{\hss\box\@slidebox\hss}%
          \vfill
          \vbox to\footheight{%
            \hbox{%
              \slidefootfont\relax\strut
              \hbox to\textwidth{\@oddfoot}}%
            \vfill}}%
        \hss}%
      \ifrotateheaders\@ifrotateslide\rotate@slide\fi
      \insert@specials
      \shipout\box\@slidebox
    \endgroup
    \let\firstmark\botmark}
  \@ifundefined{fancyput@flag}{\def\fancyput@flag{-1}}{}
\fi
\newskip\slidesep
\slidesep\intextsep
\ifarticle
  \def\fps@fslide{htbp}
  \def\ftype@fslide{32}
  \def\float@savedslide{%
    \begingroup\@float{fslide}%
      \centerline{\box\@slidebox}%
    \end@float\endgroup}%
  \@namedef{float*@savedslide}{%
    \begingroup\@dblfloat{fslide}%
      \centerline{\box\@slidebox}%
    \end@dblfloat\endgroup}%
  \def\center@slide{\hbox{%
    \kern-\@totalleftmargin
    \hbox to \columnwidth{\hss\box\@slidebox\hss}}}%
  \def\onepercol@savedslide{%
    \vbox to .996\textheight{\vss\center@slide\vss}\goodbreak}%
  \def\twopercol@savedslide{%
    \dimen@.5\textheight
    \advance\dimen@-\slidesep
    \ifdim\ht\@slidebox>\dimen@
      \onepercol@savedslide
    \else
      \vbox to .498\textheight{\vss\center@slide\vss}\goodbreak
    \fi}
  \def\here@savedslide{%
    \addvspace\slidesep\center@slide\addvspace\slidesep}
  \@namedef{here*@savedslide}{%
    \goodbreak \hrule \@height\z@ \nobreak \vskip\slidesep \nobreak
    \center@slide
    \nobreak \vskip\slidesep \nobreak \hrule\@height\z@ \goodbreak}
\fi
\ifarticle
  \def\slideplacement#1{\@ifundefined{#1@savedslide}%
    {\@seminarerr{Slide placement `#1' undefined}\@ehd}%
    {\expandafter\let\expandafter\output@savedslide
      \csname #1@savedslide\endcsname}}
\else
  \def\slideplacement#1{}
\fi
\ifarticle
  \ifnotes
    \ifportrait
      \slideplacement{float}
    \else
      \slideplacement{float*}
    \fi
  \else
    \ifportrait
      \slideplacement{onepercol}
    \else
      \slideplacement{twopercol}
    \fi
  \fi
\fi
\ifarticle
  \def\outputloop@savedslides{%
    \global\maxdepth\@maxdepth
    \ifvoid\not@slidebox\else
      \dimen@=\dp\not@slidebox
      \unvbox\not@slidebox
      \hrule height\z@
      \prevdepth\dimen@
      \penalty\z@
    \fi
    \edef\slide@@count{\the\slide@count\relax}%
    \slide@count\z@
    \loop
    \ifnum\slide@count<\slide@@count
      \advance\slide@count1
      \expandafter\setbox\expandafter\@slidebox\expandafter\box
        \csname slidebox@\the\slide@count\endcsname
      \output@savedslide
    \repeat
    \ifnotesonlystar\make@slidemarker\fi}
\fi
\def\make@slidemarker{%
  \addvspace\slidesep
  \moveleft\@totalleftmargin
  \vbox{%
    \hsize\columnwidth
    \hrule height 1pt
    \kern 8pt
    \hbox to \columnwidth{%
      \hss
      \LARGE\bf\the@slidemarker
      \hss}%
    \kern 8pt
    \hrule height 1pt}%
  \addvspace\slidesep}
\def\the@slidemarker{%
  Slide%
  \ifnum\c@slide=\first@slidemarker\else
    s {\c@slide\first@slidemarker\relax\theslide} --\fi
  { }\theslide}%
\ifarticle
  \let\c@note\c@page
  \def\p@note{\p@page}
  \def\thenote{\thepage}
\else
  \newcounter{note}
  \def\thenote{\theslide-\arabic{note}}
  \def\thepage{\thenote}
  \addto@hook\after@slide{\setcounter{note}{1}}
  \expandafter\def\expandafter\@outputpage\expandafter{%
    \@outputpage\stepcounter{note}}
\fi
\ifarticle\else
  \let\c@page\c@slide
  \countdef\c@slide=0
  \c@slide=0
  \c@page=1
\fi
\ifarticle
  \let\truepagenumbers\relax
\else
  \def\truepagenumbers{%
    \let\c@slide\c@page
    \countdef\c@page=0
    \c@page=1
    \c@slide=0
    \let\truepagenumbers\relax}
\fi
\addto@preamblecmds{\truepagenumbers}
\newdimen\slideframewidth \slideframewidth 4pt
\newdimen\slideframesep \slideframesep .3in
\def\newslideframe#1{%
  \@ifnextchar[{\@newslideframe{#1}}{\@newslideframe{#1}[]}}
\def\@newslideframe#1[#2]{%
  \@namedef{semsfops@#1}{#2}%
  \@namedef{semsf@#1}##1}
\newslideframe{plain}{\fbox{#1}}
\def\slideframe{\@slideframe{slide}}
\def\@slideframe#1{%
  \@ifstar{\@testtrue\@@slideframe{#1}}{\@testfalse\@@slideframe{#1}}}
\def\@@slideframe#1{%
  \@ifnextchar[{\@@@slideframe{#1}}{\@@@slideframe{#1}[]}}
\def\@@@slideframe#1[#2]#3{%
  \def\@tempa{none}%
  \def\@tempb{#3}%
  \ifx\@tempa\@tempb
    \@namedef{the#1frame}{\relax}%
  \else
    \ifx\@tempb\@empty
      \@namedef{the#1frame}{}%
    \else
      \@ifundefined{semsf@#3}%
        {\@seminarerr{Slide frame `#3' undefined}\@eha}%
        {\if@test
          \@@@@slideframe{#1}[#2]{#3}%
        \else
          \@namedef{the#1frame}{\setbox\@slidebox=\hbox{{%
            \@nameuse{semsfops@#3}#2\@nameuse{semsf@#3}{\box\@slidebox}}}}%
        \fi}%
     \fi
   \fi}
\def\@@@@slideframe#1[#2]#3{%
  \expandafter\let\expandafter\@tempa\csname the#1frame\endcsname
  \edef\next{%
    \noexpand\def\expandafter\noexpand\csname the#1frame\endcsname}%
  \expandafter\next\expandafter{\@tempa
    \setbox\@slidebox=\hbox{{%
      \@nameuse{semsfops@#3}%
      #2%
      \@nameuse{semsf@#3}{\box\@slidebox}}}}}%
\slideframe{plain}
\def\slidestyle#1{\@ifundefined{ss@#1}%
  {\@seminarerr{Slide style `#1' undefined}\@eha}%
  {\@nameuse{ss@#1}}}
\def\ss@empty{\let\add@slidelabel\@gobble}
\def\ss@left{\def\add@slidelabel##1{%
  \setbox\@slidebox=\hbox{%
    \vbox to \ht\@slidebox{\vss
    \hbox to 0pt{\hss##1\hskip 15pt}%
    \vss}\box\@slidebox}}}
\def\ss@bottom{\def\add@slidelabel##1{%
  \setbox\@slidebox=\vbox{\copy\@slidebox\vskip 9pt
    \hbox to\wd\@slidebox{\hss##1\hss}}}}%
\ifarticle
  \ifportrait\slidestyle{bottom}\else\slidestyle{left}\fi
\else
  \slidestyle{empty}
\fi
\def\slidelabel{\bf Slide \theslide}
\def\newpagestyle#1#2#3{%
  \expandafter\newcommand\csname ps@#1\endcsname{%
    \def\@oddhead{#2}\let\@evenhead\@oddhead
    \def\@oddfoot{#3}\let\@evenfoot\@oddfoot}}
\def\renewpagestyle#1#2#3{%
  \expandafter\renewcommand\csname ps@#1\endcsname{%
    \def\@oddhead{#2}\let\@evenhead\@oddhead
    \def\@oddfoot{#3}\let\@evenfoot\@oddfoot}}
\def\@ifgoodps#1{%
  \@ifundefined{ps@#1}{\@seminarerr{Page style `#1' undefined}\@eha}}
\def\slidepagestyle#1{%
  \@ifgoodps{#1}%
    {\ifslide\pagestyle{#1}\else\edef\slide@pagestyle{#1}\fi}}
\def\ps@{}
\slidepagestyle{}
\ifarticle
  \def\ps@align{}
\else
  \def\ps@align{%
    \def\@oddhead{\thepage\hfil+}\let\@evenhead\@oddhead
    \def\@oddfoot{+\hfil+}\let\@evenfoot\@oddfoot}
\fi
\def\slideheadfont{\scriptsize}
\def\slidefootfont{\scriptsize}
\def\magstep#1{\ifcase#1 \@m\or 1200\or 1440\or 1728\or
  2074\or 2488\or 2986\or 3583\or 4300\or 5160\fi\relax}
\def\magstepminus#1{%
  \ifcase#1 \@m\or 833\or 694\or 579\or 482\or 401\fi\relax}
\def\@magstep#1{%
  \ifnum#1<\z@\magstepminus{-#1}\else\magstep#1\fi}
{\catcode`\p=12\catcode`\t=12
  \gdef\@@inv@@mag#1pt#2{\def#2{#1}}}
\def\invert@mag#1{\@tempdima=1000pt
  \divide\@tempdima by #1\relax
  \expandafter\@@inv@@mag\the\@tempdima#1}
\def\@slidesmag#1{%
  \@tempcnta=#1\relax%
  \ifnum\@tempcnta>0
    \edef\inverseslidesmag{\the\@tempcnta}%
    \invert@mag\inverseslidesmag
    \ifarticle\else\mag\@tempcnta\fi
  \else
    \@seminarerr{\string\@slidesmag\space argument must be an
      integer equal to 1000 times the magnification}\@eha
  \fi}
\def\@articlemag#1{%
  \@tempcnta=#1\relax%
  \ifnum\@tempcnta>0
    \edef\inverseartmag{\the\@tempcnta}%
    \invert@mag\inverseartmag
    \ifarticle\mag\@tempcnta\fi
  \else
    \@seminarerr{\string\articlemag\space argument must be an
      integer equal to 1000 times the magnification}\@eha
  \fi}
\addto@preamblecmds{\@slidesmag\do\@articlemag}
\newdimen\semin
\newdimen\semcm
\def\@semmagerr#1{%
  \@seminarerr{\string#1 argument must be an integer
    between -5 and 9}\@eha}
\def\slidesmag#1{%
  \@tempcnta=#1\relax
  \ifnum\@tempcnta>-6
    \ifnum\@tempcnta<10
      \edef\the@slidesmag{\the\@tempcnta}%
      \@slidesmag{\@magstep\@tempcnta}%
    \else
      \@semmagerr\slidesmag
    \fi
  \else
    \@semmagerr\slidesmag
  \fi
  \setslidelength\semin\seminlength
  \setslidelength\semcm\semcmlength}
\def\seminlength{1in}
\def\semcmlength{1cm}
\def\articlemag#1{%
  \@tempcnta=#1\relax
  \ifnum\@tempcnta>-6
    \ifnum\@tempcnta<10
      \edef\the@articlemag{\the\@tempcnta}%
      \@articlemag{\@magstep\@tempcnta}%
    \else
      \@semmagerr\articlemag
    \fi
  \else
    \@semmagerr\articlemag
  \fi}
\addto@preamblecmds{\slidesmag\do\articlemag}
\def\setslidelength#1#2{%
  #1=#2\relax
  #1=\inverseslidesmag#1}%
\def\addtoslidelength#1#2{%
  \dimen@=#2\relax
  \advance#1 by \inverseslidesmag\dimen@}
\def\setartlength#1#2{%
  #1=#2\relax
  #1=\inverseartmag#1}
\def\addtoartlength#1#2{%
  \dimen@=#2\relax
  \advance#1 by \inverseartmag\dimen@}
\def\slide@epsfsize#1#2{%
  \ifdim\epsfxsize=0pt
    \ifdim\epsfysize=0pt
      \inverseslidesmag#1%
    \else
      0pt
    \fi
  \else
    \inverseslidesmag\epsfxsize
  \fi
  \epsfysize
  \ifdim\epsfysize=0pt
    \ifdim\epsfxsize=0pt
      \inverseslidesmag#2%
    \else
      0pt
    \fi
  \else
    \inverseslidesmag\epsfysize
  \fi}
\def\epsfslidesize{\let\epsfsize\slide@epsfsize}
\slidesmag{4}
\articlemag{0}
\def\do@pageparameters{%
  \do\oddsidemargin
  \do\evensidemargin
  \do\marginparwidth
  \do\marginparsep
  \do\topmargin
  \do\headheight
  \do\headsep
  \do\textheight
  \do\textwidth
  \do\topskip
  \do\footskip
  \do\footheight}
\ifarticle
  \def\scale@pageparameters{%
    \begingroup
      \def\do##1{\global##1=\inverseartmag##1\relax}%
      \do@pageparameters
    \endgroup}
\else
  \def\scale@pageparameters{%
    \begingroup
      \def\do##1{\global##1=\inverseslidesmag##1\relax}%
      \do@pageparameters
    \endgroup}
\fi
\addto@hook\before@document{\scale@pageparameters}
\addto@preamblecmds{\scale@pageparameters\do\do@pageparameters}
\def\allversions{}
\let\endallversions\relax
\@namedef{allversions*}{\@bsphack\globaldefs=1}
\@namedef{endallversions*}{\@esphack}
\def\slide@list{slide,slide*,allversions,allversions*}
\def\addtoslidelist#1{\xdef\slide@list{\slide@list,#1}}
\addto@preamblecmds{\addtoslidelist}
\ifslidesonly
  \@ifundefined{xcomment@@@}{\@@input xcomment.sty }{}
  \def\xcomment@hook{\@xcomment{@@@}{\slide@list}}
  \newxcomment[]{note}
\else
  \def\note{\@bsphack}%
  \def\endnote{\@esphack}%
\fi
\def\noxcomment{\def\xcomment@hook{}}
\def\os@list{}
\newif\if@os
\def\onlyslides#1{\def\os@list{#1}\@ostrue
  \def\os@warning{\@warning{\string\onlyslides\space argument
    contains undefined references}}}
\def\notslides#1{\def\os@list{#1}\@osfalse
  \def\os@warning{\@warning{\string\notslides\space argument
    contains undefined references}}}
\addto@preamblecmds{\onlyslides\do\notslides}
\addto@hook\after@document{%
  \ifx\os@list\@empty\else\os@expandlist\fi}
\def\os@expandlist{%
  \let\os@@warning\relax
  \begingroup
    \def\ref##1{\@ifundefined{r@##1}{?}%
      {\noexpand\@car\@nameuse{r@##1}\noexpand\@nil}}%
    \edef\@tempd{\os@list}%
    \xdef\os@list{}%
    \@for\@tempc:=\@tempd
      \do{\expandafter\os@expandrange\@tempc-:-:\@nil}%
    \os@@warning
  \endgroup
  \let\os@expandrange\relax
  \let\os@checknum\relax
  \let\os@expandlist\relax}
\def\os@expandrange#1-#2-#3\@nil{%
  \def\@tempa{?}\def\@tempb{#1}%
  \ifx\@tempa\@tempb
    \let\os@@warning\os@warning
  \else
    \@tempcnta=#1\relax
    \def\@tempb{#2}%
    \ifx\@tempa\@tempb
      \let\os@@warning\os@warning
    \else
      \def\@tempa{:}%
      \ifx\@tempa\@tempb
        \@tempcntb=\@tempcnta
      \else
        \@tempcntb=#2\relax
      \fi
      \advance\@tempcnta by -1
      \advance\@tempcntb by 1
      \ifx\os@list\@empty
        \xdef\os@list{\the\@tempcnta+\the\@tempcntb}%
      \else
        \xdef\os@list{\os@list,\the\@tempcnta+\the\@tempcntb}%
      \fi
    \fi
  \fi}
\def\os@test{%
  \@testtrue
  \iflandscape
    \ifnum\@landscapeonly=-1 \@testfalse\fi
  \else
    \ifnum\@landscapeonly=1 \@testfalse\fi
  \fi
  \if@test
    \ifx\os@list\@empty\else
      \if@os\@testfalse\fi
      \@for\@tempa:=\os@list\do{\expandafter\os@testrange\@tempa\@nil}%
    \fi
  \fi}
\def\os@testrange#1+#2\@nil{%
  \ifnum\c@slide>#1
    \ifnum\c@slide<#2
      \if@os\@testtrue\else\@testfalse\fi
    \fi
  \fi}
\def\onlynotestoo{%
  \ifnotes\@testtrue\else\ifnotesonly\@testtrue\else\@testfalse\fi\fi
  \if@test
    \@ifundefined{xcomment@@@}{%
      \edef\sem@temp{\the\catcode`\@}%
      \catcode`\@=11
      \@@input xcomment.sty
      \catcode`\@=\sem@temp\relax}{}%
    \def\xcomment@hook{\@xcomment{@@@}{\slide@list}}%
    \addto@hook\after@slide\onlynotes@too
  \fi}
\def\onlynotes@too{%
  \os@test
  \if@test\gdef\do@end{}\else\gdef\do@end{\xc@begin}\fi}
\addto@preamblecmds\onlynotestoo
\def\ptsize#1{%
  \@ifundefined{#1@semptsize}%
    {\@seminarerr{\string\ptsize\space `#1' not valid.}\@eha}%
    {\ifslide
      \sem@ptsize{#1}\large\normalsize
    \else
      \edef\slide@ptsize{#1}%
    \fi}}
\edef\slide@ptsize{1\@ptsize}%
\def\slidefontsizes{\ptsize} %For backwards compatibility??
\def\slide@setsize#1#2#3#4{%
  \@setsize{#1}{#2}{#3}{#4}%
  \set@slideskip{#2}}
\def\slide@@setsize#1#2#3#4{%
  \slide@setsize{#1}{#2}{#3}{#4}\slidedisplayskips}
\def\set@slideskip#1{%
  \normallineskiplimit=#1
  \advance\normallineskiplimit-\normalbaselineskip
  \multiply\normallineskiplimit-1
  \normallineskiplimit\slideskip\normallineskiplimit
  \ifdim\normallineskiplimit<1pt\normallineskiplimit=1pt\fi
  \normallineskip=\normallineskiplimit
    minus \slideshrink\normallineskiplimit
  \dimen@=\normalbaselineskip
  \normalbaselineskip=\dimen@ minus \slideshrink\normallineskiplimit
  \normalbaselines}
\def\slideskip{.75}
\def\slideshrink{.25}
\def\slidedisplayskips{%
  \abovedisplayskip 1.75ex minus .35ex
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip .2ex minus .2ex
  \belowdisplayshortskip 1ex minus .2ex}
\def\sem@ptsize#1{%
  \@nameuse{#1@semptsize}%
  \large\normalsize
  \leftmargini\slideleftmargini\relax
  \leftmarginii\slideleftmarginii\relax
  \leftmarginiii\slideleftmarginiii\relax
  \labelsep\slidelabelsep\relax
  \parskip\slideparskip\relax
  \parindent\slideparindent\relax
  \slide@rightskip
  \slide@listi
  \skip\footins\slidefootins\relax
  \footnotesep\slidefootnotesep\relax}
\def\slidefootins{2ex minus .8ex}
\def\slidefootnotesep{1.2ex}
\def\slideparindent{\z@}
\def\slideparskip{1ex minus .2ex}
\@namedef{8@semptsize}{%
  \def\normalsize{\slide@@setsize\normalsize{9.5pt}\viiipt\@viiipt}%
  \def\small{\slide@@setsize\small{8pt}\viipt\@viipt}%
  \def\footnotesize{\slide@@setsize\footnotesize{8pt}\vipt\@vipt}%
  \def\scriptsize{\slide@setsize\scriptsize{7pt}\vipt\@vipt}%
  \def\tiny{\slide@setsize\tiny{6pt}\vpt\@vpt}%
  \def\large{\slide@setsize\large{12pt}\xpt\@xpt}%
  \def\Large{\slide@setsize\Large{14pt}\xiipt\@xiipt}%
  \def\LARGE{\slide@setsize\LARGE{17pt}\xivpt\@xivpt}%
  \def\huge{\slide@setsize\huge{20pt}\xviipt\@xviipt}%
  \def\Huge{\slide@setsize\Huge{25pt}\xxpt\@xxpt}}
\@namedef{9@semptsize}{%
  \def\normalsize{\slide@@setsize\normalsize{11pt}\ixpt\@ixpt}%
  \def\small{\slide@@setsize\small{9.5pt}\viiipt\@viiipt}%
  \def\footnotesize{\slide@@setsize\footnotesize{8pt}\viipt\@viipt}%
  \def\scriptsize{\slide@setsize\scriptsize{7pt}\vipt\@vipt}%
  \def\tiny{\slide@setsize\tiny{6pt}\vpt\@vpt}%
  \def\large{\slide@setsize\large{12pt}\xpt\@xpt}%
  \def\Large{\slide@setsize\Large{14pt}\xiipt\@xiipt}%
  \def\LARGE{\slide@setsize\LARGE{17pt}\xivpt\@xivpt}%
  \def\huge{\slide@setsize\huge{20pt}\xviipt\@xviipt}%
  \def\Huge{\slide@setsize\Huge{25pt}\xxpt\@xxpt}}
\@namedef{10@semptsize}{%
  \def\normalsize{\slide@@setsize\normalsize{12pt}\xpt\@xpt}%
  \def\small{\slide@@setsize\small{11pt}\ixpt\@ixpt}%
  \def\footnotesize{\slide@@setsize\footnotesize{9.5pt}\viiipt\@viiipt}%
  \def\scriptsize{\slide@setsize\scriptsize{8pt}\viipt\@viipt}%
  \def\tiny{\slide@setsize\tiny{6pt}\vpt\@vpt}%
  \def\large{\slide@setsize\large{14pt}\xiipt\@xiipt}%
  \def\Large{\slide@setsize\Large{18pt}\xivpt\@xivpt}%
  \def\LARGE{\slide@setsize\LARGE{22pt}\xviipt\@xviipt}%
  \def\huge{\slide@setsize\huge{25pt}\xxpt\@xxpt}%
  \def\Huge{\slide@setsize\Huge{30pt}\xxvpt\@xxvpt}}
\@namedef{11@semptsize}{%
  \def\normalsize{\slide@@setsize\normalsize{13.6pt}\xipt\@xipt}%
  \def\small{\slide@@setsize\small{12pt}\xpt\@xpt}%
  \def\footnotesize{\slide@@setsize\footnotesize{11pt}\ixpt\@ixpt}%
  \def\scriptsize{\slide@setsize\scriptsize{9.5pt}\viiipt\@viiipt}%
  \def\tiny{\slide@setsize\tiny{7pt}\vipt\@vipt}%
  \def\large{\slide@setsize\large{14pt}\xiipt\@xiipt}%
  \def\Large{\slide@setsize\Large{18pt}\xivpt\@xivpt}%
  \def\LARGE{\slide@setsize\LARGE{22pt}\xviipt\@xviipt}%
  \def\huge{\slide@setsize\huge{25pt}\xxpt\@xxpt}%
  \def\Huge{\slide@setsize\Huge{30pt}\xxvpt\@xxvpt}}
\@namedef{12@semptsize}{%
  \def\normalsize{\slide@@setsize\normalsize{14.5pt}\xiipt\@xiipt}%
  \def\small{\slide@@setsize\small{13.6pt}\xipt\@xipt}%
  \def\footnotesize{\slide@@setsize\footnotesize{12pt}\xpt\@xpt}%
  \def\scriptsize{\slide@setsize\scriptsize{9.5pt}\viiipt\@viiipt}%
  \def\tiny{\slide@setsize\tiny{7pt}\vipt\@vipt}%
  \def\large{\slide@setsize\large{18pt}\xivpt\@xivpt}%
  \def\Large{\slide@setsize\Large{22pt}\xviipt\@xviipt}%
  \def\LARGE{\slide@setsize\LARGE{25pt}\xxpt\@xxpt}%
  \def\huge{\slide@setsize\huge{30pt}\xxvpt\@xxvpt}%
  \let\Huge\huge}
\@namedef{14@semptsize}{%
  \def\normalsize{\slide@@setsize\normalsize{18pt}\xivpt\@xivpt}%
  \def\small{\slide@@setsize\small{14.5pt}\xiipt\@xiipt}%
  \def\footnotesize{\slide@@setsize\footnotesize{13.6pt}\xipt\@xipt}%
  \def\scriptsize{\slide@setsize\scriptsize{12pt}\xpt\@xpt}%
  \def\tiny{\slide@setsize\tiny{9.5pt}\viiipt\@viiipt}%
  \def\large{\slide@setsize\large{22pt}\xviipt\@xviipt}%
  \def\Large{\slide@setsize\Large{25pt}\xxpt\@xxpt}%
  \def\LARGE{\slide@setsize\LARGE{30pt}\xxvpt\@xxvpt}%
  \let\huge\LARGE
  \let\Huge\LARGE}
\@namedef{17@semptsize}{%
  \def\normalsize{\slide@@setsize\normalsize{22pt}\xviipt\@xviipt}%
  \def\small{\slide@@setsize\small{18pt}\xivpt\@xivpt}%
  \def\footnotesize{\slide@@setsize\footnotesize{14.5pt}\xiipt\@xiipt}%
  \def\scriptsize{\slide@setsize\scriptsize{13.6pt}\xipt\@xipt}%
  \def\tiny{\slide@setsize\tiny{12pt}\xpt\@xpt}%
  \def\large{\slide@setsize\large{25pt}\xxpt\@xxpt}%
  \def\Large{\slide@setsize\Large{30pt}\xxvpt\@xxvpt}%
  \let\LARGE\Large
  \let\huge\Large
  \let\Huge\Large}
\def\twoup{\@ifnextchar[{\@twoup}{\@twoup[0]}}
\ifarticle
  \ifportrait
    \def\@twoup[#1]{%
      \@tempcnta=\the@articlemag\relax
      \@tempcntb=\@tempcnta
      \advance\@tempcntb by #1\relax
      \advance\@tempcntb by -2\relax
      \ifnum\@tempcntb>-6\relax
        \@@input 2up.tex
        \source{\@magstep\@tempcnta}{\paperheight}{\paperwidth}%
        \target{\@magstep\@tempcntb}{\paperwidth}{\paperheight}%
        \targetlayout{topbottom}%
        \printlandscapefalse
      \else
        \@seminarerr{Article magnification is too low for
          \string\twoup\space to handle}\@eha
      \fi
      \def\articlemag##1{\@semtwoupmagerr\articlemag}}
  \else
    \def\@twoup[#1]{%
      \@tempcnta=\the@articlemag\relax
      \@tempcntb=\@tempcnta
      \advance\@tempcntb by #1\relax
      \advance\@tempcntb by -2\relax
      \ifnum\@tempcntb>-6\relax
        \@@input 2up.tex
        \source{\@magstep\@tempcnta}{\paperwidth}{\paperheight}%
        \target{\@magstep\@tempcntb}{\paperheight}{\paperwidth}%
        \if@twoside
          \targetlayout{twosided}%
        \fi
        \printlandscapetrue
      \else
        \@seminarerr{Article magnification is too low for
          \string\twoup\space to handle}\@eha
      \fi
      \def\articlemag##1{\@semtwoupmagerr\articlemag}}
  \fi
\else
  \ifportrait
    \def\@twoup[#1]{%
      \@tempcnta=\the@slidesmag\relax
      \@tempcntb=\@tempcnta
      \advance\@tempcntb by #1\relax
      \advance\@tempcntb by -3\relax
      \ifnum\@tempcntb>-6\relax
        \@@input 2up.tex
        \source{\@magstep\@tempcnta}{\paperwidth}{\paperheight}%
        \advance\@tempcnta by -3
        \target{\@magstep\@tempcnta}{\paperheight}{\paperwidth}%
        \printlandscapetrue
      \else
        \@seminarerr{Slides magnification is too low for
          \string\twoup\space to handle}\@eha
      \fi
      \def\slidesmag##1{\@semtwoupmagerr\slidesmag}}
  \else
    \def\@twoup[#1]{%
      \@tempcnta=\the@slidesmag\relax
      \@tempcntb=\@tempcnta
      \advance\@tempcntb by #1\relax
      \advance\@tempcntb by -3\relax
      \ifnum\@tempcntb>-6\relax
        \@@input 2up.tex
        \source{\@magstep\@tempcnta}{\paperheight}{\paperwidth}%
        \target{\@magstep\@tempcntb}{\paperwidth}{\paperheight}%
        \targetlayout{topbottom}%
        \printlandscapefalse
      \else
        \@seminarerr{Slides magnification is too low for
          \string\twoup\space to handle}\@eha
      \fi
      \def\slidesmag##1{\@semtwoupmargerr\slidesmag}}%
  \fi
\fi
\def\@semtwoupmagerr#1{%
  \@seminarerr{\string#1 must come before \string\twoup}\@eha}
\addto@preamblecmds{\twoup\do\@twoup}
%
\InputIfFileExists{seminar.con}{}
%\ifeof1\else\closein1 \relax\@@input seminar.con\fi
%
\endinput
%%
%% END `seminar.cls'.

