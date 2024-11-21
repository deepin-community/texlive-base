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
but if you really need to install it by yourself
1. run "luatex lua-typo.dtx" to strip the comments and create
   lua-typo.sty, lua-typo.cfg, lua-typo.ltx and lua-typo-fr.ltx;
2. run "lualatex lua-typo.ltx" to get the full documentation
   (lua-typo.pdf) in English;
3. run "lualatex lua-typo-fr.ltx" to get the French documentation
   (lua-typo-fr.pdf, without documented code).

Recommended locations for installation:
- TDS:tex/lualatex/lua-typo/lua-typo.sty
- TDS:tex/lualatex/lua-typo/lua-typo.cfg
- TDS:doc/lualatex/lua-typo/lua-typo.pdf
- TDS:doc/lualatex/lua-typo/demo.pdf
- TDS:doc/lualatex/lua-typo/demo.tex
- TDS:doc/lualatex/lua-typo/README.md
- TDS:source/lualatex/lua-typo/lua-typo.dtx

On Debian based systems, the "TDS:" prefix can be replaced by "$HOME/texmf/"
for a single user installation.

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

* v.0.51 (not released): bug fix
  - in some cases orphans were not detected.

* v.0.60: new implementation, Feb. 2023
  - this version should do a better job on two columns documents;
  - debugging stuff added.

* v.0.61: 
  - bug fixes and documentation enhanced;
  - colours `mygrey` and `myred` renamed as `LTgrey` and `LTred`.

* v.0.65: 
  - new option `ShortFinalWord` to detect short end-of-sentence word
    on top of next page;
  - code cleaning.

* v.0.70: 
  - options handled via `ltkeys` instead of `kvoptions`;
  - Code cleaning, bug fixes.

* v.0.80: 
  - config file `lua-typo.cfg` changed (new colours added,  all colour 
    numbers are shifted by 1);
  - colours no longer override each other, a special colour has been 
    added for lines affected by multiple flaws (f.i. widow+overfull);
  - bug fix (file `.typo`): in footnotes, line numbers for homeoarchy 
    were not reset.

* v.0.85: 
  - a warning is issued if some pages fail to be checked properly;
  - margin notes checking added (over/underfull lines, position);
  - code cleaning, bug fixes.

* v.0.86: 
  - corrected typo in the `signature` function;
  - compatibility with package `stfloats` added.

* v.0.87: 
  - improved page body detection.
  - warning about incompability with the `reledmac` package added.
  
--
Copyright 2020--2024 Daniel Flipo 
E-mail: daniel (dot) flipo (at) free (dot) fr
