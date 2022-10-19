
-- Adds a callback just before a box is shipped out, opposite to 
-- 'finish_pdfpage'.

local alloc = require('minim-alloc')
local cb = require ('minim-callbacks')
alloc.remember('minim-hooks')

local M = { }

cb.new_callback('pre_shipout', 'simple')

M.primitive_shipout = tex.shipout
function tex.shipout(nr)
    cb.call_callback('pre_shipout', nr)
    M.primitive_shipout(nr)
end

local shipout_box = alloc.new_box('minim:shipout:box')

alloc.luadef('minim:shipout', function()
    tex.box[shipout_box] = token.scan_list()
    cb.call_callback('pre_shipout', shipout_box)
    -- we must let tex do the rest, because some other package may have 
    -- redefined \shipout before us.
    tex.sprint(token.create('minim:shipout:do'))
end, 'protected')

return M

