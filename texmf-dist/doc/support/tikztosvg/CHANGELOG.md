# CHANGELOG

## Release 0.3.0

* Made the TeX engine configurable via command-line flags (see the updated
  manpage)
* Made LuaTeX the default TeX engine (the previous one was XeTeX)
* Removed runtime checks for dependencies
* Removed the install shell script from the repo

## Release 0.2.1

* Fixed #1
* Improved the installation scripts
* Added additional links in the documentation

## Release 0.2.0

* Removed code that added the `\huge` command to the beginning of the document
* Added an option for importing TikZ libraries (the `-l` option)
* Made it so that items from the `-p` and `-l` options aren't imported twice
* Made it so that tikz, tikz-cd, pgfplots, amsmath and amssymb are imported by
  default
* Added instructions for installing the application with Git

## Release 0.1.2

* The script is now posix-complient (it doesn't use bash anymore)
* Messages in the log output are now color-coded
* The script now support `stdin` input and `stdout` output
* The documentation is now rendered to PDF
* The documentation was updated
