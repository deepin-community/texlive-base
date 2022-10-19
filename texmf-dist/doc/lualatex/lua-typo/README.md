Lua-typo
========

Description
-----------
This package tracks common typographic flaws in LuaLaTeX documents,
specially widows, orphans, hyphenated words split over two pages,
consecutive lines ending with hyphens, paragraphs ending on
too short lines, etc.

Documentation
-------------

For the impatient: have a look at files demo.tex and demo.pdf to see
a short example of how some flaws are highlighted.

Then read the documentation in English (file lua-typo.pdf) or in French
(file lua-typo-fr.pdf).

License
-------

Released under the LaTeX Project Public License v1.3c or later
See http://www.latex-project.org/lppl.txt
for the details of that license.

Installation
------------

This bundle is meant to be included in most TeX distributions,
but if you need to install it by yourself
1. run "luatex lua-typo.dtx" to strip the comments and create
   lua-typo.sty, lua-typo.cfg, lua-typo.ltx and lua-typo-fr.ltx;
2. run "lualatex lua-typo.ltx" to get the full documentation
   (lua-typo.pdf) in English;
2. run "lualatex lua-typo-fr.ltx" to get the French documentation
   (lua-typo-fr.pdf, code not included).

Recommended loactions for installation:
- TDS:tex/lualatex/lua-typo/lua-typo.sty
- TDS:tex/lualatex/lua-typo/lua-typo.cfg
- TDS:doc/lualatex/lua-typo/lua-typo.pdf
- TDS:doc/lualatex/lua-typo/demo.pdf
- TDS:doc/lualatex/lua-typo/demo.tex
- TDS:doc/lualatex/lua-typo/README.md
- TDS:source/lualatex/lua-typo/lua-typo.dtx

Changes
-------

* First release version: 0.30, March 2021.

* v.0.32: bug fixes
  - better protection against nil nodes,
  - new page detection corrected,
  - homeoarchy detection improved.

* v.0.40 (not released): bug fixes
  - in some cases parlines count was wrong, fixed;
  - partial improvement of short pages detection.

* v.0.50: new implementation, May 2021
  - callback change: `pre_shipout_filter` instead of `pre_output_filter`
    this change requires latex release 2021-06-01;
  - rollback enabled in case `pre_shipout_filter` is missing;
  - footnotes are scanned now;
  - overfull box detection fixed (works for equations and tt fonts now);
  - short pages detection fixed;
  - coloration of faulty lines improved;
  - all flaws found are now recorded into file "`\jobname`.typo".

--
Copyright 2020--2021 Daniel Flipo
E-mail: daniel (dot) flipo (at) free (dot) fr
