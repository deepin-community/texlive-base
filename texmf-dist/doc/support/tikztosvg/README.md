# tikztosvg(1)

The `tikztosvg(1)` command renders TikZ diagrams to SVG, using
[TeXLive](https://tug.org/texlive/) and
[pdf2svg](https://github.com/dawbarton/pdf2svg).

## Usage

``` sh
$ tikztosvg [OPTION]... INPUT_PATH
```

If *INPUT\_PATH* is set to *-* the input will be read from stdin.

### Options

**-o, \-\-output**=*OUTPUT\_PATH*  
Write output to file *OUTPUT\_PATH*. If set to *-* the output will be written
to stdout. Defaults to the base name of the input file suffixed with the *.svg*
extension. The file is resolved relative to the working directory.

**-p, \-\-package**=+*PACKAGE*  
Include `\usepackage{PACKAGE}` when rendering the diagram. The tikz, tikz-cd,
pgfplots, amsmath and amssymb packages are always included by default.

**-l, \-\-library**=+*LIBRARY*
Include `\usetikzlibrary{LIBRARY}` when rendering the diagram.

**-q, \-\-quiet**  
Silence application log messages and script warnings.

**\-\-lualatex**
Use [LuaTeX](http://luatex.org/) as the TeX engine. LuaTeX is already the
default, so this option doesn't really do much.

**\-\-xelatex**
Use [XeTeX](http://xetex.sourceforge.net/) as the TeX engine.

**\-\-pdflatex**
Use [pdfTeX](https://www.tug.org/applications/pdftex/) as the TeX engine.

**-h, \-\-help**  
Print a help message.

**-v, \-\-version**  
Print version information.

## Example

Let’s say you want to convert the file `example.tikz` to SVG

``` latex
\begin{tikzcd}
                  G \arrow{r}{\varphi} \arrow[two heads]{d} & H \\
  \mathlarger{\sfrac{G}{\ker \varphi}} \arrow[dotted]{ru}   &
\end{tikzcd}
```

You could achieve this by running
``` sh
$ # xfrac and relsize are only there so that we can 
$ # call \sfrac and \mathlarger
$ tikztosvg -p xfrac -p relsize example.tikz
```

The results will be stored in the file `example.svg`.

## Dependencies

* A regular TeXLive installation: you'll need LuaTeX and optionally XeTeX and
  pdfTeX
* pdf2svg

## Installation

The `tikztosvg(1)` command and it’s man page can be installed in Unix systems
via Git by running
``` sh
$ git clone https://git.sr.ht/~pablo-pie/tikztosvg
$ cd tikztosvg
$ sudo make install
```

The `BIN_TARGET` Make variable (defaults to `/usr/bin/`) controls the
directory the binary is installed in, while the `MAN_TARGET` Make variable
(defaults to `/usr/share/man/man1/`) controls the directory the man page
is installed in.

## Resources

**Git source repository on sourcehut:** <https://git.sr.ht/~pablo-pie/tikztosvg>

**Bug tracker:** <https://todo.sr.ht/~pablo-pie/tikztosvg>

**CTAN package:** <https://www.ctan.org/pkg/tikztosvg>

**TeXLive** <https://tug.org/texlive/>

**LuaTeX** <http://luatex.org/>

**XeTeX** <http://xetex.sourceforge.net/>

**pdfTeX** <https://www.tug.org/applications/pdftex/>

## Authors

**tikztosvg** was written by [Pablo](mailto:pablo-escobar@riseup.net).

**pdf2svg** was written by [David Barton](mailto:davebarton@cityinthesky.co.uk)
and [Matthew Flaschen](mailto:matthew.flaschen@gatech.edu).

## License

© 2021 Pablo.

Free use of this software is granted under the terms of the GPL-3.0 License.
