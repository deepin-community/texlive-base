%%
%% This is file `README.txt',
%%
%%   Copyright (C)  2005--2023 Claudio Beccari  all rights reserved.
%%   License information appended
%% 
File README.txt for package curve2e
        [2023-01-01 v.2.3.1 Extension package for pict2e]
The package bundle curve2e is composed of the following files

curve2e.dtx
curve2e-manual.tex
README.txt

The derived files are

curve2e.sty
curve2e-v161.sty
curve2e.pdf
curve2e-manual.pdf

Compile curve2e.dtx and curve2e-manual.tex two or three times until
all labels and citation keys are completely resolved.

Move curve2e.dtx and curve2e-manual.tex to ROOT/source/latex/curve2e/
Move curve2e.pdf and curve2e-manual.pdf to ROOT/doc/latex/curve2e/
Move curve2e.sty and curve2e-v161.sty   to ROOT/tex/latex/curve2e/
Move README.txt                         to ROOT/doc/latex/curve2e/

curve2e.dtx is the documented TeX source file of the derived files
curve2e.sty, and curve2e-v161.sty.

You get curve2e.sty, curve2e.pdf, and curve2e-v161.sty by running 
pdflatex on curve2e.dtx.

The curve2e-manual file contains the user manual; in this way the long 
preliminary descriptive part has been transferred to a shorter dedicated 
file, where the “normal” user should find enough information to use the 
package. The curve2e.pdf file, extracted from the .dtx one, contains the 
code documentation and is intended for developers, or for curious 
advanced users. For what concerns curve2e-v161.sty, it is a previous 
fall back version of this package; see below why the older version might 
become necessary to the end user.

README.txt, this file, contains general information.

Curve2e.sty is an extension of the package pict2e.sty which initially 
extended the standard picture LaTeX environment according to what Leslie 
Lamport specified in the second edition of his LaTeX manual (1994); in 
time pict2e.sty  evolved to contain further enhancements to what Leslie 
Lamport announced in 1994.

This further extension curve2e.sty to pict2e.sty allows to draw lines
and vectors with any non integer slope parameters, to draw dashed and 
dotted lines of any slope, to draw arcs and curved vectors, to draw 
curves where just the interpolating nodes are specified together with 
the slopes at such nodes; closed paths of any shape can be filled with 
color; all coordinates are treated as ordered pairs, i.e. 'complex 
numbers'; coordinates may be expressed also in polar form. Coordinates 
may be specified with macros, so that editing any drawing is rendered 
much simpler: any point specified with a macro may be modified only 
once in its macro definition.
Some of these features have been incorporated in the 2009 version of
pict2e; therefore this package avoids any modification to the original
pict2e commands. In any case this version of curve2e is compatible with
later versions of pict2e; see below.

As said above, curve2e now accepts polar coordinates in addition to the 
usual cartesian ones; several macros have been upgraded; a new macro for 
tracing cubic Bezier splines with their control nodes specified in polar 
form is available. The same applies to quadratic Bezier splines. The 
\multiput command has been completely modified in a backwards compatible 
way; the new version allows to manipulate the increment components in a 
configurable way. A new \xmultiput command has been defined that is more 
configurable than the original one; both commands \multiput and \xmultiput 
are backwards compatible with the original picture environment definition.

Curve2e solves a conflict with package eso-pic.

This version of curve2e is almost fully compatible with pict2e dated
2014/01/12 version 0.2z and later; as of today the last pct2e revision 
is version 0.4b dated 2020, and curve2e has been tested also with this 
revision confirming that it performs as expected. 
Pay attention, though, that in 2020 also the \LaTeX kernel segment dealing 
with the picture environment has been upgraded; since then, the picture 
environment opening and internal commands can handle explicit dimensions 
and accepts dimensional expressions as those that can be processed by the 
eTeX command \dimexpr. Such functionalities should be avoided when using 
curve2e; at least when dealing with coordinates that curve2e assumes to 
be real possibly floating point numbers, not dimensions.

If you specify:

\usepackage[<pict2e options>]{curve2e}

package pict2e is loaded and curve2e options are automatically passed on to pict2e.

The -almost fully compatible- phrase is necessary to explain that this
version of curve2e uses some `functions' of the LaTeX3 language that were
made available to the LaTeX developers by mid October 2018. Should the 
user have an older or a basic/incomplete installation of the TeX system,
such L3 functions might not be available. This is why this
package checks the presence of the developer interface; in case
such interface is not available it falls back to the previous version
renamed curve2e-v161.sty, which is part of this bundle; this roll-back
file name must not be modified in any way. The compatibility mentioned
above implies that the user macros remain the same, but their
implementation requires the L3 interface. Some macros and environments
rely totally on the xfp package functionalities, but legacy documents
source files should compile correctly.

This package has the LPPL status of maintained.

According to the LPPL licence, you are entitled to modify this package,
as long as you fulfil the few conditions set forth by the Licence.

Nevertheless this package is an extension to the standard LaTeX pict2e 
(2014 and 2020) package. Therefore any change must be controlled on the
parent package pict2e, so as to avoid redefining or interfering with
what is already contained in that package.

If you prefer sending me your modifications, as long as I will maintain
this package, I will possibly include every (documented) suggestion or
modification into this package and, of course, I will acknowledge your
contribution.

Claudio Beccari

claudio dot beccari at gmail dot com

%%
%% End of file `README.txt'.
