# $Id: Makefile 813 2019-01-28 00:04:18Z karl $
# Public domain.

include ../Common.mak

default: test-omitcharset

test-omitcharset:
	# by default, CharSet is included.
	$(prog) test-omitcharset.tex
	grep "/CharSet" test-omitcharset.pdf >/dev/null
	#
	# force CharSet to be omitted.
	$(prog) '\pdfomitcharset=1 \input test-omitcharset.tex'
	! grep "/CharSet" test-omitcharset.pdf >/dev/null

clean:
	$(clean)
