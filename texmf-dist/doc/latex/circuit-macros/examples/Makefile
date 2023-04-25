# Examples Makefile
#
# Type "make" to generate examples.pdf containing many examples.
# Type "make clean; make examples.ps" to invoke latex intead of pdflatex.
# Type "make <diag>.ps" to make a postscript file from <diag>.m4
#  It may be necessary to type "make clean" before this or any of the following:
# Type "make <diag>.eps" to make an .eps file from <diag>.m4
# Type "make <diag>.svg" to make an .svg file from <diag>.m4 using pdf2svg
#   The following require ImageMagick convert:
# Type "make <diag>.png" to make a .png file from <diag>.m4
# Type "make <diag>.tif" to make a .tif file from <diag>.m4
#
#      See also: dpv subdirectory for creating svg with dpic -v without LaTeX
#
# To test the file test.m4, type "make tst" if boxdims is used, otherwise
# type "make tst1".  In either case the file tst.ps is created.
#
# There are a few extra examples in this directory.  Process them one
# at a time, or type "make extras.pdf"
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
#PIC = $$HOME/dpic/bisondev/dpic
#PIC = $$HOME/dpic/bison/dpic
#PIC = $$HOME/dpic/pascaldev/test/dpic
#PIC = $$HOME/dpic/pascal/test/dpic

#MODE = -p
MODE = -g

#CONF = pstricks.m4
CONF = pgf.m4

# Uncomment for gpic.  Use gpic or pic as applicable on your machine:
# PIC = gpic
# PIC = pic
# MODE = -t
# CONF = gpic.m4

# Convert options
EPSOPTS =
PNGOPTS = -quiet -density 400 -scale 25% -alpha Remove

# M4 = m4 -I $(LIBDIR)
# If environment variable M4PATH has been set to the installation directory:
M4 = m4

DOC = examples
TEXPICS = \
  ABlogix.tex Adder.tex Alogix.tex AmpTable.tex Antennas.tex Arresters.tex \
  Audio.tex Bip.tex Btree.tex Buttons.tex Byte.tex \
  Capacitors.tex CanLogic.tex Chips.tex Conn.tex Connectors.tex \
  Contacts.tex Contact.tex control.tex Crow.tex \
  csc.tex Csource.tex Decoder.tex \
  Demultiplexer.tex diamond.tex Dini.tex Diodes.tex Drive.tex \
  EEP.tex Emarrows.tex Escher.tex EVplugs.tex \
  ex00.tex ex01.tex ex02.tex ex03.tex ex04.tex ex05.tex ex06.tex ex08.tex \
  ex09.tex ex10.tex ex11.tex ex12.tex ex15.tex ex16.tex ex17.tex ex18.tex \
  ex21.tex exp.tex fet.tex Flow.tex Fuses.tex \
  Geometry.tex GrayCode.tex graysurf.tex Grounds.tex \
  Headers.tex Heathkit.tex \
  I2L.tex Incleps.tex Inductors.tex Jack.tex \
  lcct.tex Logic.tex Loglog.tex MC.tex Mixer.tex MoreTable.tex \
  MotorControl.tex Multiplexer.tex \
  NLG.tex NPDT.tex Nport.tex Opamp.tex Optoiso.tex \
  Pconn.tex Plate.tex PushPull.tex pwrsupply.tex \
  Quantum.tex quick.tex \
  random.tex Rectifiers.tex recycle.tex relaycoil.tex Relay.tex \
  Resistors.tex Rotbox.tex \
  Schottky.tex sfg.tex shapes.tex ShiftR.tex Sierpinski.tex Sixpole.tex \
  Smithchart.tex Sources.tex SQUID.tex Switches.tex \
  Tgate.tex Three.tex thyristor.tex TTLnand.tex Tubediags.tex \
  UNO.tex ujt.tex Variable.tex Windings.tex worm.tex Xform.tex XOR.tex

# Files that have to be processed twice:
BOXDIMS = Btree.tex ex09.tex Crow.tex Incleps.tex Loglog.tex Opamp.tex \
 random.tex Windings.tex

#########################################################################

DVIPSOPTS = -G0 -t letter
DIMFILE = $(DOC).dim
BS = tr '|' '\134'

# Might be needed (change latex commands to $(LTX) )
# LTX = latex --shell-escape
LTX = pdflatex --shell-escape

PDFLTXSRC=printf "|documentclass[11pt]{standalone}\n\
|usepackage{times,boxdims,siunitx,amssymb,tikz,geometry}\n\
|geometry{paperwidth=15in,paperheight=14in,margin=1in}\n\
|pagestyle{empty}|thispagestyle{empty}\n\
|begin{document}|noindent|input{"$*".tex}|end{document}\n" | $(BS)

# [dvipsnames]{xcolor} defines the colors near the end of:
# https://steeven9.github.io/USI-LaTeX/html/packages_hyperref_babel_xcolor3.html
# Better: use adjusted colors from http://latexcolor.com/

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
|end{document}\n" | $(BS)

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

$(DOC).pdf: clean pdfmode $(DOC).tex files.tex header.tex
	touch $(DOC).dim
	make CONF=pgf.m4 MODE=-g DIMFILE=$(DOC).dim pics
	cp $(LIBDIR)/doc/Version.tex .
	pdflatex $(DOC)
	rm -f $(BOXDIMS) ${BOXDIMS:%.tex=%.pic} $(DOC).pdf
	make CONF=pgf.m4 MODE=-g DIMFILE=$(DOC).dim $(BOXDIMS)
	pdflatex $(DOC)
	@printf "\n\n optpdf trims the pdf file\n"
	optpdf $(DOC).pdf

rose.pdf: rose.m4
	m4 pdf.m4 rose.m4 | dpic -d > rose.pdf

paletteDPV.svg: paletteDPV.m4
	m4 svg.m4 paletteDPV.m4 | dpic -v > paletteDPV.svg

keyboard.svg: keyboard.m4
	m4 svg.m4 keyboard.m4 | dpic -v > keyboard.svg

keyboard.pdf: keyboard.svg
	convert keyboard.svg keyboard.pdf

pics: $(TEXPICS) rose.pdf keyboard.pdf
	touch pics

$(DOC).ps: psmode $(DOC).dvi

psmode:
	printf "|usepackage{pstricks,pst-grad}\n" | $(BS) > mode.tex

pdfmode:
	printf "|usepackage{tikz}\n" | $(BS) > mode.tex

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

tikz:
	@$(LTXFILE) | sed -e 's/{\.tex}/{test.tex}/' -e 's/pstricks/tikz/' > tst.tex
	make CONF=pgf.m4 PIC=dpic MODE=-g test.tex; latex --quiet tst
	dvips $(DVIPSOPTS) tst -o tst.ps

gpic:
	@$(LTXFILE) | sed -e 's/{\.tex}/{test.tex}/' > tst.tex
	rm -f test.tex test.pic
	make CONF=gpic.m4 PIC=pic MODE=-t test.tex; latex --quiet tst
	dvips $(DVIPSOPTS) tst -o tst.ps

echopics:
	@echo $(TEXPICS)

XTRASRC=printf "|documentclass[11pt]{article}\n\
|usepackage[dvipsnames]{xcolor}\n\
|usepackage{times,boxdims,siunitx,amssymb,tikz,geometry}\n\
|geometry{margin=0.5cm}\n\
|begin{document}\n" | $(BS)

extras:
	( for file in `ls *.m4` ; do \
      fbase=`basename $$file .m4` ; \
      if test "`grep -L $$fbase files.tex`" = "files.tex" ; then \
        echo $$fbase ; \
        fi ; \
      done ) | sed -e '/Ball/d' \
        -e '/ASME_Y14-5/d' -e '/FlowchartDefs/d' -e '/tubedefs/d' \
        -e '/debug1/d' -e '/debug2/d' \
        -e '/paletteSVG/d' \
        -e '/Consumption/d' -e '/rotatetext/d' -e '/windows/d' \
        > extras

XBOXDIMS = Chuck

extras.pdf: extras
	@$(XTRASRC) > extras.tex
	touch extras.dim
	-for file in `cat extras` ; do \
     $(M4) pgf.m4 extras.dim $$file.m4 | $(PIC) -g > $$file.tex ; \
      printf "\n|input{$$file.tex}\n" | $(BS) >> extras.tex ; \
      printf "\n $$file.m4\n |pagebreak\n" | $(BS) >> extras.tex ; \
      done
	printf "\n|end{document}\n" | $(BS) >> extras.tex
	pdflatex extras
	-for file in $(XBOXDIMS) ; do \
      rm -f $$file.tex ; \
      $(M4) pgf.m4 extras.dim $$file.m4 | $(PIC) -g > $$file.tex ; \
      done
	pdflatex extras

testall:
	(cd mf; make)
	(cd mpost; make)
	(cd psfrag; make)
	(cd dpv; make)
	(cd xfig; make)

clobber:	clean
	rm -f *.ps
	-@for dir in mf mpost pdflatex xfig psfrag svg dev test; \
      do (if test -d $$dir ; then cd $$dir; make clobber; fi) ; done
	rm -f *.warn
	rm -f examples.pdf
	rm -rf index.html html basenames *.png* dist zips htmlfiles svgfiles
	rm -rf $(TMP)/Cir* $(ECETMP)/Cir* $(ECEDIR)
	if test -f Incl.pdf ; then \
      mv Incl.pdf Incl.pdx; rm -f *.pdf; mv Incl.pdx Incl.pdf ; fi
	for file in `ls *.tex` ; do \
      nm=`echo $$file | sed -e "s/\(.*\)\.tex/\1/"` ; \
      if test -s $$nm.m4 ; then rm -f $$nm.pic $$nm.tex ; fi ; done
#	@if test -f distmakefile ; then make -f distmakefile clobber ; fi

clean:
	@printf "\n\n examples clean:\n\n"
	-if test -f extras ; then \
      for file in `cat extras` ; do rm -f $$file.pic $$file.tex ; done ; fi
	rm -f extras extras.*
	rm -f core boxdims.tar.gz pics
	rm -f *.dvi *.aux *.log *.toc *.blg *.eps *.tif *.epsi eps *-mfpic* *.svg
	rm -f fig*.tex $(TEXPICS) *.roff *.int *.pic gpic.m4 test.tex xxx* *.fig
	rm -f rose.pdf
	rm -f *.dim *.bak rotate.ps tst.ps *.bbl *-pics.ps
	rm -f *.tfm *[0-9]pk *.png *.svg *.1 *.gif
	rm -f F_* Version.tex *stackdump *.ico ./.[A-Za-z]*
	rm -rf distfile distfile.tar.gz mode.tex
	@printf "\n"
#	@if test -f distmakefile ; then make -f distmakefile clean ; fi
