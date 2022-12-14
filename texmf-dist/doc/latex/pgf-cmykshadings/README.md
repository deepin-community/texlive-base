# pgf-cmykshadings — Support for CMYK and grayscale shadings in PGF/TikZ

> **Note: This package is now deprecated. Support for CMYK and grayscale
> shadings was added to `pgf` in version 3.1.3. Attempting to load it with
> recent versions of `pgf` only changes the default shading colour model with
> the `xcolor` `natural` colour model to CMYK.**

The `pgf-cmykshadings` package provides support for CMYK and grayscale shadings
for the `pgf` package. By default `pgf` only supports RGB shadings.
`pgf-cmykshadings` attempts to produce shadings consistent with the currently
selected `xcolor` colour model. The `rgb`, `cmyk`, and `gray` colour models
from the `xcolor` package are supported.

## Installation from TeXLive or MiKTeX

`pgf-cmykshadings` is in TeXLive and MiKTeX and can be installed in the usual
way through your distribution. e.g., in TeXLive by running:

```
tlmgr install pgf-cmykshadings
```

## Installation from CTAN

Download and unpack `pgf-cmykshadings.zip` from CTAN at
https://ctan.org/pkg/pgf-cmykshadings

Change to the `pgf-cmykshadings` directory, then run:

```
tex pgf-cmykshadings.ins
```

to generate the style file (`pgf-cmykshadigns.sty`) and driver files
(`pgfsys-cmykshadings-*.def`).

Copy these generated files to `$TEXMFHOME/tex/latex/pgf-cmykshadings/` and
`pgf-cmykshadings.pdf` to `$TEXMFHOME/doc/latex/pgf-cmykshadings/`.

You can find `$TEXMFHOME` by running:

```
kpsewhich -var-value=TEXMFHOME
```

## Installation from Git Source

`pgf-cmykshadings` uses the `l3build` system.

Clone the git repository using:

```
git clone https://github.com/dcpurton/pgf-cmykshadings.git
```

Change to the `pgf-cmykshadings` directory, and then the package and
documentation can be installed by running:

```
l3build install --full
```

## Licence

```
Copyright (c) 2018-2019 David Purton <dcpurton@marshwiggle.net>

This work may be distributed and/or modified under the conditions of
the LaTeX Project Public License, either version 1.3c of this license
or (at your option) any later version. The latest version of this
license is in
   http://www.latex-project.org/lppl.txt
and version 1.3c or later is part of all distributions of LaTeX
version 2005/12/01 or later.

This work is "maintained" (as per the LPPL maintenance status)
by David Purton.

This work consists of the files pgf-cmykshadings.ins,
pgf-cmykshadings.dtx, README.md, and the derived files
  - pgf-cmykshadings.sty
  - pgfsys-cmykshadings-pdftex.def
  - pgfsys-cmykshadings-xetex.def
  - pgfsys-cmykshadings-luatex.def
  - pgfsys-cmykshadings-dvipdfmx.def
  - pgfsys-cmykshadings-dvipdfm.def
  - pgfsys-cmykshadings-dvips.def
  - pgfsys-cmykshadings-textures.def
  - pgfsys-cmykshadings-vtex.def
  - pgfsys-cmykshadings-common-postscript.def
  - pgf-cmykshadings.pdf


Substantial parts of the code for this package are taken from the pgf package
file pgfcoreshade.code.tex, along with the driver files pgfsys-*.def, copyright
(c) 2006 Till Tantau and then slightly modified to support CMYK and grayscale
shadings.
```

