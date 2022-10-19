.PHONY: package install

BIN_TARGET ?= /usr/bin/
MAN_TARGET ?= /usr/share/man/man1/

# Packages the application for CTAN
package: tikztosvg.tar.gz

install: man/tikztosvg.1 tikztosvg
	# Install the executable
	install -g 0 -o 0 -m 755 tikztosvg "$(BIN_TARGET)"
	 
	# Install the manpage
	install -g 0 -o 0 -m 644 man/tikztosvg.1 "$(MAN_TARGET)"

man/tikztosvg.1: man/man.adoc
	asciidoctor -b manpage -o $@ $^

tikztosvg.pdf: README.md 
	pandoc -s -o $@ $^

example/%.svg: example/%.tikz
	sh ./tikztosvg -p xfrac -p relsize -o $@ $^
	
	# Try to compress the image with svgo
	svgo --pretty $@ || exit 0

# Packages the application for CTAN
tikztosvg.tar.gz: tikztosvg man/tikztosvg.1 tikztosvg.pdf README.md example/example.tikz example/example.svg CHANGELOG.md LICENSE
	tar -cvO --directory=.. --exclude='.*' --exclude='*.tar.gz' tikztosvg \
		| gzip -c /dev/stdin > tikztosvg.tar.gz

