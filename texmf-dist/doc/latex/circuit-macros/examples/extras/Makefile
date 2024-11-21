# Extras Makefile
#
# Type "make" to generate extras.pdf containing examples.
#   The examples are in no particular order (well, they are in ls order).
# Type "make clean; make extras.ps" to invoke latex intead of pdflatex.
# Type "make <diag>.ps" to make a postscript file from <diag>.m4
#  It may be necessary to type "make clean" before this or any of the following:
# Type "make <diag>.eps" to make an .eps file from <diag>.m4
# Type "make <diag>.svg" to make an .svg file from <diag>.m4 using pdf2svg
#   The following require ImageMagick convert:
# Type "make <diag>.png" to make a .png file from <diag>.m4
# Type "make <diag>.tif" to make a .tif file from <diag>.m4
#
# To test the file test.m4, type "make tst" if boxdims is used, otherwise
# type "make tst1".  In either case the file tst.ps is created.
#
# To debug a single diagram in a directory other than this examples
# directory, copy this makefile and tst.tex to where you want to work,
# redefine LIBDIR (below) appropriately, and type "make <diag>.xxx"
# where xxx is one of ps, eps, png, or pdf

#########################################################################

# Circuit_macro directory, change this if necessary:
# LIBDIR = $$HOME/lib
LIBDIR = ..

# The dpic processor:
PIC = dpic

#MODE = -p
MODE = -g

#CONF = pstricks.m4
CONF = pgf.m4

# Convert options
EPSOPTS =
PNGOPTS = -quiet -density 400 -scale 25% -alpha Remove

# M4 = m4 -I $(LIBDIR)
# If environment variable M4PATH has been set to the installation directory:
M4 = m4

DOC = extras

# Files that have to be processed twice:
BOXDIMS =

#########################################################################

DVIPSOPTS = -G0 -t letter
DIMFILE = $(DOC).dim
TRSLASH = tr '|' '\134'

# Might be needed (change latex commands to $(LTX) )
# LTX = latex --shell-escape
LTX = pdflatex --shell-escape

XTRASRC=printf "|documentclass[11pt]{article}\n\
|usepackage[dvipsnames]{xcolor}\n\
|usepackage{times,boxdims,siunitx,amssymb,tikz}\n\
|setlength{|textwidth}{8in} |setlength{|textheight}{10.5in}\n\
|setlength{|hoffset}{-2cm} |setlength{|voffset}{-3cm}\n\
|begin{document}\n" | $(TRSLASH)

PDFLTXSRC=printf "|documentclass[11pt]{standalone}\n\
|usepackage{times,boxdims,siunitx,amssymb,tikz,geometry}\n\
|geometry{paperwidth=15in,paperheight=14in,margin=1in}\n\
|pagestyle{empty}|thispagestyle{empty}\n\
|begin{document}|noindent|input{"$*".tex}|end{document}\n" | $(TRSLASH)

LTXFILE=printf "|documentclass[11pt]{article}\n\
|usepackage[dvipsnames]{xcolor}\n\
|usepackage{times,boxdims,graphicx,pstricks}\n\
|usepackage{siunitx}\n\
|setlength{|textwidth}{28cm}|setlength{|textheight}{28cm}\n\
|setlength{|oddsidemargin}{0pt}|setlength{|evensidemargin}{0pt}\n\
|setlength{|hoffset}{-1cm}\n\
|pagestyle{empty}|thispagestyle{empty}\n\
|newbox|graph\n\
|begin{document}\n\
|noindent|input{"$*".tex}|box|graph\n\
|end{document}\n" | $(TRSLASH)

.SUFFIXES: .ps .dvi .tex .m4 .pic .eps .png .pdf .svg .tif .gif
.m4.pic:
	@touch $(DIMFILE) F_$*.dim
	$(M4) $(CONF) $(DIMFILE) F_$*.dim $*.m4 > $*.pic
.m4.tex:
	@touch $(DIMFILE) F_$*.dim
	$(M4) $(CONF) $(DIMFILE) F_$*.dim $*.m4 | $(PIC) $(MODE) > $*.tex
.m4.dvi:
	@touch $(DIMFILE) F_$*.dim
	$(M4) pstricks.m4 $(DIMFILE) F_$*.dim $*.m4 | $(PIC) -p > $*.tex
	@$(LTXFILE) > F_$*.tex
	latex --quiet F_$*
	touch F_$*.dim $(DIMFILE)
	$(M4) pstricks.m4 $(DIMFILE) F_$*.dim $*.m4 | $(PIC) -p > $*.tex
	latex --quiet F_$*
	mv F_$*.dvi $*.dvi
	rm -f F_*
.dvi.ps:
	dvips $(DVIPSOPTS) $* -o $*.ps
	chmod 644 $*.ps
.m4.ps:
	@touch $(DIMFILE) F_$*.dim
	$(M4) pstricks.m4 $(DIMFILE) F_$*.dim $*.m4 | $(PIC) -p > $*.tex
	@$(LTXFILE) > F_$*.tex
	latex --quiet F_$*
	dvips $(DVIPSOPTS) F_$* -o $*.ps
	chmod 644 $*.ps
	rm -f F_*
.m4.eps:
	@touch $(DIMFILE) F_$*.dim
	$(M4) pstricks.m4 $(DIMFILE) F_$*.dim $*.m4 | $(PIC) -p > $*.tex
	@$(LTXFILE) > F_$*.tex
	latex --quiet F_$*
	$(M4) pstricks.m4 $(DIMFILE) F_$*.dim $*.m4 | $(PIC) -p > $*.tex
	latex --quiet F_$*
	dvips F_$* -T128cm,28cm -o $*.ps
# Recent changes to PSTricks(?) have clashed with the use of TeXtoEPS
#  so use ps2epsi
	ps2epsi $*.ps $*.epsi
	sed -e '/%%Pages:/d' -e '/BeginPreview/,$$d' $*.epsi \
     | tr '\015' '\012' > $*.eps
	sed -e '1,/EndPreview/d' $*.epsi >> $*.eps
	rm -f F_*
.m4.pdf:
	@touch $(DIMFILE) F_$*.dim
	$(M4) pgf.m4 $(DIMFILE) F_$*.dim $*.m4 | $(PIC) -g > $*.tex
	@$(PDFLTXSRC) > F_$*.tex
	pdflatex --quiet F_$*
	$(M4) pgf.m4 $(DIMFILE) F_$*.dim $*.m4 | $(PIC) -g > $*.tex
	pdflatex --quiet F_$*
	mv F_$*.pdf $*.pdf
	rm -f F_*
.m4.png:
	make $*.pdf
	convert $(PNGOPTS) $*.pdf $*.png
	@if test -f $*.png.0 ; then mv $*.png.0 $*.png ; fi
#	rm $*.pdf
.m4.gif:
	make $*.pdf
	convert $(GIFOPTS) $*.pdf $*.gif
#	rm $*.pdf
.m4.tif:
	make $*.pdf
	convert $(EPSOPTS) $*.pdf $*.tif
	@if test -f $*.tif.0 ; then mv $*.tif.0 $*.tif ; fi
#	rm $*.pdf
.m4.svg:
	make $*.pdf
	dvisvgm --pdf $*.pdf $*.svg
	chmod 644 $*.svg
#	rm $*.pdf


#########################################################################

$(DOC).pdf: texfiles
	@$(XTRASRC) > extras.tex
	touch extras.dim
	-for fl in `ls *.m4` ; do \
     file=`basename $$fl .m4` ; \
      printf "\n\n|noindent|parbox{|textwidth}{\n" | $(TRSLASH) >> extras.tex; \
      printf "|input{$$file.tex}\n" | $(TRSLASH) >> extras.tex ; \
      printf "\n $$file.m4\n}\n|vspace{|baselineskip}" \
       | sed -e 's/_/|_/g' | $(TRSLASH) >> extras.tex ; \
      done
	printf "\n|end{document}\n" | $(TRSLASH) >> extras.tex
	pdflatex extras
#	-for file in $(XBOXDIMS) ; do \
#      rm -f $$file.tex ; \
#      $(M4) pgf.m4 extras.dim $$file.m4 | $(PIC) -g > $$file.tex ; \
#      done
#	pdflatex extras

texfiles:
	touch extras.dim
	for fl in `ls *.m4` ; do \
     file=`basename $$fl .m4` ; \
     echo $$file.m4 ; \
     $(M4) pgf.m4 extras.dim $$file.m4 | $(PIC) -g > $$file.tex ; done
	touch texfiles

$(DOC).ps: psmode $(DOC).dvi

psmode:
	printf "|usepackage{pstricks,pst-grad}\n" | $(TRSLASH) > mode.tex

pdfmode:
	printf "|usepackage{tikz}\n" | $(TRSLASH) > mode.tex

$(DOC).dvi: $(DOC).tex files.tex header.tex psmode
	touch $(DOC).dim
	make CONF=pstricks.m4 MODE=-p DIMFILE=$(DOC).dim pics
	cp $(LIBDIR)/doc/Version.tex .
	latex $(DOC)
	rm -f $(BOXDIMS) ${BOXDIMS:%.tex=%.pic} $(DOC).dvi
	make CONF=pstricks.m4 MODE=-p DIMFILE=$(DOC).dim $(BOXDIMS)
	latex $(DOC)

tst:
	@$(LTXFILE) | sed -e 's/{\.tex}/{test.tex}/' > tst.tex
	make CONF=pstricks.m4 PIC=dpic MODE=-p test.tex; latex --quiet tst
	rm -f test.tex test.pic
	make CONF=pstricks.m4 PIC=dpic MODE=-p test.tex; latex --quiet tst
	dvips $(DVIPSOPTS) tst -o tst.ps

tst1:
	@$(LTXFILE) | sed -e 's/{\.tex}/{test.tex}/' > tst.tex
	make CONF=pstricks.m4 PIC=dpic MODE=-p test.tex; latex --quiet tst
	dvips $(DVIPSOPTS) tst -o tst.ps

clean:
	rm -f *.ps *.pdf *.tex *.dim *.pic *.log *.dms *.aux *.svg texfiles
