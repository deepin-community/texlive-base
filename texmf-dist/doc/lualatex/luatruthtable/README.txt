# The luatruthtable package
# version 1.3
# Authors: Chetan Shirore and Ajit Kumar
# Email: mathsbeauty@gmail.com

# Introduction
The luatruthtable package is developed to generate Truth Tables of boolean values in LaTeX. It provides an easy way for generating truth tables in LaTeX . There is no need of special environment in the package for generation of Truth Tables. It is written in lua and tex file is to be compiled with LuaLatex engine.  The time required for operations is no issue while compiling with LuaLaTeX.  There is no need to install lua on users system as tex distributions (TeXLive or MikTeX) come bundled with LuaLaTeX. It is useful for generation of Truth Tables in tex file itself. The package supports nesting of commands for multiple operations. It can be modified or extended by writing custom lua programs. 

# License
The luatruthtable package is released under the LaTeX Project Public License v1.3c or later. The complete license text is available at http://www.latex-project.org/lppl.txt.
It is developed in lua.  Lua is certified open source software available. Its license is simple and liberal which is compatible with GPL.

#Installation and Inclusion
The installation of  luatruthtable package is similar to plain latex package where luatruthtable.sty file is in LaTeX directory of texmf tree. The package can be used by including the command  \usepackage{luatruthtable} in the preamble of latex document.The tex file is to be compiled using the LuaLaTeX engine.