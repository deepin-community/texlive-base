-- ideavault-lua.lua
-- Copyright 2024 Tomasz M. Czarkowski
--
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either version 1.3c
-- of this license or any later version.
-- The latest version of this license is in
--   https://www.latex-project.org/lppl.txt
-- and version 1.3c or later is part of all distributions of LaTeX
-- version 2008 or later.
--
-- This work has the LPPL maintenance status `maintained'.
--
-- The Current Maintainer of this work is Tomasz M. Czarkowski
--
-- This work consists of the files ideavault.sty and ideavault-lua.lua


logErrorEnabled = true
logWarnEnabled = true
logDebugEnabled = false

function logError(message)
  if (logErrorEnabled) then
    texio.write_nl("[ERROR] " .. message)
  end
end

function logWarn(message)
  if (logWarnEnabled) then
    texio.write_nl("[WARN] " .. message)
  end
end

function logDebug(message)
  if (logDebugEnabled) then
    texio.write_nl("[DEBUG] " .. message)
  end
end

IdeaVaultClass = {}
IdeaVaultClass.__index = IdeaVaultClass

setmetatable(IdeaVaultClass, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function IdeaVaultClass.new()
  local self = setmetatable({}, IdeaVaultClass)
  self.all = {}
  return self
end

function IdeaVaultClass:addPrefix(prefix)
  if (self.all[prefix] == nil)
  then
    self.all[prefix] = {}
  end
end

function IdeaVaultClass:set(prefix, key, value)
  self:addPrefix(prefix)
  self.all[prefix][key] = value
end

function IdeaVaultClass:contains(prefix, key)
  if (self.all[prefix] == nil or self.all[prefix][key] == nil)
  then
    return false
  end
  return true
end

function IdeaVaultClass:get(prefix, key)
  if (self.all[prefix] == nil)
  then
    die("Prefix: '" .. prefix .. "' does not exist!")
  end
  if (self.all[prefix][key] == nil)
  then
    die("Key: '" .. key .. "' not found in prefix: '" .. prefix .. "'!")
  end

  return self.all[prefix][key]
end

function IdeaVaultClass:getAllWithPrefix(prefix)
  ideas = {}
  pr = self.all[prefix]
  for _, value in pairs(pr)
  do
    table.insert(ideas, value)
  end
  table.sort(ideas, function(a,b)
    if b:isGreaterThan(a) then return true end
  end)
  return ideas
end

function IdeaVaultClass:getAllWithTag(prefix, tag)
  ideas = {}
  pr = self.all[prefix]
  for _, value in pairs(pr)
  do
    if (value:hasTag(tag))
    then
      table.insert(ideas, value)
    end
  end
  table.sort(ideas, function(a,b)
    if b:isGreaterThan(a) then return true end
  end)
  return ideas
end

function IdeaVaultClass:printIdea(prefix, key, style)
  idea = self:get(prefix, key)
  idea:printSelf(style)
end

function IdeaVaultClass:printAllWithTag(prefix, tag, style)
  ideas = self:getAllWithTag(prefix, tag)
  for _, idea in ipairs(ideas)
  do
    idea:printSelf(style)
  end
end

function IdeaVaultClass:printAllWithPrefix(prefix, style)
  ideas = self:getAllWithPrefix(prefix)
  for _, idea in ipairs(ideas)
  do
    idea:printSelf(style)
  end
end

IdeaClass = {}
IdeaClass.__index = IdeaClass

setmetatable(IdeaClass, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function IdeaClass.new(title, content, dependencies, tags, value)
  local self = setmetatable({}, IdeaClass)
  self.title = title
  self.content = content
  self.dependencies = dependencies or {}
  self.tags = tags or {}
  self.value = value or 0
  return self
end

function IdeaClass:getTitle()
  return self.title
end

function IdeaClass:getContent()
  return self.content
end

function IdeaClass:getTags()
  return self.tags
end

function IdeaClass:getDependencies()
  return self.dependencies
end

function IdeaClass:getValue()
  return self.value
end

function IdeaClass:isGreaterThan(idea)
  if self:getValue() > idea:getValue()
  then
    return true
  else
    if self:getValue() == idea:getValue()
    then
      if self:getTitle() > idea:getTitle()
      then
        return true
      else
        return false
      end
    else
      return false
    end
  end
end

function IdeaClass:hasTag(tag)
  for _, value in pairs(self:getTags())
  do
    if (value == tag)
    then
      return true
    end
  end
  return false
end

bookmark_counter = 0

function IdeaClass:printSelf(style)
  style = style or ""
  logDebug("Printing idea. Title: '" .. self:getTitle() .. "', style: '" .. style .. "'.\n")
  
  local frame = false
  local center = false
  local bookmark = false
  local large = false
  local Large = false
  local huge = false
  local Huge = false
  local needSpace = false
  local emph = false
  local quiet = false
  local preNewPage = false
  local postNewPage = false
  for c in style:gmatch"."
  do
    if (c == "f") then 
      frame = true 
    elseif (c == "c") then 
      center = true 
    elseif (c == "b") then 
      bookmark = true 
    elseif (c == "l") then 
      large = true
    elseif (c == "L") then
      Large = true
    elseif (c == "h") then
      huge = true
    elseif (c == "H") then
      Huge = true
    elseif (c == "s") then 
      needSpace = true 
    elseif (c == "e") then 
      emph = true 
    elseif (c == "q") then 
      quiet = true
    elseif (c == "p") then
      preNewPage = true
    elseif (c == "P") then
      postNewPage = true
    else
      die("Unknown style: '" .. c .. "'")
    end
  end
  if (preNewPage)
  then
    tex.sprint("\\newpage%")
  end
  if (needSpace) 
  then
    tex.sprint("\\needspace{5cm}%")
  end
  if (bookmark) 
  then
    tex.sprint("\\hypertarget{" .. bookmark_counter .. "}{}%")
    tex.sprint("\\bookmark[dest=" .. bookmark_counter .. ", level=\\bookDepth]{" .. self:getTitle() .. "}%")
    --tex.sprint("\\subpdfbookmark{" .. self:getTitle() .. "}{" .. bookmark_counter .. "}%")
    bookmark_counter = bookmark_counter + 1
    tex.sprint("\\bookDown%")
  end
  if (frame) 
  then
    tex.sprint("\\begin{mdframed}%")
  end
  if (center) 
  then
    tex.sprint("\\begin{center}%")
  end
  if (not quiet)
  then
    tex.sprint("{%")
    if (large) 
    then
      tex.sprint("\\Large%")
    end
    if (Large)
    then
      tex.sprint("\\LARGE%")
    end
    if (huge)
    then
      tex.sprint("\\huge%")
    end
    if (Huge)
    then
      tex.sprint("\\Huge%")
    end
    if (emph) 
    then
      tex.sprint("\\emph{,,")
    end
    tex.sprint(self:getTitle())
    tex.sprint("\\nopagebreak%")
    if (emph) 
    then
      tex.sprint("''}%")
    end
    tex.sprint("}%")
  end
  if (center) 
  then
    tex.sprint("\\end{center}%")
  end
  tex.sprint(self:getContent() .. "%")
  if (not quiet)
  then
    self:printDependencies()
  end
  if (frame) 
  then
    tex.sprint("\\end{mdframed}%")
  end
  if (bookmark) 
  then
    tex.sprint("\\bookUp%")
  end
  if (postNewPage)
  then
    tex.sprint("\\newpage%")
  end
end

function IdeaClass:printDependencies()
  for _, dependency in ipairs(self:getDependencies())
  do
    dependency:resolve():printSelf("lcf")
  end
end

DependencyClass = {}
DependencyClass.__index = DependencyClass

setmetatable(DependencyClass, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function DependencyClass.new(prefix, title)
  local self = setmetatable({}, DependencyClass)
  self.prefix = prefix or "default"
  self.title = title or ""
  if (not ideaVault:contains(self.prefix, self.title))
  then
    die("Broken dependency! Title: '" .. self.title .. "'. Prefix: '" .. self.prefix .. "'.")
  end
  return self
end

function DependencyClass:getPrefix()
  return self.prefix
end

function DependencyClass:getTitle()
  return self.title
end

function DependencyClass:resolve()
  return ideaVault:get(self:getPrefix(), self:getTitle())
end

function DependencyClass:isGreaterThan(idea)
  if self:getTitle() > idea:getTitle()
  then
    return true
  else
    return false
  end
end
ideaVault = IdeaVaultClass()

function createIdea(prefix, key, content, dependencies, tags, value)
  t = "["
  for _, a in pairs(tags)
  do
    t = t .. a .. ", "
  end
  t = t .. "]"
  logDebug("Creating idea. Title: '" .. key .. "'. Prefix: '" .. prefix .. "', tags: " .. t .. ".\n")
  deps = {}
  for _, val in pairs(dependencies)
  do
    d = DependencyClass(val[1], val[2])
    table.insert(deps, d)
  end
  table.sort(deps, function(a,b)
    if b:isGreaterThan(a) then return true end
  end)
  idea = IdeaClass(key, content, deps, tags, value)
  ideaVault:set(prefix, key, idea)
end

function die(reason)
  reason = reason or "nil"
  logError("Critical error: " .. reason)
  tex.error("Critical error: " .. reason)
end

function startsWith(text, prefix)
    return text:find(prefix, 1, true) == 1
end
