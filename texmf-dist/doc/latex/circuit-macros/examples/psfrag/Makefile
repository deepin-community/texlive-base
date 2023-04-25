# Makefile for the psfrag subdirectory

# Where the .m4 libraries are installed.  Change if necessary:
LIBDIR = $$HOME/lib

#---------------------------------------------

MKDIM=pwd | sed -e 's%^%=boxdimfile{%' -e 's%/cygdrive/\(.\)/%\1:/%' \
       -e 's%$$%/$(DIMFILE)}%'

# Comment out the following line to produce absolute addresses for .dim files.
MKDIM=printf '=boxdimfile{$(DIMFILE)}\n'

#---------------------------------------------

# The .m4 circuit_macro libraries used for the examples:
M4MACROS = psfrag.m4
M4 = m4 

#---------------------------------------------
DOC = examplespsfrag

FIGS = \
  ABlogix.eps Adder.eps Alogix.eps AmpTable.eps Antennas.eps Arresters.eps \
  Audio.eps Bip.eps Btree.eps Buttons.eps Byte.eps \
  Capacitors.eps CanLogic.eps Chips.eps Conn.eps Connectors.eps \
  Contacts.eps Contact.eps control.eps Crow.eps \
  csc.eps Csource.eps Decoder.eps \
  Demultiplexer.eps diamond.eps Dini.eps Diodes.eps Drive.eps \
  EEP.eps Emarrows.eps Escher.eps EVplugs.eps \
  ex00.eps ex01.eps ex02.eps ex03.eps ex04.eps ex05.eps ex06.eps ex08.eps \
  ex09.eps ex10.eps ex11.eps ex12.eps ex15.eps ex16.eps ex17.eps ex18.eps \
  ex21.eps exp.eps fet.eps Flow.eps Fuses.eps \
  Geometry.eps GrayCode.eps graysurf.eps Grounds.eps \
  Headers.eps Heathkit.eps \
  I2L.eps Incleps.eps Inductors.eps Jack.eps \
  lcct.eps Logic.eps Loglog.eps MC.eps Mixer.eps MoreTable.eps \
  MotorControl.eps Multiplexer.eps \
  NLG.eps NPDT.eps Nport.eps Opamp.eps Optoiso.eps \
  Pconn.eps Plate.eps PushPull.eps pwrsupply.eps \
  Quantum.eps quick.eps \
  random.eps Rectifiers.eps recycle.eps relaycoil.eps Relay.eps \
  Resistors.eps Rotbox.eps \
  Schottky.eps sfg.eps shapes.eps ShiftR.eps Sierpinski.eps Sixpole.eps \
  Smithchart.eps Sources.eps SQUID.eps Switches.eps \
  Tgate.eps Three.eps thyristor.eps TTLnand.eps Tubediags.eps \
  UNO.eps ujt.eps Variable.eps Windings.eps worm.eps Xform.eps XOR.eps \
  rose.eps

LOCALFIGS = ex21

# Files using boxdims macros:
BOXDIMS = ex09 Crow Incleps Loglog TTLnand Opamp Btree Windings

# It is advisable to do `make clean' between test examples.
#---------------------------------------------

DPIC = dpic
# DPIC = $$HOME/dpic/test/dpic
# DPIC = $$HOME/dpic/build/p2c/ftp/dpic

TR = | tr '=' '\134'

LATEX = latex --quiet

DIMFILE = tmp.dim

.SUFFIXES: .tex .m4 .eps .ps
.tex.ps:
	$(LATEX) $*
	dvips -Ppdf $*

.m4.eps:
	touch $(DIMFILE)
	$(M4) $(M4MACROS) $(DIMFILE) $*.m4 > $*.pic
	$(DPIC) -f $*.pic > $*.eps
#	$(M4) $(M4MACROS) $(DIMFILE) $*.m4 | $(DPIC) -f >> $*.eps

$(DOC).ps: $(DOC).dvi
	dvips -Ppdf $(DOC)

$(DOC).dvi: $(DOC).tex
	-if test "$(DOC)"="examplespsfrag" ; then make exlinks ;\
    $(MKDIM) $(TR) > setdim.tex; fi
	make $(FIGS) Incl.eps
	$(LATEX) $(DOC)
	-if test -n "$(BOXDIMS)" ; then \
       for box in $(BOXDIMS) ; do rm -f $$box.eps; make $$box.eps ; done; \
       $(LATEX) $(DOC); fi
	-if test -n "$(BOXDIMS)" ; then \
       for box in $(BOXDIMS) ; do rm -f $$box.eps; make $$box.eps ; done; \
       $(LATEX) $(DOC); fi

Incl.eps: ../Incl.eps.gz
	rm -f Incl.eps.gz
	cp ../Incl.eps.gz .
	gunzip Incl.eps.gz

figs: exlinks $(FIGS)

exlinks:
	@echo ""
	@echo 'Ignore "cannot create ... exists" warnings.'
	-@if test ! -f ex11.m4 ; then \
      ls ../*.m4 | sed -e 's/^/ln -s /' -e '/test.m4/d' | sh;\
      ls ../../doc/*.m4 ../*.bb ../*.gz | sed -e 's/^/ln -s /' | sh;\
      fi
	touch exlinks
#	for file in $(LOCALFIGS); do cp $${file}PSF.m4 $${file}.m4 ; done

clobber: clean
	rm -f $(DOC).ps test.m4

tst: tstpsfrag.ps

tstpsfrag.ps: tstpsfrag.dvi
	dvips tstpsfrag

tstpsfrag.dvi: test.eps
	$(LATEX) tstpsfrag

test.eps: test.pic
	$(DPIC) -f test.pic > test.eps

test.pic: test.m4 testlinks
	$(M4) $(M4MACROS) test.m4 > test.pic
	$(DPIC) -f test.pic > test.eps
	$(LATEX) tstpsfrag
	touch tstpsfrag.dim
	$(M4) $(M4MACROS) tstpsfrag.dim test.m4 > test.pic

testlinks:
	-for file in ics.m4 FlowchartDefs.m4 ; do ln -s ../$$file ; done
	touch testlinks

clean:
	@printf "\n psfrag clean:\n"
	rm -f stamp-* $(FIGS) *.dvi *.bb *.gz tstpsfrag.ps *.out *.pfg Incl.eps
	-if /usr/bin/test -f exlinks ; then \
     ls -l *.m4 | grep '\->' | \
       sed -e 's/^.* \([^ ][^ ]*\) ->.*$$/rm -f \1/' | sh; rm -f exlinks ; fi
	-if /usr/bin/test -f testlinks ; then \
     ls -l *.m4 | grep '\->' | \
       sed -e 's/^.* \([^ ][^ ]*\) ->.*$$/rm -f \1/' | sh; rm -f testlinks ; fi
	rm -f FlowchartDefs.m4 ics.m4
	for file in $(LOCALFIGS); do rm -f $${file}.m4 ; done
	rm -f *.log *.ps *.aux *.mp *.[0-9] *.[0-9][0-9] *.mpx *.eps *.dim *.pic
	rm -f core log mpxerr* *links figs.* *.dim dims F_test.* setdim.tex
	rm -f man[0-9]*.pic man[0-9]*.m4 figs.m4 test.1 test.mp test.pic test.tex
	-if test -n "$(BOXDIMS)" ; then for box in $(BOXDIMS) ; do \
      rm -f F_$$box.tex $$box.tex ; done; fi
	@printf "\n"
