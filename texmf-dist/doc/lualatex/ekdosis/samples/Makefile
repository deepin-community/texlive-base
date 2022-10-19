SHELL = bash
CMP   = lualatex-dev
PWD   = $(shell pwd)

exts := .tex .pdf -tei.xml
texsamples := $(basename $(wildcard $(PWD)/*.tex))
findopts := $(foreach ext,$(exts),-or -iname "*$(ext)")

define dosamples
	$(CMP) --shell-escape $1 >/dev/null
	$(CMP) --shell-escape $1 >/dev/null
	$(CMP) --shell-escape $1 >/dev/null
	$(CMP) --shell-escape $1 >/dev/null
endef

all: test
	cp ../ekdosis.{lua,sty} .
	$(foreach file,$(texsamples), $(call dosamples, $(file)))
	rm -rf auto
	find -iname "*~" -or -iname "*_out*.tex" | xargs rm -rf
	find ./* -type f -iname "Makefile" $(findopts) > ls-R
	rsync -aPr --files-from=ls-R . .backup
	rm -rf *
	cp -p -r .backup/* .
	rm -rf .backup

test:
	if [ ! -e ../ekdosis.sty ] || [ ! -e ../ekdosis.lua ] ;\
	then echo "This Makefile cannot be invoked but recursively. Aborting." && exit 1 ;\
	fi

.SILENT: test
.PHONY: all
