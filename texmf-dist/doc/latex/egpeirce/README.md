# egpeirce #

`egpeirce` is a [LaTeX](https://www.latex-project.org/) package intended for drawing _existential graphs_ with `PostScript`.

## Short introduction

`egpeirce` is meant for drawing _existential graphs_ (α, β, and γ systems are all accounted for) that were invented and developed by the philosopher and polymath Charles S. Peirce (1839--1914). The package also contains novel and unique symbols for multiple types of _linear_ logical operators Peirce invented and used in his larger logical system.

The package enables your document to contain graphs without having to resort to external image files. It also automates many of the more tedious aspects of vectorizing existential graphs by hand. However, it _does not_ check or ensure that proper syntactic rules are obeyed. The graphs are described in relatively simple and straightforward code and when you compile your document, LaTeX does the actual drawing for you.

Please see the full documentation file, `egpeirce-doc.pdf`, for all the commands the package provides. The documentation also contains examples of graphs found in Peirce's manuscripts and their counterparts produced by the package. These examples introduce general strategies on how you can cope with very complex graphs.

## Compilation

The current version of `egpeirce` relies on `PostScript` code and the `PStricks` LaTeX package. Thus, you need to use converters like `DVItoPS` and `PStoPDF` to get PDF output files through LaTeX. XeLaTeX seems to be able to process source code containing `PostScript` commands directly, but it can be a lot slower that the conversion method and seems to produce somewhat larger PDF files.

## Bugs and further development

The full documentation PDF contains a section on possible further development of the package, please refer to it.

The code still contains a few annoying bugs. In particular coloured and/or iterated _scrolls_ preform sub-optimally for now. There are very few examples of such scrolls in Peirce's manuscripts, but it would be nice to get this mechanism to work correctly. The documentation also touches on a few other issues. The source code for the package has more specific comments on these problems as well.

## License

[The LaTeX Project Public License 1.3 or later](https://www.ctan.org/license/lppl1.3)

Copyright (c) 2008-2023, Jukka Nikulainen,

All rights reserved.
