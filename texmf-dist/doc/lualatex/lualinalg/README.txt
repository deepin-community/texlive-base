# The lualinalg package
# version 1.9
# Authors: Chetan Shirore and Ajit Kumar
# Email: mathsbeauty@gmail.com

# Introduction
The lualinalg package is developed to perform operations on vectors and matrices defined over the field of real or complex numbers inside LaTeX documents.
It provides flexible ways for defining and displaying vectors and matrices. 
No particular environment of LaTeX is required to use commands in the package. 
The package is written in Lua, and tex file is to be compiled with the LuaLaTeX engine. 
The time required for calculations is not an issue while compiling with LuaLaTeX. 
There is no need to install Lua on the user's system as TeX distributions (TeXLive or MikTeX) come bundled with LuaLaTeX. 
It may also save users' efforts to copy vectors and matrices from other software (which may not be in latex-compatible format) and to use them in a tex file. 
The vectors and matrices of reasonable size can be handled with ease. 
The package can be modified or extended by writing custom Lua programs.

# License
The lualinalg package is released under the LaTeX Project Public License v1.3c or later.
The complete license text is available at  http://www.latex-project.org/lppl.txt.
It is developed in Lua. Lua is available as a certified open-source software.
Its license is simple and liberal, which is compatible with GPL. 
The package makes use of complex.lua file which is available on https://github.com/davidm/lua-matrix/blob/master/lua/complex.lua. 
It  is available under the same licensing as that of Lua. 
The package also loads the luamaths package, which is available under the LaTeX Project Public License v1.3c or later. 
This package is loaded to use the standard mathematical functions and for computations on real numbers while performing operations on vectors and matrices.

#Installation and Inclusion
The installation of lualinalg package is similar to plain latex package, where the .sty file is in LaTeX directory of texmf tree. 
The package can be included with \usepackage{lualinalg} command in the preamble of the LaTeX document. 