%% Herbert Voss <hvoss@tug.org>
%% Copyright (C) 2024
%%
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
%%  Option FULLPAGE,  complete paperarea on _one_ page even/odd 
%%
%% width=\textwidth+\leftmargin+\rightmargin   height=variable   --> FULLPAGE
%% _With_ no additional text on the doublepage
%%
%% ------------------------------------- the fullpage obejcts ---------------------------
%% ||1in+evenside --- |1in+oddside ---||
%
%\def\do@@@@hvFloat{%  special float page: caption <-> FULLPAGE images
  \hvfloat@typeout{>>>do@@@@hvFloat: special float page}%
  \ifx\hvSet@capPos\hv@After \global\hv@@capPos=1
  \else
    \ifx\hvSet@capPos\hv@Even  \global\hv@@capPos=2
    \else
      \ifx\hvSet@capPos\hv@Odd   \global\hv@@capPos=3
      \else
        \ifx\hvSet@capPos\hv@Inner   \global\hv@@capPos=4
        \else
          \ifx\hvSet@capPos\hv@Outer   \global\hv@@capPos=5
          \else
            \ifx\hvSet@capPos\hv@Right   \global\hv@@capPos=6% only for twocolumn mode
            \else
              \ifx\hvSet@capPos\hv@Left   \global\hv@@capPos=7% only for twocolumn mode
              \else
                \global\hv@@capPos=0
              \fi
            \fi
          \fi
        \fi
      \fi
    \fi
  \fi
  \hvfloat@typeout{>>>do@@@@hvFloat: hv@capPos is \the\hv@@capPos}%
%  \checkoddpage
  \hvfloat@typeout{>>>do@@@@hvFloat: set floattype}%
  \set@caption@object{\hv@floatType}%  set caption and object into a box
%  
  \ifcase\hv@@capPos%   caption before object 0-> _always_ left
    \hvfloat@typeout{>>>do@@@@hvFloat: setBottomCaption and setPageObject (0)}%
    \setBottomCaption\setPageObject        
  \or%                  caption after object 1-> _always_ right
    \hvfloat@typeout{>>>do@@@@hvFloat: setPageObject and setBottomCaption (1)}%
    \setPageObject\setBottomCaption        
  \or%                  caption on even page 2-> left page
    \ifoddpage
      \hvfloat@typeout{>>>do@@@@hvFloat: afterpage-> oddpage/setBottomCaption and setPageObject (2)}%
      \afterpage{\setBottomCaption\setPageObject}%
    \else% we are on an even page
      \hvfloat@typeout{>>>do@@@@hvFloat: evenpage/setBottomCaption and setPageObject (2)}%
      \setBottomCaption\setPageObject
    \fi
  \or%                caption on odd page  3->right page
    \if@twoside
      \hvfloat@typeout{>>>do@@@@hvFloat: twoside and caption on oddpage (3)}%
      \if@twocolumn
        \hvfloat@typeout{>>>do@@@@hvFloat: twoside/twocolumn and caption on oddpage (3)}%
        \ifoddpage
          \hvfloat@typeout{>>>do@@@@hvFloat: twoside/twocolumn/oddpage and caption on oddpage (3)}%
          \if@firstcolumn%  on right side
            \hvfloat@typeout{>>>do@@@@hvFloat: twoside/twocolumn/oddpage/firstcolumn and caption on oddpage (3)}%
            \setBottomCaption\setPageObject        
          \else
            \hvfloat@typeout{>>>do@@@@hvFloat: afterpage->twoside/twocolumn/oddpage/secondcolumn and caption on oddpage (3)}%
            \afterpage{\setPageObject\setBottomCaption}% start next column
          \fi
        \else% left (even) page
          \hvfloat@typeout{>>>do@@@@hvFloat: twoside/twocolumn/oddpage and caption on evenpage (3)}%
          \if@firstcolumn
            \hvfloat@typeout{>>>do@@@@hvFloat: afterpage->twoside/twocolumn/evenpage/firstcolumn and caption on oddpage (3)}%
            \afterpage{\setPageObject\setBottomCaption}% start next column
          \else
            \hvfloat@typeout{>>>do@@@@hvFloat: twoside/twocolumn/evenage/secondcolumn and caption on oddpage (3)}%
            \setPageObject\setBottomCaption
          \fi
        \fi
      \else% onecolumn
        \hvfloat@typeout{>>>do@@@@hvFloat: twoside/onecolumn and caption on oddpage (3)}%
        \ifoddpage
          \hvfloat@typeout{>>>do@@@@hvFloat: twoside/onecolumn/oddpage and caption on oddpage (3)}%
          \setPageObject\setBottomCaption
        \else%  even page
          \hvfloat@typeout{>>>do@@@@hvFloat: afterpage->twoside/onecolumn/evenpage and caption on oddpage (3)}%
          \afterpage{\setPageObject\setBottomCaption}%
        \fi
      \fi
    \else% oneside
      \hvfloat@typeout{>>>do@@@@hvFloat: oneside and caption on oddpage (3)}%
      \if@twocolumn
        \hvfloat@typeout{>>>do@@@@hvFloat: oneside/twocolumn and caption on oddpage (3)}%
        \ifoddpage
          \hvfloat@typeout{>>>do@@@@hvFloat: oneside/twocolumn/oddpage and caption on oddpage (3)}%
          \if@firstcolumn%  on right side
            \hvfloat@typeout{>>>do@@@@hvFloat: oneside/twocolumn/oddpage/firstcolumn and caption on oddpage (3)}%
            \setBottomCaption\setPageObject
          \else
            \hvfloat@typeout{>>>do@@@@hvFloat: oneside/twocolumn/oddpage/secondcolumn and caption on oddpage (3)}%
            \setPageObject\setBottomCaption
          \fi
        \else
          \hvfloat@typeout{>>>do@@@@hvFloat: oneside/twocolumn/evenpage and caption on oddpage (3)}%
          \if@firstcolumn%  on left side
            \hvfloat@typeout{>>>do@@@@hvFloat: afterpage->oneside/twocolumn/evenpage/firstcolumn and caption on oddpage (3)}%
            \afterpage{\setPageObject\setBottomCaption}%
          \else
            \hvfloat@typeout{>>>do@@@@hvFloat: oneside/twocolumn/evenpage/secondcolumn and caption on oddpage (3)}%
            \setPageObject\setBottomCaption
          \fi
        \fi
      \else % onecolumn
        \hvfloat@typeout{>>>do@@@@hvFloat: oneside/onecolumn and caption on oddpage (3)}%
        \ifoddpage
          \hvfloat@typeout{>>>do@@@@hvFloat: oneside/onecolumn/oddpage and caption on oddpage (3)}%
          \setBottomCaption\setPageObject%
        \else
          \hvfloat@typeout{>>>do@@@@hvFloat: afterpage->oneside/onecolumn/evenpage and caption on oddpage (3)}%
          \afterpage{\setBottomCaption\setPageObject}%
        \fi
      \fi
    \fi
  \or%                caption on the inner column 4->inner
%    \set@caption@object
    \if@twocolumn
      \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn and caption on inner column (4)}%
      \ifoddpage
        \hvfloat@typeout{>>>do@@@@hvFloat: twoside/oddpage and caption on inner column (4)}%
        \if@firstcolumn%  on right side
          \hvfloat@typeout{>>>do@@@@hvFloat: twoside/oddpage/firstcolumn and caption on inner column (4)}%
	  \setBottomCaption\setPageObject
        \else          % right column on right side
          \hvfloat@typeout{>>>do@@@@hvFloat: twoside/oddpage/secondcolumn and caption on inner column (4)}%
          \setPageObject\setBottomCaption%  start next firstcolumn next page
        \fi
      \else
        \hvfloat@typeout{>>>do@@@@hvFloat: twoside/evenpage and caption on inner column (4)}%
        \if@firstcolumn%  on left side
          \hvfloat@typeout{>>>do@@@@hvFloat: afterpage^2 -> twoside/evenpage/firstcolumn and caption on inner column (4)}%
          \afterpage{\afterpage{\setBottomCaption\setPageObject}}% start next page/first column
        \else% left page/column
          \hvfloat@typeout{>>>do@@@@hvFloat: twoside/evenpage/secondcolumn and caption on inner column (4)}%
          \setBottomCaption\setPageObject% start on same page/column 
        \fi
      \fi 
    \else% onecolumn
      \hvfloat@typeout{>>>do@@@@hvFloat: onecolumn and caption on inner column (4)}%
      \setBottomCaption\setPageObject
    \fi       
  \or%                caption on the outer column  5->outer
%    \set@caption@object
    \if@twocolumn
      \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn and caption on outer column (5)}%
      \ifoddpage
        \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn/oddpage and caption on outer column (5)}%
        \if@firstcolumn
          \hvfloat@typeout{>>>do@@@@hvFloat: afterpage^2 -> firstcolumn/oddpage/twocolumn and caption on outer column (5)}%
          \afterpage{\afterpage{\setBottomCaption\setPageObject}}%
        \else
          \hvfloat@typeout{>>>do@@@@hvFloat: afterpage -> twocolumn/oddpage/secondcolumn and caption on outer column (5)}%
          \afterpage{\setBottomCaption\setPageObject}%
        \fi
      \else% even page (left)
        \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn/evenpage and caption on outer column (5)}%
        \if@firstcolumn
          \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn/evenpage/firstcolumn and caption on outer column (5)}%
          \setBottomCaption\setPageObject
        \else   
          \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn/evenpage/secondolumn and caption on outer column (5)}%
%%%               !!!!  to-do: !!!!          
        \fi
      \fi 
    \else% onecolumn
      \setBottomCaption\setPageObject
    \fi 
  \or%                caption after object on same page 6->right for twocolumn
    \if@twocolumn
      \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn and caption after object (6)}%
      \if@firstcolumn
        \hvfloat@typeout{>>>do@@@@hvFloat: afterpage -> twocolumn/firstcolumn and caption after object (6)}%
        \afterpage{\setPageObject\setBottomCaption}%
      \else
        \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn/secondcolumn and caption after object (6)}%
        \setPageObject\setBottomCaption
      \fi
    \else%  always caption _after_ object for onecolumn 
      \hvfloat@typeout{>>>do@@@@hvFloat: onecolumn and caption after object (6)}%
      \setPageObject\setBottomCaption
    \fi  
  \or%                caption before object on same page 7->left for twocolumn
    \if@twocolumn
      \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn and caption before object (7)}%
      \if@firstcolumn
        \hvfloat@typeout{>>>do@@@@hvFloat: twocolumn/firstcolumn and caption before object (7)}%
        \setBottomCaption\setPageObject
      \else
        \hvfloat@typeout{>>>do@@@@hvFloat: afterpage -> twocolumn/secondcolumn and caption before object (7)}%
        \afterpage{\setBottomCaption\setPageObject}%
      \fi    
    \else%        onecolumn -> same as before
      \hvfloat@typeout{>>>do@@@@hvFloat: onecolumn and caption before object (7)}%
      \setBottomCaption\setPageObject
    \fi
  \fi
  \endgroup% startet at main \hvFloat
%}
%
