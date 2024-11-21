--
--  longmath-doc.lua is part of longmath version 1.0. 
--
--  (c) 2024 Hans-Jürgen Matschull
--
--  This work may be distributed and/or modified under the
--  conditions of the LaTeX Project Public License, either version 1.3
--  of this license or (at your option) any later version.
--  The latest version of this license is in
--    http://www.latex-project.org/lppl.txt
--  and version 1.3 or later is part of all distributions of LaTeX
--  version 2005/12/01 or later.
-- 
--  This work has the LPPL maintenance status 'maintained'.
--  
--  The Current Maintainer of this work is Hans-Jürgen Matschull
-- 
--  see README for a list of files belonging to longmath.
--

local match = unicode.utf8.match
local gsub = unicode.utf8.gsub
local find = unicode.utf8.find

local nixpatt = { 
  { n = 'newl', p = '\n' }, 
  { n = 'text', p = '[^\n]*' }, 
}

local texpatt = {
  { n = 'group', p = '%b{}' }, 
  { n = 'math', p = '%(%)' }, 
  { n = 'defn', p = '\\newcount\\[%w@]+' },
  { n = 'defn', p = '\\newdimen\\[%w@]+' },
  { n = 'defn', p = '\\def\\[%w@]+' },
  { n = 'expl', p = '%%%%%%[^\n]*' },
  { n = 'expl', p = '%&%&%&[^\n]*' },
  { n = 'comm', p = '%%[^\n]*' },
  { n = 'oper', p = '[#]+%d' },
  { n = 'macro', p = '\\[%w@]+' },
  { n = 'punc', p = '\\%W' },
  { n = 'newl', p = '\n' },
  { n = 'space', p = '[ ]+' }, 
  { n = 'inter', p = "»[^«]*«" },
  { n = 'text', p = '[%w@_….,;:~?!\'€∞]+' }, 
  { n = 'math', p = '[-+/^=≠<>≤≥·×÷≈"]+' },
  { n = 'open', p = '[%[%(%{]' },
  { n = 'close', p = '[%]%)%}]' },
  { n = 'punc', p = '[%%&$#*|`\']' },
}


local function write( item, d ) 
  if item.n == 'open' then item.n = 'group' if d < 9 then d = d + 1 end end 
  if item.n == 'close' then if d > 0 then d = d - 1 end item.n = 'group' end 
  if item.n == 'newl' then 
    tex.sprint( '\\\\\\strut' )
  elseif item.n == 'expl' then 
    local t = item.p 
    t = gsub( t, '%%%%%%','' )
    t = gsub( t, '%-%-%-', '' )
    t = gsub( t, '%&%&%&', '' )
    tex.sprint( '\\rlap{\\textrm{'..t..'}}' )
  elseif item.n == 'inter' then 
    tex.sprint( ( item.p:gsub( '«', '' ):gsub( '»', '' ) ) )
  else
    local ex = string.explode( item.p, ' ' )
    tex.sprint( '\\textcolor{code' .. item.n .. '}{' )
    for i, t in ipairs( ex ) do 
      if i > 1 then tex.sprint( '{ }' ) end 
      t = t:gsub( '\\%<', '\\{' ):gsub( '\\%>', '\\}' ):gsub( '«', '' ):gsub( '»', '' )
      tex.write( t ) 
    end
    tex.sprint( '}' )
  end
  return d 
end

local function nsplit( code ) 
  local list1 = {}
  while code ~= '' do 
    local a, b 
    for _, p in ipairs( nixpatt ) do 
      a, b = match( code, '^(' .. p.p .. ')(.*)$' )
      if a and b then table.insert( list1, { n = p.n, p = a } ); code = b; break end
    end
    if not a then table.insert( list1, { n = 'rest', p = code } ); code = '' end 
  end
  return list1
end
                
local function tsplit( code )
  local list1 = {}
  while code ~= '' do 
    local a, b 
    for _, p in ipairs( texpatt ) do 
      a, b = match( code, '^(' .. p.p .. ')(.*)$' )
      if a and b then table.insert( list1, { n = p.n, p = a } ); code = b; break end
    end
    if not a then table.insert( list1, { n = 'rest', p = code } ); code = '' end 
  end
  local list2 = {}
  local lgrp = 0 
  local isub 
  for _, item in ipairs( list1 ) do 
    if item.n == 'luap' then 
      table.insert( list2, { n = 'macro', p = '\\begin' } )
      table.insert( list2, { n = 'open', p = '{' } )
      table.insert( list2, { n = 'luac', p = 'luap' } )
      table.insert( list2, { n = 'close', p = '}' } )
      isub = lsplit( item.p:gsub( '\\begin{luap}', '' ):gsub( '\\end{luap}', '' ) )
      for _, i in ipairs( isub ) do table.insert( list2, i ) end 
      table.insert( list2, { n = 'macro', p = '\\end' } )
      table.insert( list2, { n = 'open', p = '{' } )
      table.insert( list2, { n = 'luac', p = 'luap' } )
      table.insert( list2, { n = 'close', p = '}' } )
    elseif item.n == 'group' then 
      local a, b = item.p:sub( 1, 1 ), item.p:sub( -1, -1 )
      if lgrp > 0 then 
        item = lsplit( item.p:sub( 2, -2 ) )
        lgrp = lgrp - 1
      else
        item = tsplit( item.p:sub( 2, -2 ) ) 
      end
      table.insert( list2, { n = 'open', p = a } )
      for _, i in ipairs( item ) do table.insert( list2, i ) end 
      table.insert( list2, { n = 'close', p = b } )
    elseif item.n == 'macro' then 
      local lc = item.p:sub( 2 )
      table.insert( list2, item )
    elseif item.n == 'space' then 
      table.insert( list2, item )
    else 
      table.insert( list2, item )
    end
  end
  return list2 
end

local codelist = {}

local function readcode( env ) 
  local name = string.format( '\\end{%s}', env )
  local patt = name:gsub( '(%W)', '%%%1' )
  local typ, line 
  local lines, len, spc = {}, 0, 1000  
  while true do
    line = token.scan_word()
    if type( line ) == 'string' then 
      local a, b = line:find( patt )
      if a and b then break end
      line = line:gsub( '\\%.[%[%s%w%]]*$', '' ):gsub( '\\%.', '\\\\' )
      line = line:gsub( '%s*$', '' )
      local stub = line:gsub( '%%%%%%.*$', '' ):gsub( '%-%-%-.*$', '' )
      if not typ and stub:match( '[^\\]\\%w' ) then typ = tsplit end
      len = math.max( len, unicode.utf8.len( stub:gsub( '»[^«]*«', '' ) ) )
      spc = math.min( spc, line:find( '%S' ) or 1000 )
      table.insert( lines, line )
    else
      token.get_next()
      table.insert( lines, '' )
    end
  end  
  local code = ''
  for _, line in ipairs( lines ) do code = code .. line:sub( spc ) .. '\n' end
  code = code:gsub( '\\(%W)', '°%1' ):gsub( '°}', '°>' ):gsub( '°{', '°<' ):gsub( '°', '\\' ):gsub( '\n$', '' )
  tex.setdimen( 'global', 'codesize', ( len - spc + 1.5 ) * tex.dimen.ttwidth )
  codelist = ( typ or lsplit )( code )
  tex.sprint( tex.count['longmathdoc@ccnum@'], '\\endgroup' )
  tex.sprint( name ) 
end

local function writecode()
  local dep = 0 
  tex.sprint( '\\strut' )
  for _, item in ipairs( codelist ) do dep = write( item, dep ) end 
end

local dummy 
local function readstring() 
  dummy = string.explode( token.scan_string() ) 
end 
local function writestring() 
  for i, c in ipairs( dummy ) do 
    if i > 1 then tex.sprint( '~' ) end 
    tex.sprint( '\\verbC{' ) tex.write( c ) tex.sprint( '}' ) 
  end
end 

return { readcode = readcode, writecode = writecode, 
         readstring = readstring, writestring = writestring }

