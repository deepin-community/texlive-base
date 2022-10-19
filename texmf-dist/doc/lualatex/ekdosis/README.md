---
author:
- Robert Alessi
title: 'The ekdosis package – README file'
---

Overview
========
`ekdosis` is a LuaLaTeX package designed for multilingual critical
editions. It can be used to typeset texts and different layers of
critical notes in any direction accepted by LuaTeX. Texts can be
arranged in running paragraphs or on facing pages, in any number of
columns which in turn can be synchronized or not. In addition to
printed texts, `ekdosis` can convert `.tex` source files so as to
produce `TEI xml`-compliant critical editions. Database-driven
encoding under LaTeX then allows extraction of texts entered segment
by segment according to various criteria: main edited text, variant
readings, translations or annotated borrowings between texts. It is
published under the terms of the GNU General Public License (GPL)
version 3.

License and Disclamer
=====================
ekdosis – Typesetting TEI xml-Compliant Critical Editions

Copyright ⓒ 2020--2021 Robert Alessi

Please send error reports and suggestions for improvements to Robert
Alessi:

-   email: <alessi@robertalessi.net>

-   website: <http://www.robertalessi.net/ekdosis>

-   comments, feature requests, bug reports:
    <https://gitlab.com/ralessi/ekdosis/issues>

-   mailing list, support: <http://www.robertalessi.net/mailman/listinfo/ekdosis> [[mailing list archives](http://www.robertalessi.net/pipermail/ekdosis/)]

This program is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation, either version 3 of the License, or (at your
option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
Public License for more details.

You should have received a copy of the GNU General Public License along
with this program. If not, see <http://www.gnu.org/licenses/>.

This release of ekdosis consists of the following source files:

-   `ekdosis.dtx`

-   `ekdosis.ins`

-   `ekdosis.el`

-   `Makefile`

License Applicable to the Documentation
---------------------------------------
Copyright ⓒ 2020--2021 Robert Alessi

The documentation file `ekdosis.pdf` that is generated from the
`ekdosis.dtx` source file is licensed under the GNU Free Documentation
License, as follows:---

Permission is granted to copy, distribute and/or modify this document
  under the terms of the GNU Free Documentation License, Version 1.3
  or any later version published by the Free Software Foundation; with
  no Invariant Sections, no Front-Cover Texts, and no Back-Cover
  Texts.  A copy of the license is included in the section entitled
  “GNU Free Documentation License”.

Installation
============
1.  Run `'latex ekdosis.ins'` to produce the `ekdosis.sty` and
    `ekdosis.lua` files.

2.  To finish the installation you have to move the `ekdosis.sty` and
    `ekdosis.lua` files into a directory where LaTeX can find them. See
    the FAQ on `texfaq.org` at <https://texfaq.org/FAQ-inst-wlcf> for
    more on this.

Development, Git Repository
===========================

Browse the Code
---------------
You can browse ekdosis repository on the web:
<http://git.robertalessi.net/ekdosis>

From this page, you can download all the releases of `ekdosis`. For
instructions on how to install `ekdosis`, please see above.

Comments, Feature Requests, Bug Reports
---------------------------------------
<https://gitlab.com/ralessi/ekdosis/issues>


Download the Repository
-----------------------
`ekdosis` development is facilitated by git, a distributed version
control system. You will need to install git (most GNU/Linux
distributions package it in their repositories).

Use this command to download the repository

    git clone http://git.robertalessi.net/ekdosis

A new directory named ekdosis will have been created, containing
`ekdosis`.

Git Hosting
-----------
Make an account on <https://gitlab.com> and navigate (while logged in)
to <https://gitlab.com/ralessi/ekdosis>. Click *Fork* and you will
have in your account your own repository of `ekdosis` where you will
be able to make whatever changes you like to.
