# tkz-base — for Cartesian coordinate system 

Release 4.2c 2022/07/14

## Description
The package `tkz-base` provides some tools like a Cartesian (rectangular) coordinate system to other packages like `tkz-euclide` or `tkz-fct`.
With this package, you can draw coordinate axis, grids, draw points, the
principle  is to specify the position of any point in two-dimensional space by an unique couple of coordinates.

## Licence

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
 of this license or (at your option) any later version.
 The latest version of this license is in
   http://www.latex-project.org/lppl.txt
 and version 1.3 or later is part of all distributions of LaTeX
 version 2005/12/01 or later.

## Requirements

- [xfp](https://ctan.org/pkg/xfp)
- [numprint](https://www.ctan.org/pkg/numprint)
 
## Installation

The package `tkz-base` is present in TeXLive and MiKTeX, use the package
manager to install.

You can experiment with the `tkz-base package by placing all of the
distribution files in the directory containing your current tex file.

You can also placing all of the distribution files in the directory : 
/texmf/tex/latex/tkz.
 
## How to use it

- compiles with utf8, pdflatex, lualatex;
- To use the package tkz-base, place the following lines in the preamble of
 your LaTeX document.

\usepackage{tkz-base}  (loads  TikZ and some tikzlibraries).

To avoid package conflicts, you need to load xcolor before TikZ or tkz-base or tkz-euclide

## Documentation

Documentations for `tkz-base`   are available on CTAN and your distribution.
 
 
## Examples

All  examples given in documentation will be stored on my site : [http://altermundus.fr](http://altermundus.fr) as standalone
files, ready for compilation. 

Other examples, in French, are on my site.

## Compatibility

The new version of `tkz-base`  is *not* fully compatible with the version 3 but the differences are minor

## History
- 4.2c adaptation to the new version of tkz-euclide.
- 4.05b Correction of an option (tkzDrawY).
     Removing axesmin.tex  Move from \newif\iftkz@integer to base.sty
- 4.01b  add error message if tkz-base is loaded after tkz-euclide.
   Translation of some lines from French to English in the documentation
- 4.00b now `tkz-euclide` is independent of `tkz-base`. Some geometry specific macros have been removed.
- 3.06c correction of the documentation ( thanks to Laurent Van Deik)
- 3.05c correction of bugs, some macros have migrated to tkz-euclide
- 3.02c correction of bugs, new code
- 3.01c correction of bugs, new code
- 1.16 correction of bugs
- 1.13 first version      

## Author

Alain Matthes, 5 rue de Valence, Paris 75005, al (dot) ma (at) mac (dot) com