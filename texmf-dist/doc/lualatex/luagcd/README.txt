# The luagcd package
# version 1.1
# Authors: Chetan Shirore and Ajit Kumar
# Email: mathsbeauty@gmail.com

# Introduction
Using Lua, the luagcd package is developed to find the greatest common divisor (gcd) of integers in LaTeX.
The package provides commands to obtain step-by-step computation of gcd of two integers by using the Euclidean algorithm. 
In addition, the package has the command to express gcd of two integers as a linear combination. 
The Bezout’s Identity can be verified for any two integers using commands in the package. 
No particular environment is required for the use of commands in the package. 
It is written in Lua, and the TeX file has to be compiled with the LuaLaTeX engine.


# License
The luagcd package is released under the LaTeX Project Public License v1.3c or later. 
The complete license text is available at http://www.latex-project.org/lppl.txt. 
It is developed in Lua. 
Lua is available as a certified open-source software. 
Its license is simple and liberal, which is compatible with GPL.

#Installation and Inclusion
The installation of luagcd package is similar to plain latex package, where the .sty file is in LATEXdirectory of texmf tree. 
The package can be included with \usepackage{luagcd} command in the preamble of the LaTeX document. 
The TeX file is to be compiled using the LuaLaTeX engine. 