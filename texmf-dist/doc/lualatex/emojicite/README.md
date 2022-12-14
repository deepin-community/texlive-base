# emojicite

[[CTAN](https://www.ctan.org/tex-archive/macros/luatex/latex/emojicite)] |
[[PDF Docu](http://mirrors.ctan.org/macros/luatex/latex/emojicite/emojicite-doc.pdf)]

Scientific publications are too dry. Too much math, too little emotions. Science
needs emojis!
Leave a small heart to value the hard work gone into a paper (Smith, 2014 โค๏ธ ).
Flag self-citations as in (Sixt et al., 2019 ๐คณ)
Finally, you can express what you truly think directly as in (Wakefield et. al, 1998 ๐คฆ).
We could also indicate, how thoroughly we read papers (Van Wesel et al., 2014 ๐)

## Basic Usage

```
\documentclass{article}

\usepackage{emojicite}
\setcitestyle{authoryear, round}
\bibliographystyle{plainnat}

\begin{document}

\emojicitep{einstein, kissing-heart}

\bibliography{bibliography}
\end{document}
```

See [example.tex](./example.tex) for basic usage.

## Examples

Table 1: How did you liked the cited work?

| Citation                       |      Emoji     |  Description         |
|--------------------------------|:--------------:|:---------------------|
| (Einstein, 1905 ๐)            | kissing-heart  | I like this work. Here is a kiss.
| (Shannon, 1948 ๐)             | bow            | Wow, I can only bow to this work.
| (Kim et al., 2017 ๐)          | +1             | Good work!
| (Zhang and Cheok, 2016 ๐ )    | confused       | I am confused by this work.
| (Le Cun et al., 1989 ๐ฅฑ)       | yawning-face   | Boring work.
| (Tishby and Zaslavsky, 2015 ๐คจ)| raised-eyebrow | I have some serious questions...
| (Wakefield et al., 1998 ๐คฆ)    | facepalm       | omg, this work sucks!


Table 2: How thoroughly have you read the work?

| Citation                       |      Emoji     |  Description         |
|--------------------------------|:--------------:|:---------------------|
| (Kingma and Welling, 2013 ๐ค)  | nerd-face      | I know everything about this work.
| (Kim et al., 2017 ๐)          | graduation-cap | I know this work well.
| (Shannon, 1948 ๐ค)             | thinking       | I read it but I still have questions.
| (Jones, 1972 ๐)               | see-no-evil    | Ups, I did not read this work in-depth.
| (Einstein, 1905 ๐คท)            | shrug          | too long; did not read

See [PDF Docu](http://mirrors.ctan.org/macros/luatex/latex/emojicite/emojicite-doc.pdf) for more examples.


## Requirements

The package requires the Tex Live 2020 distributon and you need to use lualatex.
If you use the `latexmk` tool, simple use `latexmk -pdflua`.  See the
[emoji](https://github.com/stone-zeng/latex-emoji) package for are in-depth
description on the requirements.


-----

Copyright (C) 2020 by Leon Sixt, License LPPL 1.3c

๐ to Xiangdong Zeng creator of [emoji](https://github.com/stone-zeng/latex-emoji)
