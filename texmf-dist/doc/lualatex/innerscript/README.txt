            LaTeX Package innerscript v. 1.2
               Installation Guide/README
                    Conrad Kosowsky


This file is README.txt from version 1.2 of the free and
open-source LaTeX package "innerscript," released November
2023, to be used with the LuaTeX engine. The innerscript
package optionally modifies four aspects of TeX's automatic
math formatting rules to improve typesetting. See the user
guide for more information. See below for installation and
license information.

*********************************************************

To install innerscript automatically, update your TeXLive or
MacTeX distribution or use a package manager such as tlmgr.

To install innerscript manually requires two steps as follows.

Step 1: You need to generate the package file innerscript.sty
from innerscript_code.dtx. You can do this in two ways:

  (1) Running Plain TeX on innerscript_code.dtx will create
      innerscript.sty as well as several other tex files that
      can be used for typesetting documentation.

  (2) Running LaTeX on innerscript_code.dtx will produce the
      files listed in point (1) including innerscript.sty as
      well as innerscript_code.pdf, which documents the 
      package code.

Step 2: Once you have created innerscript.sty, you should
move it into a directory searchable by TeX to complete the
installation. If you are unsure how to do this, consult your
TeX distribution.

*********************************************************

Besides this README, the installation contains the following
items:

  (1) innerscript_code.dtx: the main file. See above for
      instructions to generate innerscript.sty from this
      file and complete the installation.

  (2) innerscript_code.pdf: documentation of the package
      code.

  (3) innerscript_user_guide.pdf: a user guide.

Typesetting innerscript_code.dtx will create
innerscript_user_guide.tex, which is the tex file that
produces the user guide in point (3) above.

*********************************************************

Copyright 2021,2023 by Conrad Kosowsky

This file may be distributed and modified under the terms
of the LaTeX Public Project License, version 1.3c or any
later version. The most recent version of this license is
available online at

          https://www.latex-project.org/lppl/

This Work has the LPPL status "maintained," and the current
maintainer is the package author, Conrad Kosowsky. He can
be reached at kosowsky.latex@gmail.com. The Work consists
of the following items:

  (1) the base file:
        innerscript.dtx

  (2) the package file:
        innerscript.sty

  (3) the pdf documentation files:
        innerscript_code.pdf
        innerscript_user_guide.pdf

  (4) the derived files:
        innerscript_user_guide.tex
        innerscript_heading.tex

  (5) all other files created through the configuration
      process
 
    and

  (6) this README.txt file

PLEASE KNOW THAT THIS FREE SOFTWARE IS PROVIDED WITHOUT
ANY WARRANTY. SPECIFICALLY, THE "NO WARRANTY" SECTION OF
THE LATEX PROJECT PUBLIC LICENSE STATES THE FOLLOWING:

THERE IS NO WARRANTY FOR THE WORK. EXCEPT WHEN OTHERWISE
STATED IN WRITING, THE COPYRIGHT HOLDER PROVIDES THE WORK
`AS IS’, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE
OF THE WORK IS WITH YOU. SHOULD THE WORK PROVE DEFECTIVE,
YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR, OR
CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED
TO IN WRITING WILL THE COPYRIGHT HOLDER, OR ANY AUTHOR
NAMED IN THE COMPONENTS OF THE WORK, OR ANY OTHER PARTY
WHO MAY DISTRIBUTE AND/OR MODIFY THE WORK AS PERMITTED
ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL,
SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT
OF ANY USE OF THE WORK OR OUT OF INABILITY TO USE THE WORK
(INCLUDING, BUT NOT LIMITED TO, LOSS OF DATA, DATA BEING
RENDERED INACCURATE, OR LOSSES SUSTAINED BY ANYONE AS A
RESULT OF ANY FAILURE OF THE WORK TO OPERATE WITH ANY
OTHER PROGRAMS), EVEN IF THE COPYRIGHT HOLDER OR SAID
AUTHOR OR SAID OTHER PARTY HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGES.

For more information, see the LaTeX Project Public License.
Derivative works based on this software may come with their
own license or terms of use, and the package author is not
responsible for any third-party software.

*********************************************************

For more information, see innerscript_code.dtx. Happy TeXing!
