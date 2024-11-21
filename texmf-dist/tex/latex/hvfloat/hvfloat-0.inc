%% Herbert Voss <hvoss@tug.org>
%% Copyright (C) 2024
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%%  width=2\paperwidth, height=variable
%%
%% ||1in+evenside --- |1in+oddside ---||       Image is 2\paperwidth wide, height is variable or user set
%
\def\do@hvFloat@doubleFullPage#1{%  image on left and right page with caption before/below/right/after
  % #1-> not used, caption always below lefr or below right
  \setcounter{topnumber}{1}%
  \setcounter{dbltopnumber}{1}%
  \expandafter\hvFloatSet\expandafter{\hv@save@setting}%    
%  \ifx\hvSet@capPos\hv@Right\else\ifx\hvSet@capPos\hv@Left\else
%    \let\hvSet@capPos\hv@Right
%  \fi\fi
  \ifx\hv@caption@format\@empty\else\expandafter\captionsetup\expandafter{\hv@caption@format}\fi
      \ifx\hv@subcaption@format\@empty\else
        \expandafter
           \captionsetup\expandafter[\expandafter s\expandafter u\expandafter b\expandafter]\expandafter
                             {\hv@subcaption@format}%
  \fi
  \let\c@hv@tempCNTfigA\c@figure
  \let\c@hv@tempCNTtabA\c@table
  \checkoddpage
  \ifoddpage
    \test@typeout{>>>>Befehl auf ungerader Seite, kein Test auf Anfang für Doppelseite!}%
    \if@twocolumn
      \if@firstcolumn
        \afterpage{afterpage{\do@hvFloat@doubleFullPage@ObjectAndCaption}}%  2nd Col and newpage
      \else
        \do@hvFloat@doubleFullPage@ObjectAndCaption% odd, 2nd col -> no newpage
      \fi
    \else % onecol
      \afterpage{\do@hvFloat@doubleFullPage@ObjectAndCaption}% oddpage->newpage
    \fi % end \if@twocolumn
  \else% evenpage 
    %---------
    \global\savebox{\hvObjectBox}{\ifhv@useOBox\usebox{\hvOBox}\else\hv@floatObject\fi}%
    %\typeout{Boxmaße: \the\wd\hvObjectBox;\the\ht\hvObjectBox}%
    %\typeout{>>>>Setze hv@atPageBeginfalse}%
    \global\hv@atPageBeginfalse
    \hv@float@head=\the\dimexpr+1in+\topmargin+\headheight+\headsep
    \hv@float@foot=\the\dimexpr\paperheight-\hv@float@head-\textheight
    %\typeout{Kopf: \the\hv@float@head}%
    %\typeout{Fuß: \the\hv@float@foot}%
    \stepcounter{hvfloat@ref}%
    \zsavepos{\thehvfloat@ref}%
    \@tempy=\dimexpr\paperheight-\zposy{\thehvfloat@ref} sp-1in-\topmargin-\headheight-\headsep\relax
    \@tempx=\dimexpr-\zposx{\thehvfloat@ref} sp+\evensidemargin+1in\relax
    \ifdim\@tempy > \dimexpr\f@size pt + 2pt % Test, ob Abbildung oben
      \expandafter\ifdefined\csname HV@float@ref@\thehvfloat@ref\endcsname % already on top from last run?
          \global\hv@atPageBegintrue 
          \immediate\write\@auxout{\expandafter\gdef\csname HV@float@ref@\thehvfloat@ref\endcsname{1}}%
      \fi
    \else
      \ifdim\@tempx = \z@%
        \global\hv@atPageBegintrue
        \immediate\write\@auxout{\expandafter\gdef\csname HV@float@ref@\thehvfloat@ref\endcsname{1}}%
      \fi
    \fi
  %---------
    \ifhv@atPageBegin% At the top left of the even page -> output image
       \do@hvFloat@doubleFullPage@ObjectAndCaption
    \else
      \if@twocolumn
        \if@firstcolumn
          \afterpage{\afterpage{\afterpage{\do@hvFloat@doubleFullPage@ObjectAndCaption}}}%  ->2nd Col left page and newpage
        \else
          \afterpage{\afterpage{\do@hvFloat@doubleFullPage@ObjectAndCaption}}% ->newpage ( 2columns)
        \fi
      \else % onecol
        \afterpage{\afterpage{\do@hvFloat@doubleFullPage@ObjectAndCaption}}% evenpage->newpage->newpage
      \fi % end \if@twocolumn
    \fi % end of \ifhv@atPageBegin
  \fi% main ifoddpage
  \endgroup% started at main macro \hvFloat
}

\def\do@hvFloat@doubleFullPage@ObjectAndCaption{%
  \begin{\hv@floatType*}[t]
    \hv@set@noverticalSpace
    \hfuzz=\maxdimen
    \let\c@hv@tempCNTfigA\c@figure
    \let\c@hv@tempCNTtabA\c@table
    \expandafter\hvFloatSet\expandafter{\hv@save@setting}% 
    \hv@leftPageObjectWidth=\dimexpr\paperwidth-\hvSet@bindCorrection%
    \global\savebox{\hvObjectBox}{\ifhv@useOBox\usebox{\hvOBox}\else\hv@floatObject\fi}%
    \vspace*{\the\dimexpr-1in-\voffset-\topmargin-\headheight-\headsep}%-\baselineskip-\parskip+1.5\lineskip}%  no interlineskip
    \hspace*{\the\dimexpr-\evensidemargin-\parindent-1in}%
    \clipbox*{0 -\depth{} \hv@leftPageObjectWidth{} \height}{\usebox\hvObjectBox}%
    \ifx\hv@label\@empty
    \else
      \ifx\hv@floatType\hv@figure
        \global\refstepcounter{hv@tempCNTfigA}%
      \else
        \global\refstepcounter{hv@tempCNTtabA}%   before caption
      \fi
      \label{\hv@label}%
    \fi        
    \ifx\hvSet@capPos\hv@Left %  left side a caption
      \ifhv@onlyText
        \hv@longCap
      \else
        \ifx\hv@shortCap\@empty
          \captionof{\hv@floatType}{\hv@longCap}%
        \else
          \captionof{\hv@floatType}[\hv@shortCap]{\hv@longCap}%
        \fi
      \fi
      \ifx\hv@label\@empty\else\label{\hv@label-cap}\fi            
    \else
      \ifhv@global@sameHeight
        \par\noindent\phantom{\parbox{\textwidth}{\caption*{\hv@longCap}}}%
%      \vspace{-2pt}%
      \fi
    \fi
    \hv@reset@noverticalSpace
  \end{\hv@floatType*}%
  %  start right half of the image ----------------- RIGHT
  \begin{\hv@floatType*}[t]
    \hv@set@noverticalSpace
    \hfuzz=\maxdimen
    \let\c@hv@tempCNTfigA\c@figure
    \let\c@hv@tempCNTtabA\c@table
    \expandafter\hvFloatSet\expandafter{\hv@save@setting}% 
    \hv@leftPageObjectWidth=\dimexpr\paperwidth-\hvSet@bindCorrection
    \global\savebox{\hvObjectBox}{\ifhv@useOBox\usebox{\hvOBox}\else\hv@floatObject\fi}%
    \vspace*{\the\dimexpr-1in-\voffset-\topmargin-\headheight-\headsep}%-\baselineskip-\parskip+1.5\lineskip}%  no interlineskip
    \hspace*{\the\dimexpr-1in-\oddsidemargin+\hvSet@bindCorrection}%
    \clipbox*{\the\hv@leftPageObjectWidth{} -\depth{} \width{} \height{}}{\usebox\hvObjectBox}%
    \ifx\hv@label\@empty
    \else
      \ifx\hv@floatType\hv@figure
        \global\refstepcounter{hv@tempCNTfigA}%
      \else
        \global\refstepcounter{hv@tempCNTtabA}%   before caption
      \fi
      \label{\hv@label}%
    \fi        
    \ifx\hvSet@capPos\hv@Left %  left side a caption
      \ifhv@global@sameHeight
        \par\noindent\phantom{\parbox{\textwidth}{\caption*{\hv@longCap}}}%
%      \vspace{-2pt}%
      \fi
    \else
      \ifhv@onlyText
        \hv@longCap
      \else
        \ifx\hv@shortCap\@empty
          \captionof{\hv@floatType}{\hv@longCap}%
        \else
          \captionof{\hv@floatType}[\hv@shortCap]{\hv@longCap}%
        \fi
      \fi
      \ifx\hv@label\@empty\else\label{\hv@label-cap}\fi            
    \fi
    \hv@reset@noverticalSpace
  \end{\hv@floatType*}%
}
