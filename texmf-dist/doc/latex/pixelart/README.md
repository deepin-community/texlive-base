pixelart 🎨 A LaTeX package to draw pixel-art pictures
======================================================

![Example](https://framagit.org/spalax/pixelart/-/raw/v1.0.0/pixelart.png)

- [Usage and installation instruction](http://mirrors.ctan.org/graphics/pgf/contrib/pixelart/pixelart.pdf).
- Example: The heart of the picture above was produced using the following code.

```latex
\pixelart[
    colors={
      1=red,
      2={red!50!black},
      3={pink},
      4={pink!50!red},
    },
  ]{%
    ..12..12..
    .13411112.
    1341111112
    1341111112
    1341111112
    .11111112.
    ..111112..
    ...1112...
    ....12....
}
```

License
-------

*Copyright 2018-2022 Louis Paternault*

This work may be distributed and/or modified under the conditions of the LaTeX
Project Public License, either version 1.3 of this license or (at your option)
any later version.

The latest version of this license is in http://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions of LaTeX version
2005/12/01 or later.
