# The luaset package
# version 1.1
# Authors: Chetan Shirore and Ajit Kumar
# Email: mathsbeauty@gmail.com

# Introduction
The luaset package is developed to define finite sets and perform operations on them inside LaTeX documents. 
There is no particular environment in the package for performing set operations. 
The package commands can be used in any environment (including the mathematics environment).
It is written in Lua, and tex file is to be compiled with the LuaLatex engine.
The time required for operations on sets is not an issue while compiling with the LuaLaTeX engine. 
There is no need to install Lua on the users' system as tex distributions (TeXLive or MikTeX) come bundled with LuaLaTeX. 

# License
The luaset package is released under the LaTeX Project Public License v1.3c or later. 
The complete license text is available at http://www.latex-project.org/lppl.txt. 
It is developed in Lua. 
Lua is available as a certified open-source software. 
Its license is simple and liberal, which is compatible with GPL.

#Installation and Inclusion
The installation of luaset package is similar to plain latex package, where the .sty file is in LaTeX directory of texmf tree. 
The package can be included with \usepackage{luaset} command in the preamble of the LaTeX document. 
The TeX file is to be compiled using the LuaLaTeX engine. 