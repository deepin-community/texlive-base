--
-- This is file `pgfmolbio.lua',
-- generated with the docstrip utility.
--
-- The original source files were:
--
-- pgfmolbio.dtx  (with options: `pgfmolbio-lua')
--
-- Copyright (C) 2024 by Wolfgang Esser-Skala
--
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either version 1.3c
-- of this license or (at your option) any later version.
-- The latest version of this license is in
--   https://www.latex-project.org/lppl.txt
-- and version 1.3c or later is part of all distributions of LaTeX
-- version 2008/05/04 or later.
--
module("pgfmolbio", package.seeall)


if luatexbase then
  luatexbase.provides_module({
    name          = "pgfmolbio",
    version       = "0.21a",
    date          = "2014/06/17",
    description   = "Molecular biology graphs wit LuaLaTeX",
    author        = "Wolfgang Esser-Skala",
    copyright     = "Wolfgang Esser-Skala",
    license       = "LPPL",
  })
end

local coordUnit, coordFmtStr

function setCoordinateFormat(unit, fmtString)
  coordUnit = unit
  coordFmtStr = fmtString
end

function stringToDim(x)
  if type(x) == "string" then
    return dimen(x)[1]
  end
end

function dimToString(x)
  return number.todimen(x, coordUnit, coordFmtStr)
end

function getRange(rangeInput, ...)
  if type(rangeInput) ~= "string" then return end
  local result = {}
  local matchStrings = table.pack(...)
  for i = 1, matchStrings.n do
    if type(matchStrings[i]) == "string" then
      table.insert(result, rangeInput:match(matchStrings[i]))
    end
  end
  return unpack(result)
end

function packageWarning(message)
  tex.sprint("\\PackageWarning{pgfmolbio}{" .. message .. "}")
end

function packageError(message)
  tex.error("Package pgfmolbio Error: " .. message)
  errorCatched = true
end

errorCatched = false

if not string.trim then
  string.trim = function(self)
    return self:match("^%s*(.-)%s*$")
  end
end

outputFileId = 0
--
-- End of file `pgfmolbio.lua'.
