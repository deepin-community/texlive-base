-- 
--  This is file `luamplib.lua',
--  generated with the docstrip utility.
-- 
--  The original source files were:
-- 
--  luamplib.dtx  (with options: `lua')
--  
--  See source file 'luamplib.dtx' for licencing and contact information.
--  

luatexbase.provides_module {
  name          = "luamplib",
  version       = "2.35.0",
  date          = "2024/11/12",
  description   = "Lua package to typeset Metapost with LuaTeX's MPLib.",
}

luamplib          = luamplib or { }
local luamplib    = luamplib

local format, abs = string.format, math.abs

local function termorlog (target, text, kind)
  if text then
    local mod, write, append = "luamplib", texio.write_nl, texio.write
    kind = kind
        or target == "term" and "Warning (more info in the log)"
        or target == "log" and "Info"
        or target == "term and log" and "Warning"
        or "Error"
    target = kind == "Error" and "term and log" or target
    local t = text:explode"\n+"
    write(target, format("Module %s %s:", mod, kind))
    if #t == 1 then
      append(target, format(" %s", t[1]))
    else
      for _,line in ipairs(t) do
        write(target, line)
      end
      write(target, format("(%s)     ", mod))
    end
    append(target, format(" on input line %s", tex.inputlineno))
    write(target, "")
    if kind == "Error" then error() end
  end
end
local function warn (...) -- beware '%' symbol
  termorlog("term and log", select("#",...) > 1 and format(...) or ...)
end
local function info (...)
  termorlog("log", select("#",...) > 1 and format(...) or ...)
end
local function err (...)
  termorlog("error", select("#",...) > 1 and format(...) or ...)
end

luamplib.showlog  = luamplib.showlog or false

local tableconcat = table.concat
local tableinsert = table.insert
local tableunpack = table.unpack
local texsprint   = tex.sprint
local texgettoks  = tex.gettoks
local texgetbox   = tex.getbox
local texruntoks  = tex.runtoks
if not texruntoks then
  err("Your LuaTeX version is too old. Please upgrade it to the latest")
end
local is_defined  = token.is_defined
local get_macro   = token.get_macro
local mplib = require ('mplib')
local kpse  = require ('kpse')
local lfs   = require ('lfs')
local lfsattributes = lfs.attributes
local lfsisdir      = lfs.isdir
local lfsmkdir      = lfs.mkdir
local lfstouch      = lfs.touch
local ioopen        = io.open

local file = file or { }
local replacesuffix = file.replacesuffix or function(filename, suffix)
  return (filename:gsub("%.[%a%d]+$","")) .. "." .. suffix
end
local is_writable = file.is_writable or function(name)
  if lfsisdir(name) then
    name = name .. "/_luam_plib_temp_file_"
    local fh = ioopen(name,"w")
    if fh then
      fh:close(); os.remove(name)
      return true
    end
  end
end
local mk_full_path = lfs.mkdirp or lfs.mkdirs or function(path)
  local full = ""
  for sub in path:gmatch("(/*[^\\/]+)") do
    full = full .. sub
    lfsmkdir(full)
  end
end

local luamplibtime = lfsattributes(kpse.find_file"luamplib.lua", "modification")
local currenttime = os.time()
local outputdir, cachedir
if lfstouch then
  for i,v in ipairs{'TEXMFVAR','TEXMF_OUTPUT_DIRECTORY','.','TEXMFOUTPUT'} do
    local var = i == 3 and v or kpse.var_value(v)
    if var and var ~= "" then
      for _,vv in next, var:explode(os.type == "unix" and ":" or ";") do
        local dir = format("%s/%s",vv,"luamplib_cache")
        if not lfsisdir(dir) then
          mk_full_path(dir)
        end
        if is_writable(dir) then
          outputdir = dir
          break
        end
      end
      if outputdir then break end
    end
  end
end
outputdir = outputdir or '.'
function luamplib.getcachedir(dir)
  dir = dir:gsub("##","#")
  dir = dir:gsub("^~",
    os.type == "windows" and os.getenv("UserProfile") or os.getenv("HOME"))
  if lfstouch and dir then
    if lfsisdir(dir) then
      if is_writable(dir) then
        cachedir = dir
      else
        warn("Directory '%s' is not writable!", dir)
      end
    else
      warn("Directory '%s' does not exist!", dir)
    end
  end
end
local noneedtoreplace = {
  ["boxes.mp"] = true, --  ["format.mp"] = true,
  ["graph.mp"] = true, ["marith.mp"] = true, ["mfplain.mp"] = true,
  ["mpost.mp"] = true, ["plain.mp"] = true, ["rboxes.mp"] = true,
  ["sarith.mp"] = true, ["string.mp"] = true, -- ["TEX.mp"] = true,
  ["metafun.mp"] = true, ["metafun.mpiv"] = true, ["mp-abck.mpiv"] = true,
  ["mp-apos.mpiv"] = true, ["mp-asnc.mpiv"] = true, ["mp-bare.mpiv"] = true,
  ["mp-base.mpiv"] = true, ["mp-blob.mpiv"] = true, ["mp-butt.mpiv"] = true,
  ["mp-char.mpiv"] = true, ["mp-chem.mpiv"] = true, ["mp-core.mpiv"] = true,
  ["mp-crop.mpiv"] = true, ["mp-figs.mpiv"] = true, ["mp-form.mpiv"] = true,
  ["mp-func.mpiv"] = true, ["mp-grap.mpiv"] = true, ["mp-grid.mpiv"] = true,
  ["mp-grph.mpiv"] = true, ["mp-idea.mpiv"] = true, ["mp-luas.mpiv"] = true,
  ["mp-mlib.mpiv"] = true, ["mp-node.mpiv"] = true, ["mp-page.mpiv"] = true,
  ["mp-shap.mpiv"] = true, ["mp-step.mpiv"] = true, ["mp-text.mpiv"] = true,
  ["mp-tool.mpiv"] = true, ["mp-cont.mpiv"] = true,
}
luamplib.noneedtoreplace = noneedtoreplace
local function replaceformatmp(file,newfile,ofmodify)
  local fh = ioopen(file,"r")
  if not fh then return file end
  local data = fh:read("*all"); fh:close()
  fh = ioopen(newfile,"w")
  if not fh then return file end
  fh:write(
    "let normalinfont = infont;\n",
    "primarydef str infont name = rawtextext(str) enddef;\n",
    data,
    "vardef Fmant_(expr x) = rawtextext(decimal abs x) enddef;\n",
    "vardef Fexp_(expr x) = rawtextext(\"$^{\"&decimal x&\"}$\") enddef;\n",
    "let infont = normalinfont;\n"
  ); fh:close()
  lfstouch(newfile,currenttime,ofmodify)
  return newfile
end
local name_b = "%f[%a_]"
local name_e = "%f[^%a_]"
local btex_etex = name_b.."btex"..name_e.."%s*(.-)%s*"..name_b.."etex"..name_e
local verbatimtex_etex = name_b.."verbatimtex"..name_e.."%s*(.-)%s*"..name_b.."etex"..name_e
local function replaceinputmpfile (name,file)
  local ofmodify = lfsattributes(file,"modification")
  if not ofmodify then return file end
  local newfile = name:gsub("%W","_")
  newfile = format("%s/luamplib_input_%s", cachedir or outputdir, newfile)
  if newfile and luamplibtime then
    local nf = lfsattributes(newfile)
    if nf and nf.mode == "file" and
      ofmodify == nf.modification and luamplibtime < nf.access then
      return nf.size == 0 and file or newfile
    end
  end
  if name == "format.mp" then return replaceformatmp(file,newfile,ofmodify) end
  local fh = ioopen(file,"r")
  if not fh then return file end
  local data = fh:read("*all"); fh:close()
  local count,cnt = 0,0
  data, cnt = data:gsub(btex_etex, "btex %1 etex ") -- space
  count = count + cnt
  data, cnt = data:gsub(verbatimtex_etex, "verbatimtex %1 etex;") -- semicolon
  count = count + cnt
  if count == 0 then
    noneedtoreplace[name] = true
    fh = ioopen(newfile,"w");
    if fh then
      fh:close()
      lfstouch(newfile,currenttime,ofmodify)
    end
    return file
  end
  fh = ioopen(newfile,"w")
  if not fh then return file end
  fh:write(data); fh:close()
  lfstouch(newfile,currenttime,ofmodify)
  return newfile
end

local mpkpse
do
  local exe = 0
  while arg[exe-1] do
    exe = exe-1
  end
  mpkpse = kpse.new(arg[exe], "mpost")
end
local special_ftype = {
  pfb = "type1 fonts",
  enc = "enc files",
}
function luamplib.finder (name, mode, ftype)
  if mode == "w" then
    if name and name ~= "mpout.log" then
      kpse.record_output_file(name) -- recorder
    end
    return name
  else
    ftype = special_ftype[ftype] or ftype
    local file = mpkpse:find_file(name,ftype)
    if file then
      if lfstouch and ftype == "mp" and not noneedtoreplace[name] then
        file = replaceinputmpfile(name,file)
      end
    else
      file = mpkpse:find_file(name, name:match("%a+$"))
    end
    if file then
      kpse.record_input_file(file) -- recorder
    end
    return file
  end
end

local preamble = [[
  boolean mplib ; mplib := true ;
  let dump = endinput ;
  let normalfontsize = fontsize;
  input %s ;
]]
local currentformat = "plain"
function luamplib.setformat (name)
  currentformat = name
end
luamplib.codeinherit = false
local mplibinstances = {}
luamplib.instances = mplibinstances
local has_instancename = false
local function reporterror (result, prevlog)
  if not result then
    err("no result object returned")
  else
    local t, e, l = result.term, result.error, result.log
    local log = l or t or "no-term"
    log = log:gsub("%(Please type a command or say `end'%)",""):gsub("\n+","\n")
    if result.status > 0 then
      local first = log:match"(.-\n! .-)\n! "
      if first then
        termorlog("term", first)
        termorlog("log", log, "Warning")
      else
        warn(log)
      end
      if result.status > 1 then
        err(e or "see above messages")
      end
    elseif prevlog then
      log = prevlog..log
      local show = log:match"\n>>? .+"
      if show then
        termorlog("term", show, "Info (more info in the log)")
        info(log)
      elseif luamplib.showlog and log:find"%g" then
        info(log)
      end
    end
    return log
  end
end
if not math.initialseed then math.randomseed(currenttime) end
local function luamplibload (name)
  local mpx = mplib.new {
    ini_version = true,
    find_file   = luamplib.finder,
    make_text   = luamplib.maketext,
    run_script  = luamplib.runscript,
    math_mode   = luamplib.numbersystem,
    job_name    = tex.jobname,
    random_seed = math.random(4095),
    extensions  = 1,
  }
  local preamble = tableconcat{
    format(preamble, replacesuffix(name,"mp")),
    luamplib.preambles.mplibcode,
    luamplib.legacyverbatimtex and luamplib.preambles.legacyverbatimtex or "",
    luamplib.textextlabel and luamplib.preambles.textextlabel or "",
  }
  local result, log
  if not mpx then
    result = { status = 99, error = "out of memory"}
  else
    result = mpx:execute(preamble)
  end
  log = reporterror(result)
  return mpx, result, log
end
local function process (data, instancename)
  local currfmt
  if instancename and instancename ~= "" then
    currfmt = instancename
    has_instancename = true
  else
    currfmt = tableconcat{
      currentformat,
      luamplib.numbersystem or "scaled",
      tostring(luamplib.textextlabel),
      tostring(luamplib.legacyverbatimtex),
    }
    has_instancename = false
  end
  local mpx = mplibinstances[currfmt]
  local standalone = not (has_instancename or luamplib.codeinherit)
  if mpx and standalone then
    mpx:finish()
  end
  local log = ""
  if standalone or not mpx then
    mpx, _, log = luamplibload(currentformat)
    mplibinstances[currfmt] = mpx
  end
  local converted, result = false, {}
  if mpx and data then
    result = mpx:execute(data)
    local log = reporterror(result, log)
    if log then
      if result.fig then
        converted = luamplib.convert(result)
      end
    end
  else
    err"Mem file unloadable. Maybe generated with a different version of mplib?"
  end
  return converted, result
end

local pdfmode = tex.outputmode > 0

local catlatex = luatexbase.registernumber("catcodetable@latex")
local catat11  = luatexbase.registernumber("catcodetable@atletter")
local function run_tex_code (str, cat)
  texruntoks(function() texsprint(cat or catlatex, str) end)
end
local texboxes = { globalid = 0, localid = 4096 }
local factor = 65536*(7227/7200)
local textext_fmt = 'image(addto currentpicture doublepath unitsquare \z
  xscaled %f yscaled %f shifted (0,-%f) \z
  withprescript "mplibtexboxid=%i:%f:%f")'
local function process_tex_text (str)
  if str then
    local global = (has_instancename or luamplib.globaltextext or luamplib.codeinherit)
                   and "\\global" or ""
    local tex_box_id
    if global == "" then
      tex_box_id = texboxes.localid + 1
      texboxes.localid = tex_box_id
    else
      local boxid = texboxes.globalid + 1
      texboxes.globalid = boxid
      run_tex_code(format([[\expandafter\newbox\csname luamplib.box.%s\endcsname]], boxid))
      tex_box_id = tex.getcount'allocationnumber'
    end
    run_tex_code(format("\\luamplibtagtextbegin{%i}%s\\setbox%i\\hbox{%s}\\luamplibtagtextend", tex_box_id, global, tex_box_id, str))
    local box = texgetbox(tex_box_id)
    local wd  = box.width  / factor
    local ht  = box.height / factor
    local dp  = box.depth  / factor
    return textext_fmt:format(wd, ht+dp, dp, tex_box_id, wd, ht+dp)
  end
  return ""
end

local mplibcolorfmt = {
  xcolor = tableconcat{
    [[\begingroup\let\XC@mcolor\relax]],
    [[\def\set@color{\global\mplibtmptoks\expandafter{\current@color}}]],
    [[\color%s\endgroup]],
  },
  l3color = tableconcat{
    [[\begingroup\def\__color_select:N#1{\expandafter\__color_select:nn#1}]],
    [[\def\__color_backend_select:nn#1#2{\global\mplibtmptoks{#1 #2}}]],
    [[\def\__kernel_backend_literal:e#1{\global\mplibtmptoks\expandafter{\expanded{#1}}}]],
    [[\color_select:n%s\endgroup]],
  },
}
local colfmt = is_defined'color_select:n' and "l3color" or "xcolor"
if colfmt == "l3color" then
  run_tex_code{
    "\\newcatcodetable\\luamplibcctabexplat",
    "\\begingroup",
    "\\catcode`@=11 ",
    "\\catcode`_=11 ",
    "\\catcode`:=11 ",
    "\\savecatcodetable\\luamplibcctabexplat",
    "\\endgroup",
  }
end
local ccexplat = luatexbase.registernumber"luamplibcctabexplat"
local function process_color (str)
  if str then
    if not str:find("%b{}") then
      str = format("{%s}",str)
    end
    local myfmt = mplibcolorfmt[colfmt]
    if colfmt == "l3color" and is_defined"color" then
      if str:find("%b[]") then
        myfmt = mplibcolorfmt.xcolor
      else
        for _,v in ipairs(str:match"{(.+)}":explode"!") do
          if not v:find("^%s*%d+%s*$") then
            local pp = get_macro(format("l__color_named_%s_prop",v))
            if not pp or pp == "" then
              myfmt = mplibcolorfmt.xcolor
              break
            end
          end
        end
      end
    end
    run_tex_code(myfmt:format(str), ccexplat or catat11)
    local t = texgettoks"mplibtmptoks"
    if not pdfmode and not t:find"^pdf" then
      t = t:gsub("%a+ (.+)","pdf:bc [%1]")
    end
    return format('1 withprescript "mpliboverridecolor=%s"', t)
  end
  return ""
end

local function process_dimen (str)
  if str then
    str = str:gsub("{(.+)}","%1")
    run_tex_code(format([[\mplibtmptoks\expandafter{\the\dimexpr %s\relax}]], str))
    return format("begingroup %s endgroup", texgettoks"mplibtmptoks")
  end
  return ""
end

local function process_verbatimtex_text (str)
  if str then
    run_tex_code(str)
  end
  return ""
end

local tex_code_pre_mplib = {}
luamplib.figid = 1
luamplib.in_the_fig = false
local function process_verbatimtex_prefig (str)
  if str then
    tex_code_pre_mplib[luamplib.figid] = str
  end
  return ""
end
local function process_verbatimtex_infig (str)
  if str then
    return format('special "postmplibverbtex=%s";', str)
  end
  return ""
end

local runscript_funcs = {
  luamplibtext    = process_tex_text,
  luamplibcolor   = process_color,
  luamplibdimen   = process_dimen,
  luamplibprefig  = process_verbatimtex_prefig,
  luamplibinfig   = process_verbatimtex_infig,
  luamplibverbtex = process_verbatimtex_text,
}

mp = mp or {}
local mp = mp
mp.mf_path_reset = mp.mf_path_reset or function() end
mp.mf_finish_saving_data = mp.mf_finish_saving_data or function() end
mp.report = mp.report or info
catcodes = catcodes or {}
local catcodes = catcodes
catcodes.numbers = catcodes.numbers or {}
catcodes.numbers.ctxcatcodes = catcodes.numbers.ctxcatcodes or catlatex
catcodes.numbers.texcatcodes = catcodes.numbers.texcatcodes or catlatex
catcodes.numbers.luacatcodes = catcodes.numbers.luacatcodes or catlatex
catcodes.numbers.notcatcodes = catcodes.numbers.notcatcodes or catlatex
catcodes.numbers.vrbcatcodes = catcodes.numbers.vrbcatcodes or catlatex
catcodes.numbers.prtcatcodes = catcodes.numbers.prtcatcodes or catlatex
catcodes.numbers.txtcatcodes = catcodes.numbers.txtcatcodes or catlatex

local function mpprint(buffer,...)
  for i=1,select("#",...) do
    local value = select(i,...)
    if value ~= nil then
      local t = type(value)
      if t == "number" then
        buffer[#buffer+1] = format("%.16f",value)
      elseif t == "string" then
        buffer[#buffer+1] = value
      elseif t == "table" then
        buffer[#buffer+1] = "(" .. tableconcat(value,",") .. ")"
      else -- boolean or whatever
        buffer[#buffer+1] = tostring(value)
      end
    end
  end
end
function luamplib.runscript (code)
  local id, str = code:match("(.-){(.*)}")
  if id and str then
    local f = runscript_funcs[id]
    if f then
      local t = f(str)
      if t then return t end
    end
  end
  local f = loadstring(code)
  if type(f) == "function" then
    local buffer = {}
    function mp.print(...)
      mpprint(buffer,...)
    end
    local res = {f()}
    buffer = tableconcat(buffer)
    if buffer and buffer ~= "" then
      return buffer
    end
    buffer = {}
    mpprint(buffer, tableunpack(res))
    return tableconcat(buffer)
  end
  return ""
end

local function protecttexcontents (str)
  return str:gsub("\\%%", "\0PerCent\0")
            :gsub("%%.-\n", "")
            :gsub("%%.-$",  "")
            :gsub("%zPerCent%z", "\\%%")
            :gsub("%s+", " ")
end
luamplib.legacyverbatimtex = true
function luamplib.maketext (str, what)
  if str and str ~= "" then
    str = protecttexcontents(str)
    if what == 1 then
      if not str:find("\\documentclass"..name_e) and
         not str:find("\\begin%s*{document}") and
         not str:find("\\documentstyle"..name_e) and
         not str:find("\\usepackage"..name_e) then
        if luamplib.legacyverbatimtex then
          if luamplib.in_the_fig then
            return process_verbatimtex_infig(str)
          else
            return process_verbatimtex_prefig(str)
          end
        else
          return process_verbatimtex_text(str)
        end
      end
    else
      return process_tex_text(str)
    end
  end
  return ""
end

local function colorsplit (res)
  local t, tt = { }, res:gsub("[%[%]]","",2):explode()
  local be = tt[1]:find"^%d" and 1 or 2
  for i=be, #tt do
    if not tonumber(tt[i]) then break end
    t[#t+1] = tt[i]
  end
  return t
end

luamplib.gettexcolor = function (str, rgb)
  local res = process_color(str):match'"mpliboverridecolor=(.+)"'
  if res:find" cs " or res:find"@pdf.obj" then
    if not rgb then
      warn("%s is a spot color. Forced to CMYK", str)
    end
    run_tex_code({
      "\\color_export:nnN{",
      str,
      "}{",
      rgb and "space-sep-rgb" or "space-sep-cmyk",
      "}\\mplib_@tempa",
    },ccexplat)
    return get_macro"mplib_@tempa":explode()
  end
  local t = colorsplit(res)
  if #t == 3 or not rgb then return t end
  if #t == 4 then
    return { 1 - math.min(1,t[1]+t[4]), 1 - math.min(1,t[2]+t[4]), 1 - math.min(1,t[3]+t[4]) }
  end
  return { t[1], t[1], t[1] }
end

luamplib.shadecolor = function (str)
  local res = process_color(str):match'"mpliboverridecolor=(.+)"'
  if res:find" cs " or res:find"@pdf.obj" then -- spot color shade: l3 only
    run_tex_code({
      [[\color_export:nnN{]], str, [[}{backend}\mplib_@tempa]],
    },ccexplat)
    local name, value = get_macro'mplib_@tempa':match'{(.-)}{(.-)}'
    local t, obj = res:explode()
    if pdfmode then
      obj = format("%s 0 R", ltx.pdf.object_id( t[1]:sub(2,-1) ))
    else
      obj = t[2]
    end
    return format('(1) withprescript"mplib_spotcolor=%s:%s:%s"', value,obj,name)
  end
  return colorsplit(res)
end

local decimals = "%.%d+"
local function rmzeros(str) return str:gsub("%.?0+$","") end

local emboldenfonts = { }
local function getemboldenwidth (curr, fakebold)
  local width = emboldenfonts.width
  if not width then
    local f
    local function getglyph(n)
      while n do
        if n.head then
          getglyph(n.head)
        elseif n.font and n.font > 0 then
          f = n.font; break
        end
        n = node.getnext(n)
      end
    end
    getglyph(curr)
    width = font.getcopy(f or font.current()).size * fakebold / factor * 10
    emboldenfonts.width = width
  end
  return width
end
local function getrulewhatsit (line, wd, ht, dp)
  line, wd, ht, dp = line/1000, wd/factor, ht/factor, dp/factor
  local pl
  local fmt = "%f w %f %f %f %f re %s"
  if pdfmode then
    pl = node.new("whatsit","pdf_literal")
    pl.mode = 0
  else
    fmt = "pdf:content "..fmt
    pl = node.new("whatsit","special")
  end
  pl.data = fmt:format(line, 0, -dp, wd, ht+dp, "B") :gsub(decimals,rmzeros)
  local ss = node.new"glue"
  node.setglue(ss, 0, 65536, 65536, 2, 2)
  pl.next = ss
  return pl
end
local function getrulemetric (box, curr, bp)
  local running = -1073741824
  local wd,ht,dp = curr.width, curr.height, curr.depth
  wd = wd == running and box.width  or wd
  ht = ht == running and box.height or ht
  dp = dp == running and box.depth  or dp
  if bp then
    return wd/factor, ht/factor, dp/factor
  end
  return wd, ht, dp
end
local function embolden (box, curr, fakebold)
  local head = curr
  while curr do
    if curr.head then
      curr.head = embolden(curr, curr.head, fakebold)
    elseif curr.replace then
      curr.replace = embolden(box, curr.replace, fakebold)
    elseif curr.leader then
      if curr.leader.head then
        curr.leader.head = embolden(curr.leader, curr.leader.head, fakebold)
      elseif curr.leader.id == node.id"rule" then
        local glue = node.effective_glue(curr, box)
        local line = getemboldenwidth(curr, fakebold)
        local wd,ht,dp = getrulemetric(box, curr.leader)
        if box.id == node.id"hlist" then
          wd = glue
        else
          ht, dp = 0, glue
        end
        local pl = getrulewhatsit(line, wd, ht, dp)
        local pack = box.id == node.id"hlist" and node.hpack or node.vpack
        local list = pack(pl, glue, "exactly")
        head = node.insert_after(head, curr, list)
        head, curr = node.remove(head, curr)
      end
    elseif curr.id == node.id"rule" and curr.subtype == 0 then
      local line = getemboldenwidth(curr, fakebold)
      local wd,ht,dp = getrulemetric(box, curr)
      if box.id == node.id"vlist" then
        ht, dp = 0, ht+dp
      end
      local pl = getrulewhatsit(line, wd, ht, dp)
      local list
      if box.id == node.id"hlist" then
        list = node.hpack(pl, wd, "exactly")
      else
        list = node.vpack(pl, ht+dp, "exactly")
      end
      head = node.insert_after(head, curr, list)
      head, curr = node.remove(head, curr)
    elseif curr.id == node.id"glyph" and curr.font > 0 then
      local f = curr.font
      local key = format("%s:%s",f,fakebold)
      local i = emboldenfonts[key]
      if not i then
        local ft = font.getfont(f) or font.getcopy(f)
        if pdfmode then
          width = ft.size * fakebold / factor * 10
          emboldenfonts.width = width
          ft.mode, ft.width = 2, width
          i = font.define(ft)
        else
          if ft.format ~= "opentype" and ft.format ~= "truetype" then
            goto skip_type1
          end
          local name = ft.name:gsub('"',''):gsub(';$','')
          name = format('%s;embolden=%s;',name,fakebold)
          _, i = fonts.constructors.readanddefine(name,ft.size)
        end
        emboldenfonts[key] = i
      end
      curr.font = i
    end
    ::skip_type1::
    curr = node.getnext(curr)
  end
  return head
end
local function graphictextcolor (col, filldraw)
  if col:find"^[%d%.:]+$" then
    col = col:explode":"
    for i=1,#col do
      col[i] = format("%.3f", col[i])
    end
    if pdfmode then
      local op = #col == 4 and "k" or #col == 3 and "rg" or "g"
      col[#col+1] = filldraw == "fill" and op or op:upper()
      return tableconcat(col," ")
    end
    return format("[%s]", tableconcat(col," "))
  end
  col = process_color(col):match'"mpliboverridecolor=(.+)"'
  if pdfmode then
    local t, tt = col:explode(), { }
    local b = filldraw == "fill" and 1 or #t/2+1
    local e = b == 1 and #t/2 or #t
    for i=b,e do
      tt[#tt+1] = t[i]
    end
    return tableconcat(tt," ")
  end
  return col:gsub("^.- ","")
end
luamplib.graphictext = function (text, fakebold, fc, dc)
  local fmt = process_tex_text(text):sub(1,-2)
  local id = tonumber(fmt:match"mplibtexboxid=(%d+):")
  emboldenfonts.width = nil
  local box = texgetbox(id)
  box.head = embolden(box, box.head, fakebold)
  local fill = graphictextcolor(fc,"fill")
  local draw = graphictextcolor(dc,"draw")
  local bc = pdfmode and "" or "pdf:bc "
  return format('%s withprescript "mpliboverridecolor=%s%s %s")', fmt, bc, fill, draw)
end

local function mperr (str)
  return format("hide(errmessage %q)", str)
end
local function getangle (a,b,c)
  local r = math.deg(math.atan(c.y-b.y, c.x-b.x) - math.atan(b.y-a.y, b.x-a.x))
  if r > 180 then
    r = r - 360
  elseif r < -180 then
    r = r + 360
  end
  return r
end
local function turning (t)
  local r, n = 0, #t
  for i=1,2 do
    tableinsert(t, t[i])
  end
  for i=1,n do
    r = r + getangle(t[i], t[i+1], t[i+2])
  end
  return r/360
end
local function glyphimage(t, fmt)
  local q,p,r = {{},{}}
  for i,v in ipairs(t) do
    local cmd = v[#v]
    if cmd == "m" then
      p = {format('(%s,%s)',v[1],v[2])}
      r = {{x=v[1],y=v[2]}}
    else
      local nt = t[i+1]
      local last = not nt or nt[#nt] == "m"
      if cmd == "l" then
        local pt = t[i-1]
        local seco = pt[#pt] == "m"
        if (last or seco) and r[1].x == v[1] and r[1].y == v[2] then
        else
          tableinsert(p, format('--(%s,%s)',v[1],v[2]))
          tableinsert(r, {x=v[1],y=v[2]})
        end
        if last then
          tableinsert(p, '--cycle')
        end
      elseif cmd == "c" then
        tableinsert(p, format('..controls(%s,%s)and(%s,%s)',v[1],v[2],v[3],v[4]))
        if last and r[1].x == v[5] and r[1].y == v[6] then
          tableinsert(p, '..cycle')
        else
          tableinsert(p, format('..(%s,%s)',v[5],v[6]))
          if last then
            tableinsert(p, '--cycle')
          end
          tableinsert(r, {x=v[5],y=v[6]})
        end
      else
        return mperr"unknown operator"
      end
      if last then
        tableinsert(q[ turning(r) > 0 and 1 or 2 ], tableconcat(p))
      end
    end
  end
  r = { }
  if fmt == "opentype" then
    for _,v in ipairs(q[1]) do
      tableinsert(r, format('addto currentpicture contour %s;',v))
    end
    for _,v in ipairs(q[2]) do
      tableinsert(r, format('addto currentpicture contour %s withcolor background;',v))
    end
  else
    for _,v in ipairs(q[2]) do
      tableinsert(r, format('addto currentpicture contour %s;',v))
    end
    for _,v in ipairs(q[1]) do
      tableinsert(r, format('addto currentpicture contour %s withcolor background;',v))
    end
  end
  return format('image(%s)', tableconcat(r))
end
if not table.tofile then require"lualibs-lpeg"; require"lualibs-table"; end
function luamplib.glyph (f, c)
  local filename, subfont, instance, kind, shapedata
  local fid = tonumber(f) or font.id(f)
  if fid > 0 then
    local fontdata = font.getfont(fid) or font.getcopy(fid)
    filename, subfont, kind = fontdata.filename, fontdata.subfont, fontdata.format
    instance = fontdata.specification and fontdata.specification.instance
    filename = filename and filename:gsub("^harfloaded:","")
  else
    local name
    f = f:match"^%s*(.+)%s*$"
    name, subfont, instance = f:match"(.+)%((%d+)%)%[(.-)%]$"
    if not name then
      name, instance = f:match"(.+)%[(.-)%]$" -- SourceHanSansK-VF.otf[Heavy]
    end
    if not name then
      name, subfont = f:match"(.+)%((%d+)%)$" -- Times.ttc(2)
    end
    name = name or f
    subfont = (subfont or 0)+1
    instance = instance and instance:lower()
    for _,ftype in ipairs{"opentype", "truetype"} do
      filename = kpse.find_file(name, ftype.." fonts")
      if filename then
        kind = ftype; break
      end
    end
  end
  if kind ~= "opentype" and kind ~= "truetype" then
    f = fid and fid > 0 and tex.fontname(fid) or f
    if kpse.find_file(f, "tfm") then
      return format("glyph %s of %q", tonumber(c) or format("%q",c), f)
    else
      return mperr"font not found"
    end
  end
  local time = lfsattributes(filename,"modification")
  local k = format("shapes_%s(%s)[%s]", filename, subfont or "", instance or "")
  local h = format(string.rep('%02x', 256/8), string.byte(sha2.digest256(k), 1, -1))
  local newname = format("%s/%s.lua", cachedir or outputdir, h)
  local newtime = lfsattributes(newname,"modification") or 0
  if time == newtime then
    shapedata = require(newname)
  end
  if not shapedata then
    shapedata = fonts and fonts.handlers.otf.readers.loadshapes(filename,subfont,instance)
    if not shapedata then return mperr"loadshapes() failed. luaotfload not loaded?" end
    table.tofile(newname, shapedata, "return")
    lfstouch(newname, time, time)
  end
  local gid = tonumber(c)
  if not gid then
    local uni = utf8.codepoint(c)
    for i,v in pairs(shapedata.glyphs) do
      if c == v.name or uni == v.unicode then
        gid = i; break
      end
    end
  end
  if not gid then return mperr"cannot get GID (glyph id)" end
  local fac = 1000 / (shapedata.units or 1000)
  local t = shapedata.glyphs[gid].segments
  if not t then return "image()" end
  for i,v in ipairs(t) do
    if type(v) == "table" then
      for ii,vv in ipairs(v) do
        if type(vv) == "number" then
          t[i][ii] = format("%.0f", vv * fac)
        end
      end
    end
  end
  kind = shapedata.format or kind
  return glyphimage(t, kind)
end

local rulefmt = "mpliboutlinepic[%i]:=image(addto currentpicture contour \z
  unitsquare shifted - center unitsquare;) xscaled %f yscaled %f shifted (%f,%f);"
local outline_horz, outline_vert
function outline_vert (res, box, curr, xshift, yshift)
  local b2u = box.dir == "LTL"
  local dy = (b2u and -box.depth or box.height)/factor
  local ody = dy
  while curr do
    if curr.id == node.id"rule" then
      local wd, ht, dp = getrulemetric(box, curr, true)
      local hd = ht + dp
      if hd ~= 0 then
        dy = dy + (b2u and dp or -ht)
        if wd ~= 0 and curr.subtype == 0 then
          res[#res+1] = rulefmt:format(#res+1, wd, hd, xshift+wd/2, yshift+dy+(ht-dp)/2)
        end
        dy = dy + (b2u and ht or -dp)
      end
    elseif curr.id == node.id"glue" then
      local vwidth = node.effective_glue(curr,box)/factor
      if curr.leader then
        local curr, kind = curr.leader, curr.subtype
        if curr.id == node.id"rule" then
          local wd = getrulemetric(box, curr, true)
          if wd ~= 0 then
            local hd = vwidth
            local dy = dy + (b2u and 0 or -hd)
            if hd ~= 0 and curr.subtype == 0 then
              res[#res+1] = rulefmt:format(#res+1, wd, hd, xshift+wd/2, yshift+dy+hd/2)
            end
          end
        elseif curr.head then
          local hd = (curr.height + curr.depth)/factor
          if hd <= vwidth then
            local dy, n, iy = dy, 0, 0
            if kind == 100 or kind == 103 then -- todo: gleaders
              local ady = abs(ody - dy)
              local ndy = math.ceil(ady / hd) * hd
              local diff = ndy - ady
              n = (vwidth-diff) // hd
              dy = dy + (b2u and diff or -diff)
            else
              n = vwidth // hd
              if kind == 101 then
                local side = vwidth % hd / 2
                dy = dy + (b2u and side or -side)
              elseif kind == 102 then
                iy = vwidth % hd / (n+1)
                dy = dy + (b2u and iy or -iy)
              end
            end
            dy = dy + (b2u and curr.depth or -curr.height)/factor
            hd = b2u and hd or -hd
            iy = b2u and iy or -iy
            local func = curr.id == node.id"hlist" and outline_horz or outline_vert
            for i=1,n do
              res = func(res, curr, curr.head, xshift+curr.shift/factor, yshift+dy)
              dy = dy + hd + iy
            end
          end
        end
      end
      dy = dy + (b2u and vwidth or -vwidth)
    elseif curr.id == node.id"kern" then
      dy = dy + curr.kern/factor * (b2u and 1 or -1)
    elseif curr.id == node.id"vlist" then
      dy = dy + (b2u and curr.depth or -curr.height)/factor
      res = outline_vert(res, curr, curr.head, xshift+curr.shift/factor, yshift+dy)
      dy = dy + (b2u and curr.height or -curr.depth)/factor
    elseif curr.id == node.id"hlist" then
      dy = dy + (b2u and curr.depth or -curr.height)/factor
      res = outline_horz(res, curr, curr.head, xshift+curr.shift/factor, yshift+dy)
      dy = dy + (b2u and curr.height or -curr.depth)/factor
    end
    curr = node.getnext(curr)
  end
  return res
end
function outline_horz (res, box, curr, xshift, yshift, discwd)
  local r2l = box.dir == "TRT"
  local dx = r2l and (discwd or box.width/factor) or 0
  local dirs = { { dir = r2l, dx = dx } }
  while curr do
    if curr.id == node.id"dir" then
      local sign, dir = curr.dir:match"(.)(...)"
      local level, newdir = curr.level, r2l
      if sign == "+" then
        newdir = dir == "TRT"
        if r2l ~= newdir then
          local n = node.getnext(curr)
          while n do
            if n.id == node.id"dir" and n.level+1 == level then break end
            n = node.getnext(n)
          end
          n = n or node.tail(curr)
          dx = dx + node.rangedimensions(box, curr, n)/factor * (newdir and 1 or -1)
        end
        dirs[level] = { dir = r2l, dx = dx }
      else
        local level = level + 1
        newdir = dirs[level].dir
        if r2l ~= newdir then
          dx = dirs[level].dx
        end
      end
      r2l = newdir
    elseif curr.char and curr.font and curr.font > 0 then
      local ft = font.getfont(curr.font) or font.getcopy(curr.font)
      local gid = ft.characters[curr.char].index or curr.char
      local scale = ft.size / factor / 1000
      local slant   = (ft.slant or 0)/1000
      local extend  = (ft.extend or 1000)/1000
      local squeeze = (ft.squeeze or 1000)/1000
      local expand  = 1 + (curr.expansion_factor or 0)/1000000
      local xscale = scale * extend * expand
      local yscale = scale * squeeze
      dx = dx - (r2l and curr.width/factor*expand or 0)
      local xpos = dx + xshift + (curr.xoffset or 0)/factor
      local ypos = yshift + (curr.yoffset or 0)/factor
      local vertical = ft.shared and ft.shared.features.vertical and "rotated 90" or ""
      if vertical ~= "" then -- luatexko
        for _,v in ipairs(ft.characters[curr.char].commands or { }) do
          if v[1] == "down" then
            ypos = ypos - v[2] / factor
          elseif v[1] == "right" then
            xpos = xpos + v[2] / factor
          else
            break
          end
        end
      end
      local image
      if ft.format == "opentype" or ft.format == "truetype" then
        image = luamplib.glyph(curr.font, gid)
      else
        local name, scale = ft.name, 1
        local vf = font.read_vf(name, ft.size)
        if vf and vf.characters[gid] then
          local cmds = vf.characters[gid].commands or {}
          for _,v in ipairs(cmds) do
            if v[1] == "char" then
              gid = v[2]
            elseif v[1] == "font" and vf.fonts[v[2]] then
              name  = vf.fonts[v[2]].name
              scale = vf.fonts[v[2]].size / ft.size
            end
          end
        end
        image = format("glyph %s of %q scaled %f", gid, name, scale)
      end
      res[#res+1] = format("mpliboutlinepic[%i]:=%s xscaled %f yscaled %f slanted %f %s shifted (%f,%f);",
                           #res+1, image, xscale, yscale, slant, vertical, xpos, ypos)
      dx = dx + (r2l and 0 or curr.width/factor*expand)
    elseif curr.replace then
      local width = node.dimensions(curr.replace)/factor
      dx = dx - (r2l and width or 0)
      res = outline_horz(res, box, curr.replace, xshift+dx, yshift, width)
      dx = dx + (r2l and 0 or width)
    elseif curr.id == node.id"rule" then
      local wd, ht, dp = getrulemetric(box, curr, true)
      if wd ~= 0 then
        local hd = ht + dp
        dx = dx - (r2l and wd or 0)
        if hd ~= 0 and curr.subtype == 0 then
          res[#res+1] = rulefmt:format(#res+1, wd, hd, xshift+dx+wd/2, yshift+(ht-dp)/2)
        end
        dx = dx + (r2l and 0 or wd)
      end
    elseif curr.id == node.id"glue" then
      local width = node.effective_glue(curr, box)/factor
      dx = dx - (r2l and width or 0)
      if curr.leader then
        local curr, kind = curr.leader, curr.subtype
        if curr.id == node.id"rule" then
          local wd, ht, dp = getrulemetric(box, curr, true)
          local hd = ht + dp
          if hd ~= 0 then
            wd = width
            if wd ~= 0 and curr.subtype == 0 then
              res[#res+1] = rulefmt:format(#res+1, wd, hd, xshift+dx+wd/2, yshift+(ht-dp)/2)
            end
          end
        elseif curr.head then
          local wd = curr.width/factor
          if wd <= width then
            local dx = r2l and dx+width or dx
            local n, ix = 0, 0
            if kind == 100 or kind == 103 then -- todo: gleaders
              local adx = abs(dx-dirs[1].dx)
              local ndx = math.ceil(adx / wd) * wd
              local diff = ndx - adx
              n = (width-diff) // wd
              dx = dx + (r2l and -diff-wd or diff)
            else
              n = width // wd
              if kind == 101 then
                local side = width % wd /2
                dx = dx + (r2l and -side-wd or side)
              elseif kind == 102 then
                ix = width % wd / (n+1)
                dx = dx + (r2l and -ix-wd or ix)
              end
            end
            wd = r2l and -wd or wd
            ix = r2l and -ix or ix
            local func = curr.id == node.id"hlist" and outline_horz or outline_vert
            for i=1,n do
              res = func(res, curr, curr.head, xshift+dx, yshift-curr.shift/factor)
              dx = dx + wd + ix
            end
          end
        end
      end
      dx = dx + (r2l and 0 or width)
    elseif curr.id == node.id"kern" then
      dx = dx + curr.kern/factor * (r2l and -1 or 1)
    elseif curr.id == node.id"math" then
      dx = dx + curr.surround/factor * (r2l and -1 or 1)
    elseif curr.id == node.id"vlist" then
      dx = dx - (r2l and curr.width/factor or 0)
      res = outline_vert(res, curr, curr.head, xshift+dx, yshift-curr.shift/factor)
      dx = dx + (r2l and 0 or curr.width/factor)
    elseif curr.id == node.id"hlist" then
      dx = dx - (r2l and curr.width/factor or 0)
      res = outline_horz(res, curr, curr.head, xshift+dx, yshift-curr.shift/factor)
      dx = dx + (r2l and 0 or curr.width/factor)
    end
    curr = node.getnext(curr)
  end
  return res
end
function luamplib.outlinetext (text)
  local fmt = process_tex_text(text)
  local id  = tonumber(fmt:match"mplibtexboxid=(%d+):")
  local box = texgetbox(id)
  local res = outline_horz({ }, box, box.head, 0, 0)
  if #res == 0 then res = { "mpliboutlinepic[1]:=image();" } end
  return tableconcat(res) .. format("mpliboutlinenum:=%i;", #res)
end

luamplib.preambles = {
  mplibcode = [[
texscriptmode := 2;
def rawtextext (expr t) = runscript("luamplibtext{"&t&"}") enddef;
def mplibcolor (expr t) = runscript("luamplibcolor{"&t&"}") enddef;
def mplibdimen (expr t) = runscript("luamplibdimen{"&t&"}") enddef;
def VerbatimTeX (expr t) = runscript("luamplibverbtex{"&t&"}") enddef;
if known context_mlib:
  defaultfont := "cmtt10";
  let infont = normalinfont;
  let fontsize = normalfontsize;
  vardef thelabel@#(expr p,z) =
    if string p :
      thelabel@#(p infont defaultfont scaled defaultscale,z)
    else :
      p shifted (z + labeloffset*mfun_laboff@# -
        (mfun_labxf@#*lrcorner p + mfun_labyf@#*ulcorner p +
        (1-mfun_labxf@#-mfun_labyf@#)*llcorner p))
    fi
  enddef;
else:
  vardef textext@# (text t) = rawtextext (t) enddef;
  def message expr t =
    if string t: runscript("mp.report[=["&t&"]=]") else: errmessage "Not a string" fi
  enddef;
fi
def resolvedcolor(expr s) =
  runscript("return luamplib.shadecolor('"& s &"')")
enddef;
def colordecimals primary c =
  if cmykcolor c:
    decimal cyanpart c & ":" & decimal magentapart c & ":" &
    decimal yellowpart c & ":" & decimal blackpart c
  elseif rgbcolor c:
    decimal redpart c & ":" & decimal greenpart c & ":" & decimal bluepart c
  elseif string c:
    if known graphictextpic: c else: colordecimals resolvedcolor(c) fi
  else:
    decimal c
  fi
enddef;
def externalfigure primary filename =
  draw rawtextext("\includegraphics{"& filename &"}")
enddef;
def TEX = textext enddef;
def mplibtexcolor primary c =
  runscript("return luamplib.gettexcolor('"& c &"')")
enddef;
def mplibrgbtexcolor primary c =
  runscript("return luamplib.gettexcolor('"& c &"','rgb')")
enddef;
def mplibgraphictext primary t =
  begingroup;
  mplibgraphictext_ (t)
enddef;
def mplibgraphictext_ (expr t) text rest =
  save fakebold, scale, fillcolor, drawcolor, withfillcolor, withdrawcolor,
    fb, fc, dc, graphictextpic;
  picture graphictextpic; graphictextpic := nullpicture;
  numeric fb; string fc, dc; fb:=2; fc:="white"; dc:="black";
  let scale = scaled;
  def fakebold  primary c = hide(fb:=c;) enddef;
  def fillcolor primary c = hide(fc:=colordecimals c;) enddef;
  def drawcolor primary c = hide(dc:=colordecimals c;) enddef;
  let withfillcolor = fillcolor; let withdrawcolor = drawcolor;
  addto graphictextpic doublepath origin rest; graphictextpic:=nullpicture;
  def fakebold  primary c = enddef;
  let fillcolor = fakebold; let drawcolor = fakebold;
  let withfillcolor = fillcolor; let withdrawcolor = drawcolor;
  image(draw runscript("return luamplib.graphictext([===["&t&"]===],"
    & decimal fb &",'"& fc &"','"& dc &"')") rest;)
  endgroup;
enddef;
def mplibglyph expr c of f =
  runscript (
    "return luamplib.glyph('"
    & if numeric f: decimal fi f
    & "','"
    & if numeric c: decimal fi c
    & "')"
  )
enddef;
def mplibdrawglyph expr g =
  draw image(
    save i; numeric i; i:=0;
    for item within g:
      i := i+1;
      fill pathpart item
      if i < length g: withpostscript "collect" fi;
    endfor
  )
enddef;
def mplib_do_outline_text_set_b (text f) (text d) text r =
  def mplib_do_outline_options_f = f enddef;
  def mplib_do_outline_options_d = d enddef;
  def mplib_do_outline_options_r = r enddef;
enddef;
def mplib_do_outline_text_set_f (text f) text r =
  def mplib_do_outline_options_f = f enddef;
  def mplib_do_outline_options_r = r enddef;
enddef;
def mplib_do_outline_text_set_u (text f) text r =
  def mplib_do_outline_options_f = f enddef;
enddef;
def mplib_do_outline_text_set_d (text d) text r =
  def mplib_do_outline_options_d = d enddef;
  def mplib_do_outline_options_r = r enddef;
enddef;
def mplib_do_outline_text_set_r (text d) (text f) text r =
  def mplib_do_outline_options_d = d enddef;
  def mplib_do_outline_options_f = f enddef;
  def mplib_do_outline_options_r = r enddef;
enddef;
def mplib_do_outline_text_set_n text r =
  def mplib_do_outline_options_r = r enddef;
enddef;
def mplib_do_outline_text_set_p = enddef;
def mplib_fill_outline_text =
  for n=1 upto mpliboutlinenum:
    i:=0;
    for item within mpliboutlinepic[n]:
      i:=i+1;
      fill pathpart item mplib_do_outline_options_f withpen pencircle scaled 0
      if (n<mpliboutlinenum) or (i<length mpliboutlinepic[n]): withpostscript "collect"; fi
    endfor
  endfor
enddef;
def mplib_draw_outline_text =
  for n=1 upto mpliboutlinenum:
    for item within mpliboutlinepic[n]:
      draw pathpart item mplib_do_outline_options_d;
    endfor
  endfor
enddef;
def mplib_filldraw_outline_text =
  for n=1 upto mpliboutlinenum:
    i:=0;
    for item within mpliboutlinepic[n]:
      i:=i+1;
      if (n<mpliboutlinenum) or (i<length mpliboutlinepic[n]):
        fill pathpart item mplib_do_outline_options_f withpostscript "collect";
      else:
        draw pathpart item mplib_do_outline_options_f withpostscript "both";
      fi
    endfor
  endfor
enddef;
vardef mpliboutlinetext@# (expr t) text rest =
  save kind; string kind; kind := str @#;
  save i; numeric i;
  picture mpliboutlinepic[]; numeric mpliboutlinenum;
  def mplib_do_outline_options_d = enddef;
  def mplib_do_outline_options_f = enddef;
  def mplib_do_outline_options_r = enddef;
  runscript("return luamplib.outlinetext[===["&t&"]===]");
  image ( addto currentpicture also image (
    if kind = "f":
      mplib_do_outline_text_set_f rest;
      mplib_fill_outline_text;
    elseif kind = "d":
      mplib_do_outline_text_set_d rest;
      mplib_draw_outline_text;
    elseif kind = "b":
      mplib_do_outline_text_set_b rest;
      mplib_fill_outline_text;
      mplib_draw_outline_text;
    elseif kind = "u":
      mplib_do_outline_text_set_u rest;
      mplib_filldraw_outline_text;
    elseif kind = "r":
      mplib_do_outline_text_set_r rest;
      mplib_draw_outline_text;
      mplib_fill_outline_text;
    elseif kind = "p":
      mplib_do_outline_text_set_p;
      mplib_draw_outline_text;
    else:
      mplib_do_outline_text_set_n rest;
      mplib_fill_outline_text;
    fi;
  ) mplib_do_outline_options_r; )
enddef ;
primarydef t withpattern p =
  image(
    if cycle t:
      fill
    else:
      draw
    fi
    t withprescript "mplibpattern=" & if numeric p: decimal fi p; )
enddef;
vardef mplibtransformmatrix (text e) =
  save t; transform t;
  t = identity e;
  runscript("luamplib.transformmatrix = {"
  & decimal xxpart t & ","
  & decimal yxpart t & ","
  & decimal xypart t & ","
  & decimal yypart t & ","
  & decimal xpart  t & ","
  & decimal ypart  t & ","
  & "}");
enddef;
primarydef p withfademethod s =
  if picture p:
    image(
      draw p;
      draw center p withprescript "mplibfadestate=stop";
    )
  else:
    p withprescript "mplibfadestate=stop"
  fi
    withprescript "mplibfadetype=" & s
    withprescript "mplibfadebbox=" &
      decimal (xpart llcorner p -1/4) & ":" &
      decimal (ypart llcorner p -1/4) & ":" &
      decimal (xpart urcorner p +1/4) & ":" &
      decimal (ypart urcorner p +1/4)
enddef;
def withfadeopacity (expr a,b) =
  withprescript "mplibfadeopacity=" &
    decimal a & ":" &
    decimal b
enddef;
def withfadevector (expr a,b) =
  withprescript "mplibfadevector=" &
    decimal xpart a & ":" &
    decimal ypart a & ":" &
    decimal xpart b & ":" &
    decimal ypart b
enddef;
let withfadecenter = withfadevector;
def withfaderadius (expr a,b) =
  withprescript "mplibfaderadius=" &
    decimal a & ":" &
    decimal b
enddef;
def withfadebbox (expr a,b) =
  withprescript "mplibfadebbox=" &
    decimal xpart a & ":" &
    decimal ypart a & ":" &
    decimal xpart b & ":" &
    decimal ypart b
enddef;
primarydef p asgroup s =
  image(
    draw center p
      withprescript "mplibgroupbbox=" &
        decimal (xpart llcorner p -1/4) & ":" &
        decimal (ypart llcorner p -1/4) & ":" &
        decimal (xpart urcorner p +1/4) & ":" &
        decimal (ypart urcorner p +1/4)
      withprescript "gr_state=start"
      withprescript "gr_type=" & s;
    draw p;
    draw center p withprescript "gr_state=stop";
  )
enddef;
def withgroupbbox (expr a,b) =
  withprescript "mplibgroupbbox=" &
    decimal xpart a & ":" &
    decimal ypart a & ":" &
    decimal xpart b & ":" &
    decimal ypart b
enddef;
def withgroupname expr s =
  withprescript "mplibgroupname=" & s
enddef;
def usemplibgroup primary s =
  draw maketext("\mplibnoforcehmode\csname luamplib.group." & s & "\endcsname")
    shifted runscript("return luamplib.trgroupshifts['" & s & "']")
enddef;
]],
  legacyverbatimtex = [[
def specialVerbatimTeX (text t) = runscript("luamplibprefig{"&t&"}") enddef;
def normalVerbatimTeX  (text t) = runscript("luamplibinfig{"&t&"}") enddef;
let VerbatimTeX = specialVerbatimTeX;
extra_beginfig := extra_beginfig & " let VerbatimTeX = normalVerbatimTeX;"&
  "runscript(" &ditto& "luamplib.in_the_fig=true" &ditto& ");";
extra_endfig := extra_endfig & " let VerbatimTeX = specialVerbatimTeX;"&
  "runscript(" &ditto&
  "if luamplib.in_the_fig then luamplib.figid=luamplib.figid+1 end "&
  "luamplib.in_the_fig=false" &ditto& ");";
]],
  textextlabel = [[
let luampliboriginalinfont = infont;
primarydef s infont f =
  if   (s < char 32)
    or (s = char 35) % #
    or (s = char 36) % $
    or (s = char 37) % %
    or (s = char 38) % &
    or (s = char 92) % \
    or (s = char 94) % ^
    or (s = char 95) % _
    or (s = char 123) % {
    or (s = char 125) % }
    or (s = char 126) % ~
    or (s = char 127) :
    s luampliboriginalinfont f
  else :
    rawtextext(s)
  fi
enddef;
def fontsize expr f =
  begingroup
  save size; numeric size;
  size := mplibdimen("1em");
  if size = 0: 10pt else: size fi
  endgroup
enddef;
]],
}

luamplib.verbatiminput = false
local function protect_expansion (str)
  if str then
    str = str:gsub("\\","!!!Control!!!")
             :gsub("%%","!!!Comment!!!")
             :gsub("#", "!!!HashSign!!!")
             :gsub("{", "!!!LBrace!!!")
             :gsub("}", "!!!RBrace!!!")
    return format("\\unexpanded{%s}",str)
  end
end
local function unprotect_expansion (str)
  if str then
    return str:gsub("!!!Control!!!", "\\")
              :gsub("!!!Comment!!!", "%%")
              :gsub("!!!HashSign!!!","#")
              :gsub("!!!LBrace!!!",  "{")
              :gsub("!!!RBrace!!!",  "}")
  end
end
luamplib.everymplib    = setmetatable({ [""] = "" },{ __index = function(t) return t[""] end })
luamplib.everyendmplib = setmetatable({ [""] = "" },{ __index = function(t) return t[""] end })
function luamplib.process_mplibcode (data, instancename)
  texboxes.localid = 4096
  if luamplib.legacyverbatimtex then
    luamplib.figid, tex_code_pre_mplib = 1, {}
  end
  local everymplib    = luamplib.everymplib[instancename]
  local everyendmplib = luamplib.everyendmplib[instancename]
  data = format("\n%s\n%s\n%s\n",everymplib, data, everyendmplib)
  :gsub("\r","\n")
  if luamplib.verbatiminput then
    data = data:gsub("\\mpcolor%s+(.-%b{})","mplibcolor(\"%1\")")
    :gsub("\\mpdim%s+(%b{})", "mplibdimen(\"%1\")")
    :gsub("\\mpdim%s+(\\%a+)","mplibdimen(\"%1\")")
    :gsub(btex_etex, "btex %1 etex ")
    :gsub(verbatimtex_etex, "verbatimtex %1 etex;")
  else
    data = data:gsub(btex_etex, function(str)
      return format("btex %s etex ", protect_expansion(str)) -- space
    end)
    :gsub(verbatimtex_etex, function(str)
      return format("verbatimtex %s etex;", protect_expansion(str)) -- semicolon
    end)
    :gsub("\".-\"", protect_expansion)
    :gsub("\\%%", "\0PerCent\0")
    :gsub("%%.-\n","\n")
    :gsub("%zPerCent%z", "\\%%")
    run_tex_code(format("\\mplibtmptoks\\expandafter{\\expanded{%s}}",data))
    data = texgettoks"mplibtmptoks"
    :gsub("##", "#")
    :gsub("\".-\"", unprotect_expansion)
    :gsub(btex_etex, function(str)
      return format("btex %s etex", unprotect_expansion(str))
    end)
    :gsub(verbatimtex_etex, function(str)
      return format("verbatimtex %s etex", unprotect_expansion(str))
    end)
  end
  process(data, instancename)
end

local function script2table(s)
  local t = {}
  for _,i in ipairs(s:explode("\13+")) do
    local k,v = i:match("(.-)=(.*)") -- v may contain = or empty.
    if k and v and k ~= "" and not t[k] then
      t[k] = v
    end
  end
  return t
end

local figcontents = { post = { } }
local function put2output(a,...)
  figcontents[#figcontents+1] = type(a) == "string" and format(a,...) or a
end
local function pdf_startfigure(n,llx,lly,urx,ury)
  put2output("\\mplibstarttoPDF{%f}{%f}{%f}{%f}",llx,lly,urx,ury)
end
local function pdf_stopfigure()
  put2output("\\mplibstoptoPDF")
end
local function pdf_literalcode (...)
  put2output{ -2, format(...) :gsub(decimals,rmzeros) }
end
local start_pdf_code = pdfmode
  and function() pdf_literalcode"q" end
  or  function() put2output"\\special{pdf:bcontent}" end
local stop_pdf_code = pdfmode
  and function() pdf_literalcode"Q" end
  or  function() put2output"\\special{pdf:econtent}" end

local function put_tex_boxes (object,prescript)
  local box = prescript.mplibtexboxid:explode":"
  local n,tw,th = box[1],tonumber(box[2]),tonumber(box[3])
  if n and tw and th then
    local op = object.path
    local first, second, fourth = op[1], op[2], op[4]
    local tx, ty = first.x_coord, first.y_coord
    local sx, rx, ry, sy = 1, 0, 0, 1
    if tw ~= 0 then
      sx = (second.x_coord - tx)/tw
      rx = (second.y_coord - ty)/tw
      if sx == 0 then sx = 0.00001 end
    end
    if th ~= 0 then
      sy = (fourth.y_coord - ty)/th
      ry = (fourth.x_coord - tx)/th
      if sy == 0 then sy = 0.00001 end
    end
    start_pdf_code()
    pdf_literalcode("%f %f %f %f %f %f cm",sx,rx,ry,sy,tx,ty)
    put2output("\\mplibputtextbox{%i}",n)
    stop_pdf_code()
  end
end

local prev_override_color
local function do_preobj_CR(object,prescript)
  if object.postscript == "collect" then return end
  local override = prescript and prescript.mpliboverridecolor
  if override then
    if pdfmode then
      pdf_literalcode(override)
      override = nil
    else
      put2output("\\special{%s}",override)
      prev_override_color = override
    end
  else
    local cs = object.color
    if cs and #cs > 0 then
      pdf_literalcode(luamplib.colorconverter(cs))
      prev_override_color = nil
    elseif not pdfmode then
      override = prev_override_color
      if override then
        put2output("\\special{%s}",override)
      end
    end
  end
  return override
end

local pdfmanagement = is_defined'pdfmanagement_add:nnn'
local pdfobjs, pdfetcs = {}, {}
pdfetcs.pgfextgs = "pgf@sys@addpdfresource@extgs@plain"
pdfetcs.pgfpattern = "pgf@sys@addpdfresource@patterns@plain"
pdfetcs.pgfcolorspace = "pgf@sys@addpdfresource@colorspaces@plain"
local function update_pdfobjs (os, stream)
  local key = os
  if stream then key = key..stream end
  local on = pdfobjs[key]
  if on then
    return on,false
  end
  if pdfmode then
    if stream then
      on = pdf.immediateobj("stream",stream,os)
    else
      on = pdf.immediateobj(os)
    end
  else
    on = pdfetcs.cnt or 1
    if stream then
      texsprint(format("\\special{pdf:stream @mplibpdfobj%s (%s) <<%s>>}",on,stream,os))
    else
      texsprint(format("\\special{pdf:obj @mplibpdfobj%s %s}",on,os))
    end
    pdfetcs.cnt = on + 1
  end
  pdfobjs[key] = on
  return on,true
end
pdfetcs.resfmt = pdfmode and "%s 0 R" or "@mplibpdfobj%s"
if pdfmode then
  pdfetcs.getpageres = pdf.getpageresources or function() return pdf.pageresources end
  local getpageres = pdfetcs.getpageres
  local setpageres = pdf.setpageresources or function(s) pdf.pageresources = s end
  local initialize_resources = function (name)
    local tabname = format("%s_res",name)
    pdfetcs[tabname] = { }
    if luatexbase.callbacktypes.finish_pdffile then -- ltluatex
      local obj = pdf.reserveobj()
      setpageres(format("%s/%s %i 0 R", getpageres() or "", name, obj))
      luatexbase.add_to_callback("finish_pdffile", function()
        pdf.immediateobj(obj, format("<<%s>>", tableconcat(pdfetcs[tabname])))
      end,
      format("luamplib.%s.finish_pdffile",name))
    end
  end
  pdfetcs.fallback_update_resources = function (name, res)
    local tabname = format("%s_res",name)
    if not pdfetcs[tabname] then
      initialize_resources(name)
    end
    if luatexbase.callbacktypes.finish_pdffile then
      local t = pdfetcs[tabname]
      t[#t+1] = res
    else
      local tpr, n = getpageres() or "", 0
      tpr, n = tpr:gsub(format("/%s<<",name), "%1"..res)
      if n == 0 then
        tpr = format("%s/%s<<%s>>", tpr, name, res)
      end
      setpageres(tpr)
    end
  end
else
  texsprint {
    "\\luamplibatfirstshipout{",
    "\\special{pdf:obj @MPlibTr<<>>}",
    "\\special{pdf:obj @MPlibSh<<>>}",
    "\\special{pdf:obj @MPlibCS<<>>}",
    "\\special{pdf:obj @MPlibPt<<>>}}",
  }
  pdfetcs.resadded = { }
  pdfetcs.fallback_update_resources = function (name,res,obj)
    texsprint{"\\special{pdf:put ", obj, " <<", res, ">>}"}
    if not pdfetcs.resadded[name] then
      texsprint{"\\luamplibateveryshipout{\\special{pdf:put @resources <</", name, " ", obj, ">>}}"}
      pdfetcs.resadded[name] = obj
    end
  end
end

local transparancy_modes = { [0] = "Normal",
  "Normal",       "Multiply",     "Screen",       "Overlay",
  "SoftLight",    "HardLight",    "ColorDodge",   "ColorBurn",
  "Darken",       "Lighten",      "Difference",   "Exclusion",
  "Hue",          "Saturation",   "Color",        "Luminosity",
  "Compatible",
}
local function add_extgs_resources (on, new)
  local key = format("MPlibTr%s", on)
  if new then
    local val = format(pdfetcs.resfmt, on)
    if pdfmanagement then
      texsprint {
        "\\csname pdfmanagement_add:nnn\\endcsname{Page/Resources/ExtGState}{", key, "}{", val, "}"
      }
    else
      local tr = format("/%s %s", key, val)
      if is_defined(pdfetcs.pgfextgs) then
        texsprint { "\\csname ", pdfetcs.pgfextgs, "\\endcsname{", tr, "}" }
      elseif is_defined"TRP@list" then
        texsprint(catat11,{
          [[\if@filesw\immediate\write\@auxout{]],
          [[\string\g@addto@macro\string\TRP@list{]],
          tr,
          [[}}\fi]],
        })
        if not get_macro"TRP@list":find(tr) then
          texsprint(catat11,[[\global\TRP@reruntrue]])
        end
      else
        pdfetcs.fallback_update_resources("ExtGState",tr,"@MPlibTr")
      end
    end
  end
  return key
end
local function do_preobj_TR(object,prescript)
  if object.postscript == "collect" then return end
  local opaq = prescript and prescript.tr_transparency
  if opaq then
    local key, on, os, new
    local mode = prescript.tr_alternative or 1
    mode = transparancy_modes[tonumber(mode)] or mode
    opaq = format("%.3f", opaq) :gsub(decimals,rmzeros)
    for i,v in ipairs{ {mode,opaq},{"Normal",1} } do
      os = format("<</BM/%s/ca %s/CA %s/AIS false>>",v[1],v[2],v[2])
      on, new = update_pdfobjs(os)
      key = add_extgs_resources(on,new)
      if i == 1 then
        pdf_literalcode("/%s gs",key)
      else
        return format("/%s gs",key)
      end
    end
  end
end

local function sh_pdfpageresources(shtype,domain,colorspace,ca,cb,coordinates,steps,fractions)
  for _,v in ipairs{ca,cb} do
    for i,vv in ipairs(v) do
      for ii,vvv in ipairs(vv) do
        v[i][ii] = tonumber(vvv) and format("%.3f",vvv) or vvv
      end
    end
  end
  local fun2fmt,os = "<</FunctionType 2/Domain[%s]/C0[%s]/C1[%s]/N 1>>"
  if steps > 1 then
    local list,bounds,encode = { },{ },{ }
    for i=1,steps do
      if i < steps then
        bounds[i] = format("%.3f", fractions[i] or 1)
      end
      encode[2*i-1] = 0
      encode[2*i]   = 1
      os = fun2fmt:format(domain,tableconcat(ca[i],' '),tableconcat(cb[i],' '))
        :gsub(decimals,rmzeros)
      list[i] = format(pdfetcs.resfmt, update_pdfobjs(os))
    end
    os = tableconcat {
      "<</FunctionType 3",
      format("/Bounds[%s]",    tableconcat(bounds,' ')),
      format("/Encode[%s]",    tableconcat(encode,' ')),
      format("/Functions[%s]", tableconcat(list,  ' ')),
      format("/Domain[%s]>>",  domain),
    } :gsub(decimals,rmzeros)
  else
    os = fun2fmt:format(domain,tableconcat(ca[1],' '),tableconcat(cb[1],' '))
      :gsub(decimals,rmzeros)
  end
  local objref = format(pdfetcs.resfmt, update_pdfobjs(os))
  os = tableconcat {
    format("<</ShadingType %i", shtype),
    format("/ColorSpace %s",    colorspace),
    format("/Function %s",      objref),
    format("/Coords[%s]",       coordinates),
    "/Extend[true true]/AntiAlias true>>",
  } :gsub(decimals,rmzeros)
  local on, new = update_pdfobjs(os)
  if new then
    local key, val = format("MPlibSh%s", on), format(pdfetcs.resfmt, on)
    if pdfmanagement then
      texsprint {
        "\\csname pdfmanagement_add:nnn\\endcsname{Page/Resources/Shading}{", key, "}{", val, "}"
      }
    else
      local res = format("/%s %s", key, val)
      pdfetcs.fallback_update_resources("Shading",res,"@MPlibSh")
    end
  end
  return on
end
local function color_normalize(ca,cb)
  if #cb == 1 then
    if #ca == 4 then
      cb[1], cb[2], cb[3], cb[4] = 0, 0, 0, 1-cb[1]
    else -- #ca = 3
      cb[1], cb[2], cb[3] = cb[1], cb[1], cb[1]
    end
  elseif #cb == 3 then -- #ca == 4
    cb[1], cb[2], cb[3], cb[4] = 1-cb[1], 1-cb[2], 1-cb[3], 0
  end
end
pdfetcs.clrspcs = setmetatable({ }, { __index = function(t,names)
  run_tex_code({
    [[\color_model_new:nnn]],
    format("{mplibcolorspace_%s}", names:gsub(",","_")),
    format("{DeviceN}{names={%s}}", names),
    [[\edef\mplib_@tempa{\pdf_object_ref_last:}]],
  }, ccexplat)
  local colorspace = get_macro'mplib_@tempa'
  t[names] = colorspace
  return colorspace
end })
local function do_preobj_SH(object,prescript)
  local shade_no
  local sh_type = prescript and prescript.sh_type
  if not sh_type then
    return
  else
    local domain  = prescript.sh_domain or "0 1"
    local centera = (prescript.sh_center_a or "0 0"):explode()
    local centerb = (prescript.sh_center_b or "0 0"):explode()
    local transform = prescript.sh_transform == "yes"
    local sx,sy,sr,dx,dy = 1,1,1,0,0
    if transform then
      local first = (prescript.sh_first or "0 0"):explode()
      local setx  = (prescript.sh_set_x or "0 0"):explode()
      local sety  = (prescript.sh_set_y or "0 0"):explode()
      local x,y = tonumber(setx[1]) or 0, tonumber(sety[1]) or 0
      if x ~= 0 and y ~= 0 then
        local path = object.path
        local path1x = path[1].x_coord
        local path1y = path[1].y_coord
        local path2x = path[x].x_coord
        local path2y = path[y].y_coord
        local dxa = path2x - path1x
        local dya = path2y - path1y
        local dxb = setx[2] - first[1]
        local dyb = sety[2] - first[2]
        if dxa ~= 0 and dya ~= 0 and dxb ~= 0 and dyb ~= 0 then
          sx = dxa / dxb ; if sx < 0 then sx = - sx end
          sy = dya / dyb ; if sy < 0 then sy = - sy end
          sr = math.sqrt(sx^2 + sy^2)
          dx = path1x - sx*first[1]
          dy = path1y - sy*first[2]
        end
      end
    end
    local ca, cb, colorspace, steps, fractions
    ca = { (prescript.sh_color_a_1 or prescript.sh_color_a or "0"):explode":" }
    cb = { (prescript.sh_color_b_1 or prescript.sh_color_b or "1"):explode":" }
    steps = tonumber(prescript.sh_step) or 1
    if steps > 1 then
      fractions = { prescript.sh_fraction_1 or 0 }
      for i=2,steps do
        fractions[i] = prescript[format("sh_fraction_%i",i)] or (i/steps)
        ca[i] = (prescript[format("sh_color_a_%i",i)] or "0"):explode":"
        cb[i] = (prescript[format("sh_color_b_%i",i)] or "1"):explode":"
      end
    end
    if prescript.mplib_spotcolor then
      ca, cb = { }, { }
      local names, pos, objref = { }, -1, ""
      local script = object.prescript:explode"\13+"
      for i=#script,1,-1 do
        if script[i]:find"mplib_spotcolor" then
          local t, name, value = script[i]:explode"="[2]:explode":"
          value, objref, name = t[1], t[2], t[3]
          if not names[name] then
            pos = pos+1
            names[name] = pos
            names[#names+1] = name
          end
          t = { }
          for j=1,names[name] do t[#t+1] = 0 end
          t[#t+1] = value
          tableinsert(#ca == #cb and ca or cb, t)
        end
      end
      for _,t in ipairs{ca,cb} do
        for _,tt in ipairs(t) do
          for i=1,#names-#tt do tt[#tt+1] = 0 end
        end
      end
      if #names == 1 then
        colorspace = objref
      else
        colorspace = pdfetcs.clrspcs[ tableconcat(names,",") ]
      end
    else
      local model = 0
      for _,t in ipairs{ca,cb} do
        for _,tt in ipairs(t) do
          model = model > #tt and model or #tt
        end
      end
      for _,t in ipairs{ca,cb} do
        for _,tt in ipairs(t) do
          if #tt < model then
            color_normalize(model == 4 and {1,1,1,1} or {1,1,1},tt)
          end
        end
      end
      colorspace = model == 4 and "/DeviceCMYK"
                or model == 3 and "/DeviceRGB"
                or model == 1 and "/DeviceGray"
                or err"unknown color model"
    end
    if sh_type == "linear" then
      local coordinates = format("%f %f %f %f",
        dx + sx*centera[1], dy + sy*centera[2],
        dx + sx*centerb[1], dy + sy*centerb[2])
      shade_no = sh_pdfpageresources(2,domain,colorspace,ca,cb,coordinates,steps,fractions)
    elseif sh_type == "circular" then
      local factor = prescript.sh_factor or 1
      local radiusa = factor * prescript.sh_radius_a
      local radiusb = factor * prescript.sh_radius_b
      local coordinates = format("%f %f %f %f %f %f",
        dx + sx*centera[1], dy + sy*centera[2], sr*radiusa,
        dx + sx*centerb[1], dy + sy*centerb[2], sr*radiusb)
      shade_no = sh_pdfpageresources(3,domain,colorspace,ca,cb,coordinates,steps,fractions)
    else
      err"unknown shading type"
    end
  end
  return shade_no
end

pdfetcs.patterns = { }
local function gather_resources (optres)
  local t, do_pattern = { }, not optres
  local names = {"ExtGState","ColorSpace","Shading"}
  if do_pattern then
    names[#names+1] = "Pattern"
  end
  if pdfmode then
    if pdfmanagement then
      for _,v in ipairs(names) do
        local pp = get_macro(format("g__pdfdict_/g__pdf_Core/Page/Resources/%s_prop",v))
        if pp and pp:find"__prop_pair" then
          t[#t+1] = format("/%s %s 0 R", v, ltx.pdf.object_id("__pdf/Page/Resources/"..v))
        end
      end
    else
      local res = pdfetcs.getpageres() or ""
      run_tex_code[[\mplibtmptoks\expandafter{\the\pdfvariable pageresources}]]
      res = res .. texgettoks'mplibtmptoks'
      if do_pattern then return res end
      res = res:explode"/+"
      for _,v in ipairs(res) do
        v = v:match"^%s*(.-)%s*$"
        if not v:find"Pattern" and not optres:find(v) then
          t[#t+1] = "/" .. v
        end
      end
    end
  else
    if pdfmanagement then
      for _,v in ipairs(names) do
        local pp = get_macro(format("g__pdfdict_/g__pdf_Core/Page/Resources/%s_prop",v))
        if pp and pp:find"__prop_pair" then
          run_tex_code {
            "\\mplibtmptoks\\expanded{{",
            format("/%s \\csname pdf_object_ref:n\\endcsname{__pdf/Page/Resources/%s}",v,v),
            "}}",
          }
          t[#t+1] = texgettoks'mplibtmptoks'
        end
      end
    elseif is_defined(pdfetcs.pgfextgs) then
      run_tex_code ({
        "\\mplibtmptoks\\expanded{{",
        "\\ifpgf@sys@pdf@extgs@exists /ExtGState @pgfextgs\\fi",
        "\\ifpgf@sys@pdf@colorspaces@exists /ColorSpace @pgfcolorspaces\\fi",
        do_pattern and "\\ifpgf@sys@pdf@patterns@exists /Pattern @pgfpatterns \\fi" or "",
        "}}",
      }, catat11)
      t[#t+1] = texgettoks'mplibtmptoks'
    else
      for _,v in ipairs(names) do
        local vv = pdfetcs.resadded[v]
        if vv then
          t[#t+1] = format("/%s %s", v, vv)
        end
      end
    end
  end
  return tableconcat(t)
end
function luamplib.registerpattern ( boxid, name, opts )
  local box = texgetbox(boxid)
  local wd = format("%.3f",box.width/factor)
  local hd = format("%.3f",(box.height+box.depth)/factor)
  info("w/h/d of pattern '%s': %s 0", name, format("%s %s",wd, hd):gsub(decimals,rmzeros))
  if opts.xstep == 0 then opts.xstep = nil end
  if opts.ystep == 0 then opts.ystep = nil end
  if opts.colored == nil then
    opts.colored = opts.coloured
    if opts.colored == nil then
      opts.colored = true
    end
  end
  if type(opts.matrix) == "table" then opts.matrix = tableconcat(opts.matrix," ") end
  if type(opts.bbox) == "table" then opts.bbox = tableconcat(opts.bbox," ") end
  if opts.matrix and opts.matrix:find"%a" then
    local data = format("mplibtransformmatrix(%s);",opts.matrix)
    process(data,"@mplibtransformmatrix")
    local t = luamplib.transformmatrix
    opts.matrix = format("%f %f %f %f", t[1], t[2], t[3], t[4])
    opts.xshift = opts.xshift or format("%f",t[5])
    opts.yshift = opts.yshift or format("%f",t[6])
  end
  local attr = {
    "/Type/Pattern",
    "/PatternType 1",
    format("/PaintType %i", opts.colored and 1 or 2),
    "/TilingType 2",
    format("/XStep %s", opts.xstep or wd),
    format("/YStep %s", opts.ystep or hd),
    format("/Matrix[%s %s %s]", opts.matrix or "1 0 0 1", opts.xshift or 0, opts.yshift or 0),
  }
  local optres = opts.resources or ""
  optres = optres .. gather_resources(optres)
  local patterns = pdfetcs.patterns
  if pdfmode then
    if opts.bbox then
      attr[#attr+1] = format("/BBox[%s]", opts.bbox)
    end
    attr = tableconcat(attr) :gsub(decimals,rmzeros)
    local index = tex.saveboxresource(boxid, attr, optres, true, opts.bbox and 4 or 1)
    patterns[name] = { id = index, colored = opts.colored }
  else
    local cnt = #patterns + 1
    local objname = "@mplibpattern" .. cnt
    local metric = format("bbox %s", opts.bbox or format("0 0 %s %s",wd,hd))
    texsprint {
      "\\expandafter\\newbox\\csname luamplib.patternbox.", cnt, "\\endcsname",
      "\\global\\setbox\\csname luamplib.patternbox.", cnt, "\\endcsname",
      "\\hbox{\\unhbox ", boxid, "}\\luamplibatnextshipout{",
      "\\special{pdf:bcontent}",
      "\\special{pdf:bxobj ", objname, " ", metric, "}",
      "\\raise\\dp\\csname luamplib.patternbox.", cnt, "\\endcsname",
      "\\box\\csname luamplib.patternbox.", cnt, "\\endcsname",
      "\\special{pdf:put @resources <<", optres, ">>}",
      "\\special{pdf:exobj <<", tableconcat(attr), ">>}",
      "\\special{pdf:econtent}}",
    }
    patterns[cnt] = objname
    patterns[name] = { id = cnt, colored = opts.colored }
  end
end
local function pattern_colorspace (cs)
  local on, new = update_pdfobjs(format("[/Pattern %s]", cs))
  if new then
    local key, val = format("MPlibCS%i",on), format(pdfetcs.resfmt,on)
    if pdfmanagement then
      texsprint {
        "\\csname pdfmanagement_add:nnn\\endcsname{Page/Resources/ColorSpace}{", key, "}{", val, "}"
      }
    else
      local res = format("/%s %s", key, val)
      if is_defined(pdfetcs.pgfcolorspace) then
        texsprint { "\\csname ", pdfetcs.pgfcolorspace, "\\endcsname{", res, "}" }
      else
        pdfetcs.fallback_update_resources("ColorSpace",res,"@MPlibCS")
      end
    end
  end
  return on
end
local function do_preobj_PAT(object, prescript)
  local name = prescript and prescript.mplibpattern
  if not name then return end
  local patterns = pdfetcs.patterns
  local patt = patterns[name]
  local index = patt and patt.id or err("cannot get pattern object '%s'", name)
  local key = format("MPlibPt%s",index)
  if patt.colored then
    pdf_literalcode("/Pattern cs /%s scn", key)
  else
    local color = prescript.mpliboverridecolor
    if not color then
      local t = object.color
      color = t and #t>0 and luamplib.colorconverter(t)
    end
    if not color then return end
    local cs
    if color:find" cs " or color:find"@pdf.obj" then
      local t = color:explode()
      if pdfmode then
        cs = format("%s 0 R", ltx.pdf.object_id( t[1]:sub(2,-1) ))
        color = t[3]
      else
        cs = t[2]
        color = t[3]:match"%[(.+)%]"
      end
    else
      local t = colorsplit(color)
      cs = #t == 4 and "/DeviceCMYK" or #t == 3 and "/DeviceRGB" or "/DeviceGray"
      color = tableconcat(t," ")
    end
    pdf_literalcode("/MPlibCS%i cs %s /%s scn", pattern_colorspace(cs), color, key)
  end
  if not patt.done then
    local val = pdfmode and format("%s 0 R",index) or patterns[index]
    if pdfmanagement then
      texsprint {
        "\\csname pdfmanagement_add:nnn\\endcsname{Page/Resources/Pattern}{", key, "}{", val, "}"
      }
    else
      local res = format("/%s %s", key, val)
      if is_defined(pdfetcs.pgfpattern) then
        texsprint { "\\csname ", pdfetcs.pgfpattern, "\\endcsname{", res, "}" }
      else
        pdfetcs.fallback_update_resources("Pattern",res,"@MPlibPt")
      end
    end
  end
  patt.done = true
end

pdfetcs.fading = { }
local function do_preobj_FADE (object, prescript)
  local fd_type = prescript and prescript.mplibfadetype
  local fd_stop = prescript and prescript.mplibfadestate
  if not fd_type then
    return fd_stop -- returns "stop" (if picture) or nil
  end
  local bbox = prescript.mplibfadebbox:explode":"
  local dx, dy = -bbox[1], -bbox[2]
  local vec = prescript.mplibfadevector; vec = vec and vec:explode":"
  if not vec then
    if fd_type == "linear" then
      vec = {bbox[1], bbox[2], bbox[3], bbox[2]} -- left to right
    else
      local centerx, centery = (bbox[1]+bbox[3])/2, (bbox[2]+bbox[4])/2
      vec = {centerx, centery, centerx, centery} -- center for both circles
    end
  end
  local coords = { vec[1]+dx, vec[2]+dy, vec[3]+dx, vec[4]+dy }
  if fd_type == "linear" then
    coords = format("%f %f %f %f", tableunpack(coords))
  elseif fd_type == "circular" then
    local width, height = bbox[3]-bbox[1], bbox[4]-bbox[2]
    local radius = (prescript.mplibfaderadius or "0:"..math.sqrt(width^2+height^2)/2):explode":"
    tableinsert(coords, 3, radius[1])
    tableinsert(coords, radius[2])
    coords = format("%f %f %f %f %f %f", tableunpack(coords))
  else
    err("unknown fading method '%s'", fd_type)
  end
  fd_type = fd_type == "linear" and 2 or 3
  local opaq = (prescript.mplibfadeopacity or "1:0"):explode":"
  local on, os, new
  on = sh_pdfpageresources(fd_type, "0 1", "/DeviceGray", {{opaq[1]}}, {{opaq[2]}}, coords, 1)
  os = format("<</PatternType 2/Shading %s>>", format(pdfetcs.resfmt, on))
  on = update_pdfobjs(os)
  bbox = format("0 0 %f %f", bbox[3]+dx, bbox[4]+dy)
  local streamtext = format("q /Pattern cs/MPlibFd%s scn %s re f Q", on, bbox)
    :gsub(decimals,rmzeros)
  os = format("<</Pattern<</MPlibFd%s %s>>>>", on, format(pdfetcs.resfmt, on))
  on = update_pdfobjs(os)
  local resources = format(pdfetcs.resfmt, on)
  on = update_pdfobjs"<</S/Transparency/CS/DeviceGray>>"
  local attr = tableconcat{
    "/Subtype/Form",
    "/BBox[", bbox, "]",
    "/Matrix[1 0 0 1 ", format("%f %f", -dx,-dy), "]",
    "/Resources ", resources,
    "/Group ", format(pdfetcs.resfmt, on),
  } :gsub(decimals,rmzeros)
  on = update_pdfobjs(attr, streamtext)
  os = "<</SMask<</S/Luminosity/G " .. format(pdfetcs.resfmt, on) .. ">>>>"
  on, new = update_pdfobjs(os)
  local key = add_extgs_resources(on,new)
  start_pdf_code()
  pdf_literalcode("/%s gs", key)
  if fd_stop then return "standalone" end
  return "start"
end

pdfetcs.tr_group = { shifts = { } }
luamplib.trgroupshifts = pdfetcs.tr_group.shifts
local function do_preobj_GRP (object, prescript)
  local grstate = prescript and prescript.gr_state
  if not grstate then return end
  local trgroup = pdfetcs.tr_group
  if grstate == "start" then
    trgroup.name = prescript.mplibgroupname or "lastmplibgroup"
    trgroup.isolated, trgroup.knockout = false, false
    for _,v in ipairs(prescript.gr_type:explode",+") do
      trgroup[v] = true
    end
    trgroup.bbox = prescript.mplibgroupbbox:explode":"
    put2output[[\begingroup\setbox\mplibscratchbox\hbox\bgroup]]
  elseif grstate == "stop" then
    local llx,lly,urx,ury = tableunpack(trgroup.bbox)
    put2output(tableconcat{
      "\\egroup",
      format("\\wd\\mplibscratchbox %fbp", urx-llx),
      format("\\ht\\mplibscratchbox %fbp", ury-lly),
      "\\dp\\mplibscratchbox 0pt",
    })
    local grattr = format("/Group<</S/Transparency/I %s/K %s>>",trgroup.isolated,trgroup.knockout)
    local res = gather_resources()
    local bbox = format("%f %f %f %f", llx,lly,urx,ury) :gsub(decimals,rmzeros)
    if pdfmode then
      put2output(tableconcat{
        "\\saveboxresource type 2 attr{/Type/XObject/Subtype/Form/FormType 1",
        "/BBox[", bbox, "]", grattr, "} resources{", res, "}\\mplibscratchbox",
        [[\setbox\mplibscratchbox\hbox{\useboxresource\lastsavedboxresourceindex}]],
        [[\wd\mplibscratchbox 0pt\ht\mplibscratchbox 0pt\dp\mplibscratchbox 0pt]],
        [[\box\mplibscratchbox\endgroup]],
        "\\expandafter\\xdef\\csname luamplib.group.", trgroup.name, "\\endcsname{",
        "\\noexpand\\mplibstarttoPDF{",llx,"}{",lly,"}{",urx,"}{",ury,"}",
        "\\useboxresource \\the\\lastsavedboxresourceindex\\noexpand\\mplibstoptoPDF}",
      })
    else
      trgroup.cnt = (trgroup.cnt or 0) + 1
      local objname = format("@mplibtrgr%s", trgroup.cnt)
      put2output(tableconcat{
        "\\special{pdf:bxobj ", objname, " bbox ", bbox, "}",
        "\\unhbox\\mplibscratchbox",
        "\\special{pdf:put @resources <<", res, ">>}",
        "\\special{pdf:exobj <<", grattr, ">>}",
        "\\special{pdf:uxobj ", objname, "}\\endgroup",
      })
      token.set_macro("luamplib.group."..trgroup.name, tableconcat{
        "\\mplibstarttoPDF{",llx,"}{",lly,"}{",urx,"}{",ury,"}",
        "\\special{pdf:uxobj ", objname, "}\\mplibstoptoPDF",
      }, "global")
    end
    trgroup.shifts[trgroup.name] = { llx, lly }
  end
  return grstate
end
function luamplib.registergroup (boxid, name, opts)
  local box = texgetbox(boxid)
  local wd, ht, dp = node.getwhd(box)
  local res = (opts.resources or "") .. gather_resources()
  local attr = { "/Type/XObject/Subtype/Form/FormType 1" }
  if type(opts.matrix) == "table" then opts.matrix = tableconcat(opts.matrix," ") end
  if type(opts.bbox) == "table" then opts.bbox = tableconcat(opts.bbox," ") end
  if opts.matrix and opts.matrix:find"%a" then
    local data = format("mplibtransformmatrix(%s);",opts.matrix)
    process(data,"@mplibtransformmatrix")
    opts.matrix = format("%f %f %f %f %f %f",tableunpack(luamplib.transformmatrix))
  end
  local grtype = 3
  if opts.bbox then
    attr[#attr+1] = format("/BBox[%s]", opts.bbox)
    grtype = 2
  end
  if opts.matrix then
    attr[#attr+1] = format("/Matrix[%s]", opts.matrix)
    grtype = opts.bbox and 4 or 1
  end
  if opts.asgroup then
    local t = { isolated = false, knockout = false }
    for _,v in ipairs(opts.asgroup:explode",+") do t[v] = true end
    attr[#attr+1] = format("/Group<</S/Transparency/I %s/K %s>>", t.isolated, t.knockout)
  end
  local trgroup = pdfetcs.tr_group
  trgroup.shifts[name] = { get_macro'MPllx', get_macro'MPlly' }
  local whd
  local tagpdf = is_defined'picture@tag@bbox@attribute'
  if pdfmode then
    attr = tableconcat(attr) :gsub(decimals,rmzeros)
    local index = tex.saveboxresource(boxid, attr, res, true, grtype)
    token.set_macro("luamplib.group."..name, tableconcat{
      "\\prependtomplibbox\\hbox\\bgroup",
      tagpdf and "\\luamplibtaggingbegin\\setbox\\mplibscratchbox\\hbox\\bgroup" or "",
      "\\useboxresource ", index,
      tagpdf and "\\egroup\\luamplibtaggingBBox\\unhbox\\mplibscratchbox\\luamplibtaggingend" or "",
      "\\egroup",
    }, "global")
    whd = format("%.3f %.3f 0", wd/factor, (ht+dp)/factor) :gsub(decimals,rmzeros)
  else
    trgroup.cnt = (trgroup.cnt or 0) + 1
    local objname = format("@mplibtrgr%s", trgroup.cnt)
    texsprint {
      "\\expandafter\\newbox\\csname luamplib.groupbox.", trgroup.cnt, "\\endcsname",
      "\\global\\setbox\\csname luamplib.groupbox.", trgroup.cnt, "\\endcsname",
      "\\hbox{\\unhbox ", boxid, "}\\luamplibatnextshipout{",
      "\\special{pdf:bcontent}",
      "\\special{pdf:bxobj ", objname, " width ", wd, "sp height ", ht, "sp depth ", dp, "sp}",
      "\\unhbox\\csname luamplib.groupbox.", trgroup.cnt, "\\endcsname",
      "\\special{pdf:put @resources <<", res, ">>}",
      "\\special{pdf:exobj <<", tableconcat(attr), ">>}",
      "\\special{pdf:econtent}}",
    }
    token.set_macro("luamplib.group."..name, tableconcat{
      "\\prependtomplibbox\\hbox\\bgroup",
      tagpdf and "\\luamplibtaggingbegin" or "",
      "\\setbox\\mplibscratchbox\\hbox{\\special{pdf:uxobj ", objname, "}}",
      "\\wd\\mplibscratchbox ", wd, "sp",
      "\\ht\\mplibscratchbox ", ht, "sp",
      "\\dp\\mplibscratchbox ", dp, "sp",
      tagpdf and "\\luamplibtaggingBBox" or "",
      "\\box\\mplibscratchbox",
      tagpdf and "\\luamplibtaggingend" or "",
      "\\egroup",
    }, "global")
    whd = format("%.3f %.3f %.3f", wd/factor, ht/factor, dp/factor) :gsub(decimals,rmzeros)
  end
  info("w/h/d of group '%s': %s", name, whd)
end

local function stop_special_effects(fade,opaq,over)
  if fade then -- fading
    stop_pdf_code()
  end
  if opaq then -- opacity
    pdf_literalcode(opaq)
  end
  if over then -- color
    put2output"\\special{pdf:ec}"
  end
end

local function getobjects(result,figure,f)
  return figure:objects()
end

function luamplib.convert (result, flusher)
  luamplib.flush(result, flusher)
  return true -- done
end

local function pdf_textfigure(font,size,text,width,height,depth)
  text = text:gsub(".",function(c)
    return format("\\hbox{\\char%i}",string.byte(c)) -- kerning happens in metapost : false
  end)
  put2output("\\mplibtextext{%s}{%f}{%s}{%s}{%s}",font,size,text,0,0)
end

local bend_tolerance = 131/65536

local rx, sx, sy, ry, tx, ty, divider = 1, 0, 0, 1, 0, 0, 1

local function pen_characteristics(object)
  local t = mplib.pen_info(object)
  rx, ry, sx, sy, tx, ty = t.rx, t.ry, t.sx, t.sy, t.tx, t.ty
  divider = sx*sy - rx*ry
  return not (sx==1 and rx==0 and ry==0 and sy==1 and tx==0 and ty==0), t.width
end

local function concat(px, py) -- no tx, ty here
  return (sy*px-ry*py)/divider,(sx*py-rx*px)/divider
end

local function curved(ith,pth)
  local d = pth.left_x - ith.right_x
  if abs(ith.right_x - ith.x_coord - d) <= bend_tolerance and abs(pth.x_coord - pth.left_x - d) <= bend_tolerance then
    d = pth.left_y - ith.right_y
    if abs(ith.right_y - ith.y_coord - d) <= bend_tolerance and abs(pth.y_coord - pth.left_y - d) <= bend_tolerance then
      return false
    end
  end
  return true
end

local function flushnormalpath(path,open)
  local pth, ith
  for i=1,#path do
    pth = path[i]
    if not ith then
      pdf_literalcode("%f %f m",pth.x_coord,pth.y_coord)
    elseif curved(ith,pth) then
      pdf_literalcode("%f %f %f %f %f %f c",ith.right_x,ith.right_y,pth.left_x,pth.left_y,pth.x_coord,pth.y_coord)
    else
      pdf_literalcode("%f %f l",pth.x_coord,pth.y_coord)
    end
    ith = pth
  end
  if not open then
    local one = path[1]
    if curved(pth,one) then
      pdf_literalcode("%f %f %f %f %f %f c",pth.right_x,pth.right_y,one.left_x,one.left_y,one.x_coord,one.y_coord )
    else
      pdf_literalcode("%f %f l",one.x_coord,one.y_coord)
    end
  elseif #path == 1 then -- special case .. draw point
    local one = path[1]
    pdf_literalcode("%f %f l",one.x_coord,one.y_coord)
  end
end

local function flushconcatpath(path,open)
  pdf_literalcode("%f %f %f %f %f %f cm", sx, rx, ry, sy, tx ,ty)
  local pth, ith
  for i=1,#path do
    pth = path[i]
    if not ith then
      pdf_literalcode("%f %f m",concat(pth.x_coord,pth.y_coord))
    elseif curved(ith,pth) then
      local a, b = concat(ith.right_x,ith.right_y)
      local c, d = concat(pth.left_x,pth.left_y)
      pdf_literalcode("%f %f %f %f %f %f c",a,b,c,d,concat(pth.x_coord, pth.y_coord))
    else
      pdf_literalcode("%f %f l",concat(pth.x_coord, pth.y_coord))
    end
    ith = pth
  end
  if not open then
    local one = path[1]
    if curved(pth,one) then
      local a, b = concat(pth.right_x,pth.right_y)
      local c, d = concat(one.left_x,one.left_y)
      pdf_literalcode("%f %f %f %f %f %f c",a,b,c,d,concat(one.x_coord, one.y_coord))
    else
      pdf_literalcode("%f %f l",concat(one.x_coord,one.y_coord))
    end
  elseif #path == 1 then -- special case .. draw point
    local one = path[1]
    pdf_literalcode("%f %f l",concat(one.x_coord,one.y_coord))
  end
end

function luamplib.flush (result,flusher)
  if result then
    local figures = result.fig
    if figures then
      for f=1, #figures do
        info("flushing figure %s",f)
        local figure = figures[f]
        local objects = getobjects(result,figure,f)
        local fignum = tonumber(figure:filename():match("([%d]+)$") or figure:charcode() or 0)
        local miterlimit, linecap, linejoin, dashed = -1, -1, -1, false
        local bbox = figure:boundingbox()
        local llx, lly, urx, ury = bbox[1], bbox[2], bbox[3], bbox[4] -- faster than unpack
        if urx < llx then
        else
          if tex_code_pre_mplib[f] then
            put2output(tex_code_pre_mplib[f])
          end
          pdf_startfigure(fignum,llx,lly,urx,ury)
          start_pdf_code()
          if objects then
            local savedpath = nil
            local savedhtap = nil
            for o=1,#objects do
              local object        = objects[o]
              local objecttype    = object.type
              local prescript     = object.prescript
              prescript = prescript and script2table(prescript) -- prescript is now a table
              local cr_over = do_preobj_CR(object,prescript) -- color
              local tr_opaq = do_preobj_TR(object,prescript) -- opacity
              local fading_ = do_preobj_FADE(object,prescript) -- fading
              local trgroup = do_preobj_GRP(object,prescript) -- transparency group
              local pattern_ = do_preobj_PAT(object,prescript) -- pattern
              if prescript and prescript.mplibtexboxid then
                put_tex_boxes(object,prescript)
              elseif objecttype == "start_bounds" or objecttype == "stop_bounds" then --skip
              elseif objecttype == "start_clip" then
                local evenodd = not object.istext and object.postscript == "evenodd"
                start_pdf_code()
                flushnormalpath(object.path,false)
                pdf_literalcode(evenodd and "W* n" or "W n")
              elseif objecttype == "stop_clip" then
                stop_pdf_code()
                miterlimit, linecap, linejoin, dashed = -1, -1, -1, false
              elseif objecttype == "special" then
                if prescript and prescript.postmplibverbtex then
                  figcontents.post[#figcontents.post+1] = prescript.postmplibverbtex
                end
              elseif objecttype == "text" then
                local ot = object.transform -- 3,4,5,6,1,2
                start_pdf_code()
                pdf_literalcode("%f %f %f %f %f %f cm",ot[3],ot[4],ot[5],ot[6],ot[1],ot[2])
                pdf_textfigure(object.font,object.dsize,object.text,object.width,object.height,object.depth)
                stop_pdf_code()
              elseif not trgroup and fading_ ~= "stop" then
                local evenodd, collect, both = false, false, false
                local postscript = object.postscript
                if not object.istext then
                  if postscript == "evenodd" then
                    evenodd = true
                  elseif postscript == "collect" then
                    collect = true
                  elseif postscript == "both" then
                    both = true
                  elseif postscript == "eoboth" then
                    evenodd = true
                    both    = true
                  end
                end
                if collect then
                  if not savedpath then
                    savedpath = { object.path or false }
                    savedhtap = { object.htap or false }
                  else
                    savedpath[#savedpath+1] = object.path or false
                    savedhtap[#savedhtap+1] = object.htap or false
                  end
                else
                  local ml = object.miterlimit
                  if ml and ml ~= miterlimit then
                    miterlimit = ml
                    pdf_literalcode("%f M",ml)
                  end
                  local lj = object.linejoin
                  if lj and lj ~= linejoin then
                    linejoin = lj
                    pdf_literalcode("%i j",lj)
                  end
                  local lc = object.linecap
                  if lc and lc ~= linecap then
                    linecap = lc
                    pdf_literalcode("%i J",lc)
                  end
                  local dl = object.dash
                  if dl then
                    local d = format("[%s] %f d",tableconcat(dl.dashes or {}," "),dl.offset)
                    if d ~= dashed then
                      dashed = d
                      pdf_literalcode(dashed)
                    end
                  elseif dashed then
                    pdf_literalcode("[] 0 d")
                    dashed = false
                  end
                  local path = object.path
                  local transformed, penwidth = false, 1
                  local open = path and path[1].left_type and path[#path].right_type
                  local pen = object.pen
                  if pen then
                    if pen.type == 'elliptical' then
                      transformed, penwidth = pen_characteristics(object) -- boolean, value
                      pdf_literalcode("%f w",penwidth)
                      if objecttype == 'fill' then
                        objecttype = 'both'
                      end
                    else -- calculated by mplib itself
                      objecttype = 'fill'
                    end
                  end
                  local shade_no = do_preobj_SH(object,prescript) -- shading
                  if shade_no then
                    pdf_literalcode"q /Pattern cs"
                    objecttype = false
                  end
                  if transformed then
                    start_pdf_code()
                  end
                  if path then
                    if savedpath then
                      for i=1,#savedpath do
                        local path = savedpath[i]
                        if transformed then
                          flushconcatpath(path,open)
                        else
                          flushnormalpath(path,open)
                        end
                      end
                      savedpath = nil
                    end
                    if transformed then
                      flushconcatpath(path,open)
                    else
                      flushnormalpath(path,open)
                    end
                    if objecttype == "fill" then
                      pdf_literalcode(evenodd and "h f*" or "h f")
                    elseif objecttype == "outline" then
                      if both then
                        pdf_literalcode(evenodd and "h B*" or "h B")
                      else
                        pdf_literalcode(open and "S" or "h S")
                      end
                    elseif objecttype == "both" then
                      pdf_literalcode(evenodd and "h B*" or "h B")
                    end
                  end
                  if transformed then
                    stop_pdf_code()
                  end
                  local path = object.htap
                  if path then
                    if transformed then
                      start_pdf_code()
                    end
                    if savedhtap then
                      for i=1,#savedhtap do
                        local path = savedhtap[i]
                        if transformed then
                          flushconcatpath(path,open)
                        else
                          flushnormalpath(path,open)
                        end
                      end
                      savedhtap = nil
                      evenodd   = true
                    end
                    if transformed then
                      flushconcatpath(path,open)
                    else
                      flushnormalpath(path,open)
                    end
                    if objecttype == "fill" then
                      pdf_literalcode(evenodd and "h f*" or "h f")
                    elseif objecttype == "outline" then
                      pdf_literalcode(open and "S" or "h S")
                    elseif objecttype == "both" then
                      pdf_literalcode(evenodd and "h B*" or "h B")
                    end
                    if transformed then
                      stop_pdf_code()
                    end
                  end
                  if shade_no then -- shading
                    pdf_literalcode("W%s n /MPlibSh%s sh Q",evenodd and "*" or "",shade_no)
                  end
                end
              end
              if fading_ == "start" then
                pdfetcs.fading.specialeffects = {fading_, tr_opaq, cr_over}
              elseif trgroup == "start" then
                pdfetcs.tr_group.specialeffects = {fading_, tr_opaq, cr_over}
              elseif fading_ == "stop" then
                local se = pdfetcs.fading.specialeffects
                if se then stop_special_effects(se[1], se[2], se[3]) end
              elseif trgroup == "stop" then
                local se = pdfetcs.tr_group.specialeffects
                if se then stop_special_effects(se[1], se[2], se[3]) end
              else
                stop_special_effects(fading_, tr_opaq, cr_over)
              end
              if fading_ or trgroup then -- extgs resetted
                miterlimit, linecap, linejoin, dashed = -1, -1, -1, false
              end
            end
          end
          stop_pdf_code()
          pdf_stopfigure()
          for _,v in ipairs(figcontents) do
            if type(v) == "table" then
              texsprint"\\mplibtoPDF{"; texsprint(v[1], v[2]); texsprint"}"
            else
              texsprint(v)
            end
          end
          if #figcontents.post > 0 then texsprint(figcontents.post) end
          figcontents = { post = { } }
        end
      end
    end
  end
end

function luamplib.colorconverter (cr)
  local n = #cr
  if n == 4 then
    local c, m, y, k = cr[1], cr[2], cr[3], cr[4]
    return format("%.3f %.3f %.3f %.3f k %.3f %.3f %.3f %.3f K",c,m,y,k,c,m,y,k), "0 g 0 G"
  elseif n == 3 then
    local r, g, b = cr[1], cr[2], cr[3]
    return format("%.3f %.3f %.3f rg %.3f %.3f %.3f RG",r,g,b,r,g,b), "0 g 0 G"
  else
    local s = cr[1]
    return format("%.3f g %.3f G",s,s), "0 g 0 G"
  end
end
-- 
--  End of File `luamplib.lua'.
