# README for LUAHTTP
Version 1.0.1

## INTRODUCTION
This is a small package that provides five commands to make HTTP requests using Lua and LuaTeX. Functionalities include API calls, fetching RSS feeds and the possibility to include images using a link. These commands run during the compilation of the PDF-Document and may require user interaction.

This packages requires LuaTeX, Lua5.3, expat, openssl and the following Lua modules called "rocks":

* luasec
* dkjson
* ltn12
* feedparser
* luaexpat

## MANUAL INSTALLATION
First the required dependencies need to be installed:

Arch:
```
lua53 luarocks expat openssl
```

Debian:
```
liblua5.3-dev libssl-dev lua5.3 libexpat1-dev luarocks
```

MacOS:
```
lua@5.3 luarocks expat openssl
```

The Lua rocks can be installed locally using ```luarocks```. To install the Lua rocks locally we need to initialize the directory where the ```.tex``` file(s) is located. In the directory execute the following commands to initialize a new Lua project and install the required dependencies:

```bash
luarocks init --lua-version=5.3
luarocks install dkjson --lua-version=5.3
luarocks install luasec --lua-version=5.3
luarocks install ltn12 --lua-version=5.3
luarocks install luaexpat --lua-version=5.3
luarocks install feedparser --lua-version=5.3
```

For **MacOS** it may be necessary to add Lua 5.3 to your "$PATH" and install **luaexpat** and **luasec** using the commands bellow:
```bash
echo 'export PATH="/usr/local/opt/lua@5.3/bin:$PATH"' >> ~/.zshrc
luarocks install luaexpat EXPAT_DIR=/usr/local/Cellar/expat/${YOUR_VERSION_HERE}
luarocks install luasec OPENSSL_DIR=/usr/local/Cellar/openssl@3/${YOUR_VERSION_HERE}
```

## USAGE
Compilation requires the use of ```lualatex``` with the ```--shell-escape``` option.

```
lualatex --shell-escape
```

Add the package to your TeX file:
```
\usepackage{luahttp}
```

Here is a quick overview of the commands and their parameters. For further details and examples please read the package documentation.

* fetchJson, send a GET request and filter the response using optional keys:
    ```tex
    \fetchJson{URL}[optional: "key1,key2,.."]
    ```

* fetchJsonUsingFile, send a request specified in a JSON-file and filter the response using optional keys:
    ```tex
    \fetchJsonUsingFile{Path to JSON-file}[optional: "key1,key2,.."]
    ```

* fetchJsonUsingQuery, send a POST request with up to five query parameters and filter the response using keys:
    ```tex
    \fetchJsonUsingQuery{URL}{"key1,key2,.."} [optional: "?queryparameter1=value1"] .. [optional: "&queryparameter5=value5"]
    ```

* fetchRss, send a GET request and filter the feed and entries (limited by the second argument) using optional keys:
    ```tex
    \fetchRss{URL}{limit}[optional: "feedinfokey1,feedinfokey2,.."][optional: "entrykey1,entrykey2,.."]
    ```

* fetchImage, fetch an image from the internet and specify the width and height in **cm** using optional arguments:
    ```tex
    \fetchImage{URL}[optional: width in cm][optional: height in cm]
    ```


## AUTHOR / MAINTAINER

* Johannes Casaburi (johannes.casaburi@protonmail.com)

## LICENSE

LATEX Project Public License, version 1.3c or later.

## KNOWN PROBLEMS
* Not all URL leading to an image are detected
* Results that where filtered using keys may not be displayed in the order of the given keys.

