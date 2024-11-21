#
#
LIBDIR = $$HOME/lib
M4LIBS = svg.m4 DPVconfig.m4
M4LIBS = svg.m4
M4 = m4
PDFCONVERT = pdf2svg
# The current dvisvgm outputs CRLF line endings
# PDFCONVERT = dvisvgm

# To process a single file, copy it to test.m4 and type "make tst"
# to produce tstDPV.html

DPIC = dpic
#DPIC = $$HOME/dpic/pascal/p2c/ftp/dpic
#DPIC = ../dpic/pascal/p2c/ftp/dpic
#DPIC = ../dpic/bison/dpic
#DPIC = ../dpic/bi*dev/dpic

# Quiet mode for MiKTeX or texlive
# QLATEX = latex --quiet
QLATEX = latex -interaction=batchmode

# To test the Windows executable.  Change these as needed for the operating
# system.  NOTE: cscDPV.m4 and Connectors.m4 use awk and sed which
# do not work at present with the Windows version.
# M4LIBS = svg.m4 windows.m4
# DPIC = ../dpic/bison/distsrc/Windows/dpic

.SUFFIXES: .pic .svg .m4 .xsvg
.pic.svg:
	$(DPIC) -v $*.pic > $*.svg
#	grep '<\!-- width' $*.svg | sed -e 's%<\!-- *%%' -e 's% *-->%%' > $*.siz
.m4.svg:
	m4 $(M4LIBS) $*.m4 | sed -e '/^\%/d' | $(DPIC) -v > $*.svg
#	m4 $(M4LIBS) $*.m4 | sed -e '/^\%/d' > $*.pic
#	$(DPIC) -v $*.pic > $*.svg
.m4.xsvg:
	touch F_$*.dim
	$(M4) pgf.m4 F_$*.dim $*.m4 > $*.pic
	$(DPIC) -g $*.pic >> $*.tex
#	echo "\documentclass[crop,tikz,multi=false]{standalone}" > F_$*.tex
	echo "\documentclass[tikz]{standalone}" > F_$*.tex
	echo "\usepackage{boxdims,siunitx,amssymb}" >> F_$*.tex
	echo "\begin{document}" >> F_$*.tex
	echo "\input $*.tex" >> F_$*.tex
	echo "\end{document}" >> F_$*.tex
	pdf$(QLATEX) F_$*
	$(M4) pgf.m4 F_$*.dim $*.m4 > $*.pic
	$(DPIC) -g $*.pic >> $*.tex
	pdf$(QLATEX) F_$*
	if test "$(PDFCONVERT)" = "pdf2svg" ; then \
      echo "Using pdf2svg" ; \
      pdf2svg F_$*.pdf $*.xsvg && cat $*.xsvg | tr -d '\r' > $*.svg ; \
    else \
      echo "Using dvisvgm" ; \
      dvisvgm --pdf F_$*.pdf && cat F_$**.svg | tr -d '\r' > $*.svg ; \
      cp $*.svg $*.xsvg ; \
      fi
	rm -f F_$**

CCTDPV = \
 AdderDPV.svg AlogixDPV.svg ABlogixDPV.svg AmpTableDPV.svg AntennasDPV.svg \
 ArrestersDPV.svg AudioDPV.svg \
 BipDPV.svg BtreeDPV.svg ByteDPV.svg ButtonsDPV.svg \
 CanLogicDPV.svg CapacitorsDPV.svg ChipsDPV.svg ConnDPV.svg ConnectorsDPV.svg \
 ContactDPV.svg ContactsDPV.svg \
 CrowDPV.svg CsourceDPV.svg \
 DecoderDPV.svg DemultiplexerDPV.svg DiniDPV.svg DiodesDPV.svg DriveDPV.svg \
 EEPDPV.svg EmarrowsDPV.svg EscherDPV.svg EVplugsDPV.svg \
 FlowDPV.svg FontsDPV.svg FusesDPV.svg \
 GeometryDPV.svg GrayCodeDPV.svg GroundsDPV.svg \
 HeadersDPV.svg HeathkitDPV.svg \
 InclepsDPV.svg InductorsDPV.svg I2LDPV.svg JackDPV.svg \
 LogicDPV.svg LoglogDPV.svg \
 MCDPV.svg MixerDPV.svg MoreTableDPV.svg MotorControlDPV.svg \
 MultiplexerDPV.svg \
 NLGDPV.svg NPDTDPV.svg NportDPV.svg OpampDPV.svg OptoisoDPV.svg \
 PconnDPV.svg PlateDPV.svg PushPullDPV.svg QuantumDPV.svg \
 RectifiersDPV.svg RelayDPV.svg ResistorsDPV.svg RotboxDPV.svg\
 SchottkyDPV.svg SevensegmentDPV.svg ShiftRDPV.svg SierpinskiDPV.svg \
 SixpoleDPV.svg SourcesDPV.svg Spec555DPV.svg SwitchesDPV.svg \
 TTLnandDPV.svg TgateDPV.svg ThreeDPV.svg \
 TubediagsDPV.svg VariableDPV.svg WindingsDPV.svg XformDPV.svg \
 cbresistorDPV.svg controlDPV.svg cscDPV.svg diamondDPV.svg \
 ex01DPV.svg ex02DPV.svg ex03DPV.svg ex04DPV.svg ex05DPV.svg ex06DPV.svg \
 ex08DPV.svg ex09DPV.svg ex10DPV.svg ex11DPV.svg ex12DPV.svg \
 ex15DPV.svg ex16DPV.svg ex18DPV.svg ex21DPV.svg \
 expDPV.svg fetDPV.svg graysurfDPV.svg keyboardDPV.svg lcctDPV.svg \
 pwrsupplyDPV.svg quickDPV.svg randomDPV.svg recycleDPV.svg relaycoilDPV.svg \
 roseDPV.svg sfgDPV.svg shapesDPV.svg SmithchartDPV.svg paletteDPV.svg \
 thyristorDPV.svg ujtDPV.svg UNODPV.svg wormDPV.svg XORDPV.svg Np.svg

TEXTFREE = \
 DiniDPV.svg DriveDPV.svg EscherDPV.svg SierpinskiDPV.svg SixpoleDPV.svg \
 diamondDPV.svg ex02DPV.svg ex15DPV.svg pwrsupplyDPV.svg recycleDPV.svg \
 roseDPV.svg

CCTDPVs = \
 ByteDPV.svg ConnectorsDPV.svg controlDPV.svg CsourceDPV.svg \
 EEPDPV.svg ex01DPV.svg FlowDPV.svg HeathkitDPV.svg \
   quickDPV.svg NportDPV.svg

examplesDPV.html: examplesDPV.htmx
	cp ../quick.m4 .
	make $(CCTDPV) quick.xsvg
	Version=`sed -e 's/Version //' $(LIBDIR)/doc/Version.tex` ; \
      sed -e 's/Version XXX/Version '$$Version'/' examplesDPV.htmx \
      | m4 > examplesDPV.html
	rm -f quick.xsvg

examplesDPVs.html: examplesDPVs.htmx
	cp ../quick.m4 .
	make $(CCTDPVs) quick.xsvg
	Version=`sed -e 's/Version //' $(LIBDIR)/doc/Version.tex` ; \
      sed -e 's/Version XXX/Version '$$Version'/' examplesDPVs.htmx \
      | m4 > examplesDPVs.html

SED = sed -e '/^\%/d'
TEST = test
tst:
	@if test -f test.pic; then printf "\n\nUsage: make clean tst\n\n"; exit 1;fi
	m4 $(M4LIBS) test.m4 | $(SED) > test.pic
	$(DPIC) -v $(TEST).pic > $(TEST).svg
	m4 $(M4LIBS) $(TEST).m4 | $(SED) > $(TEST).pic
	$(DPIC) -v $(TEST).pic > $(TEST).svg
#	grep '<\!-- width' $(TEST).svg | sed -e 's%<\!-- *%%' -e 's% *-->%%' \
#    > $(TEST).siz
	make tstDPV.html

test.pic:
	if test -f test.pic ; then echo "Usage: make clean tst" ; fi
	m4 $(M4LIBS) test.m4 | $(SED) > test.pic
	m4 $(M4LIBS) test.m4 | $(SED) > test.pic

tstDPV.html: tstDPV.htmx $(TEST).svg
	Version=`sed -e 's/Version //' $(LIBDIR)/doc/Version.tex` ; \
      sed -e 's/Version XXX/Version '$$Version'/' \
          -e 's/XXXXX/'$(TEST)'/g' \
      tstDPV.htmx | m4 > tstDPV.html
#	cp tstDPV.html $(TEST) $$HOME/public_html/svg

echospics:
	@echo $(CCTDPVs)

# necessary because of rotated text:
LoglogDPV.svg:
	m4 $(M4LIBS) $*.m4 | sed -e '/^\%/d' > $*.pic
	$(DPIC) -v $*.pic > $*.svg
	m4 $(M4LIBS) $*.m4 | sed -e '/^\%/d' > $*.pic
	$(DPIC) -v $*.pic > $*.svg
#	grep '<\!-- width' $*.svg | sed -e 's%<\!-- *%%' -e 's% *-->%%' > $*.siz

ConnectorsDPV.svg cscDPV.svg SmithchartDPV.svg test.svg:
	m4 $(M4LIBS) $*.m4 | sed -e '/^\%/d' > $*.pic
	$(DPIC) -v $*.pic > $*.svg
	m4 $(M4LIBS) $*.m4 | sed -e '/^\%/d' > $*.pic
	$(DPIC) -v $*.pic > $*.svg
#	grep '<\!-- width' $*.svg | sed -e 's%<\!-- *%%' -e 's% *-->%%' > $*.siz

InclepsDPV.svg: InclepsDPV.m4
	m4 $(M4LIBS) $*.m4 | sed -e '/^\%/d' > $*.pic
	$(DPIC) -v $*.pic > $*.svg
	$(DPIC) -v $*.pic > $*.svg

Incleps.png:
	(cd ..; make Incleps.png); cp ../Incleps.png .

clean:
	@printf "\n svg clean:\n"
	rm -f *.svg *.dim *.ps *log *.siz *.pic Incleps.png examplesDP*.html
	rm -f tstDPV.html copy_tmp__ quick.m4 quick.xsvg
	rm -f *.otf xx* *png *.pdf *.css *.xml quick.tex
	@printf "\n"

clobber: clean
	rm -f test.m4
