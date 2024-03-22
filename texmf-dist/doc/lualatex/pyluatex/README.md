# PyLuaTeX
**Execute Python code on the fly in your LaTeX documents**

PyLuaTeX allows you to execute Python code and to include the resulting output in your LaTeX documents in a *single compilation run*.
LaTeX documents must be compiled with LuaLaTeX for this to work.


## Example
1\. LaTeX document `example.tex`

```latex
\documentclass{article}

\usepackage{pyluatex}

\begin{python}
import math
import random

random.seed(0)

greeting = 'Hello PyLuaTeX!'
\end{python}

\newcommand{\randint}[2]{\py{random.randint(#1, #2)}}

\begin{document}
\py{greeting}

$\sqrt{371} = \py{math.sqrt(371)}$

\randint{2}{5}
\end{document}
```

2\. Compile using LuaLaTeX (shell escape is required)
```
lualatex --shell-escape example.tex
```

**Note:** PyLuaTeX starts Python 3 using the command `python3` by default.
If `python3` does not start Python 3 on your system, find the correct command
and replace `\usepackage{pyluatex}` with `\usepackage[executable=<your python command>]{pyluatex}`.
For example, `\usepackage[executable=python.exe]{pyluatex}`.

**Note:** Running LaTeX with the shell escape option enabled allows arbitrary code to be
executed. For this reason, it is recommended to compile trusted documents only.

## Requirements
* LuaLaTeX
* Python 3
* Linux, macOS or Windows

## License
[LPPL 1.3c](http://www.latex-project.org/lppl.txt) for LaTeX code and
[MIT license](https://opensource.org/licenses/MIT) for Python and Lua code and other files.

## Further Information
Author: Tobias Enderle

Development: https://github.com/tndrle/PyLuaTeX
