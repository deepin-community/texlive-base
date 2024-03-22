# The `ragged2e` package

Copyright (C) Martin Schröder, 1996–2019, Marei Peischl (peiTeX)  <marei@peitex.de>, 2021–2023

 ragged2e 2023/06/22 v3.6

***************************************************************************

 This material is subject to the LaTeX Project Public License version 1.3c
 or later. See http://www.latex-project.org/lppl.txt for details.

***************************************************************************

This work has the LPPL maintenance status `maintained'.

The Current Maintainer of this work is
   Marei Peischl <marei@peitex.de>.

[Link to the GitLab Repository](https://gitlab.com/TeXhackse/ragged2e)

## Abstract
A LaTeX package which defines new commands `\Centering`, `\RaggedLeft`, and `\RaggedRight` and new environments `Center`, `FlushLeft`, and `FlushRight`, which set ragged text and are easily configurable to allow hyphenation.

## Provided files

* README.md
* ragged2e.dtx
* ragged2e.ins

The files
* ragged2e.sty

## Issue Tracker
If you think you may have found a bug in these packages,
or want to report a suggestion for improvement, please visit
  https://gitlab.com/TeXhackse/ragged2e/issues


## Version History
   * 3.0 Move from everysel package to lthooks
   * 3.1 Robustify the user macros (Thanks for Markus Kohm for the hint)
   * 3.2 Fix bug adding a parskip when using `\newline` within the raggged2e alignments (Thanks to Maurice Hansen for reporting)
   * 3.3 Only modify the alignment when one of the ragged2e commands is active
   * 3.4 Bugfix: Remove spurious spaces (Thanks to Enrico Gregorio for reporting)
   * 3.5 Bugfix: Resolving performance issues created in v3.3
   * 3.6 Bugfix: Remove impact of ragged2e commands/environments on the following parindent.