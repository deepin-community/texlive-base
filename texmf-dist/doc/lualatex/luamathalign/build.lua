module = "luamathalign"
typesetexe = "lualatex"
tdsroot = "lualatex"
checkengines = {"luatex"}
unpackfiles = {"*.dtx"}
installfiles = {"*.sty", "*.lua"}
sourcefiles = {"*.dtx", "*.lua"}

uploadconfig = {
  pkg = "luamathalign",
  version = "v0.3",
  author = "Marcel Krüger",
  license = "lppl1.3c",
  summary = "More flexible alignment in amsmath environments",
  ctanPath = "/macros/luatex/latex/luamathalign/",
  -- repository = "https://github.com/zauguin/luamathalign/"
  description = "Allow aligning mathematical expressions on points where \z
    where direcly using &amp; is not possible, especially in nested macros or environments.",
  topic = {'maths', 'luatex'},
  -- update = true,
}
