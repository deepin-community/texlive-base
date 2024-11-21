-- tkz_elements_functions_maths.lua
-- date 2024/07/16
-- version 2.30c
-- Copyright 2024  Alain Matthes
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License, either version 1.3
-- of this license or (at your option) any later version.
-- The latest version of this license is in
--   http://www.latex-project.org/lppl.txt
-- and version 1.3 or later is part of all distributions of LaTeX
-- version 2005/12/01 or later.
-- This work has the LPPL maintenance status “maintained”.
-- The Current Maintainer of this work is Alain Matthes.

-- constant
tkzphi      = (1+math.sqrt(5))/2
tkzinvphi   = (math.sqrt(5)-1)/2
tkzsqrtphi  =  math.sqrt(tkzphi)
---------------------------------------------------------------------------
function round(num, idp)
  return topoint(string.format("%." .. (idp or 0) .. "f", num))
end

function tkzround( num, idp )
	local mult = 10 ^ ( idp or 0 )
	return math.floor( num * mult + 0.5 ) / mult
end  

function dot_product (a,b,c)
   return (b-a)..(c-a)
end

function Cramer33(a1,a2,a3,b1,b2,b3,c1,c2,c3)
  return a1*b2*c3+a3*b1*c2+a2*b3*c1-a3*b2*c1-a1*b3*c2-a2*b1*c3
end

function Cramer22(a1,a2,b1,b2)
  return a1*b2-a2*b1
end

function aligned ( m,a,b )
    local z
    z = (b-a)/(m-b)
      if math.abs(z.im) < tkz_epsilon
        then
            return true
        else
            return false
        end
end 

function islinear (z1,z2,z3)
     local dp
    dp = (z2-z1) ^ (z3-z1)
    if math.abs(dp) < tkz_epsilon 
    then 
        return true
    else 
        return false
    end
end

function isortho (z1,z2,z3)
   local dp
   dp = (z2-z1) .. (z3-z1)
   if math.abs(dp) < tkz_epsilon 
    then 
        return true
    else 
        return false
    end
end

function parabola (a,b,c)
   local xa,xb,xc,ya,yb,yc
   xa = a.re
   ya = a.im
   xb = b.re
   yb = b.im
   xc = c.re
   yc = c.im
   D = (xa-xb)*(xa-xc)*(xb-xc)
   A = (xc*(yb-ya) + xb*(ya-yc)+xa*(yc-yb))/D
   B = (xc*xc*(ya-yb)+xb*xb*(yc-ya)+xa*xa*(yb-yc))/D
   C = (xb*xc*(xb-xc)*ya + xc*xa*(xc-xa)*yb +xa*xb*(xa-xb)*yc)/D
   return A,B,C
end

function value (v)
   return scale * v
end

function real (v)
   return v/scale
end

function get_angle (a,b,c)
  return angle_normalize_(get_angle_( a,b,c ))
end 
   
function get_angle_( a,b,c )
	 return point.arg ((c-a)/(b-a))
end

function angle_normalize (a)
return angle_normalize_ (a)
end

function angle_normalize_ (a)
    while a < 0 do
        a = a + 2*math.pi
    end
    while a >= 2*math.pi do
        a = a - 2*math.pi
    end
    return a
end

function barycenter (...)
   return barycenter_ (...)
end

function swap(a,b)
   local t=a
   a=b
   b=t
   return a,b
end
-- real func
function is_integer(x)
    return x == math.round(x)
end

function near_integer(x)
  local i,r  = math.modf  (x)
  if is_zero (r) then 
   return  true
 end
    return false
end

function residue (x)
  dp,ip =  math.modf (x)
  return ip
end

function is_zero (x)
 return math.abs(x) < tkz_epsilon 
end 

function set_zero (x)
  if is_zero (x) then x=0 end
  return x
end

function math.round(num)
  return math.floor(num + 0.5)
end

function checknumber(x)
   if type(x) == 'table' then 
      return x 
   else
     if string.find(x, "e") then
        return string.format("%.12f",x)
      else
          return x
      end
   end
end

function decimal (x)
   if string.find(x, "e") then
      return string.format("%.12f",x)
   else
      return x
   end
end

function format_number(number, dcpl)
  if type(number) == 'table' then return number 
  else
    local format_string = string.format("%%.%df", dcpl)
    return string.format(format_string, number)
  end
end

function get_sign(number)
  local sgn
     if math.abs(number) < tkz_epsilon then
         sgn = ""
     elseif number > 0 then
         sgn = "+"
     else
        sgn = "-"
     end
     return sgn
end

function solve_quadratic(a, b, c)
  local root1, root2,delta ,sqrtdelta
  if (type(a) == "number") and (type(b) == "number") and                (type(c) == "number") 
  then
     delta = b*b - 4*a*c
    if delta < 0 then
       root1, root2 =  solve_cx_quadratic(a, b, c)
      elseif delta == 0 then
         root1 = -b / (2*a)
         root2 = -b / (2*a)
       else
          sqrtdelta = math.sqrt(delta)
           
         root1 = (-b + sqrtdelta) / (2*a)
         root2 = (-b - sqrtdelta) / (2*a)     
       end
  else 
    root1, root2 = solve_cx_quadratic(a, b, c)
  end

   return root1, root2 -- Two real roots
end

function solve_cx_quadratic(a, b, c)
    local d     = b*b - 4*a*c
    local dcx   = point.sqrt(d)  
    local root1 = (- b + dcx) / (2*a)
    local root2 = (- b - dcx) / (2*a)  
    return root1, root2
end

-- function solve_cubic(a, b, c, d)
--     local p       = (3*a*c - b*b)/(3*a*a)
--     local q       = (2*b*b*b - 9*a*b*c + 27*a*a*d)/(27*a*a*a)
--     local delta   = q*q+4*p*p*p/27
--     local offset  = - b / (3*a)
--     if delta > tkz_epsilon then
--          local r = (- q + math.sqrt(delta))/2
--          local s = (- q - math.sqrt(delta))/2
--          if r > 0 then
--              u = r^(1/3)
--          else
--              u = -(-r)^(1/3)
--          end
--          if s > 0 then
--             v = s^(1/3)
--          else
--             v = -(-s)^(1/3)
--          end
--          return u + v + offset
--      end
--      if delta < 0 then
--       local u = 2 * math.sqrt( - p / 3)
--       local v = math.acos(((3*q)/(2*p)) * math.sqrt( -3 / p)) / 3
--       local x1 = u * math.cos(v)  + offset
--       local x2 = u * math.cos(v + 2 * math.pi/3) + offset
--        local x3 = u * math.cos(v - 2 * math.pi/3) + offset
--       return {x1,x2,x3}
--        end
-- if delta == 0 then
--         return {3*q/p+offset,-3*q/(2*p)+offset,-3*q/(2*p)+offset}
--        end
-- end

function display_real (r)
  local format_string,format_string
  if r == nil then  return ""
    else
      if near_integer ( r ) 
         then 
           r = math.round ( r )
           format_string = string.format("%%.%df", 0)
         else
           format_string = string.format("%%.%df", tkz_dc)
      end
   local st = string.format(format_string , r)
   return st
 end
end


function display_imag (r)
  local sgn
  sgn = get_sign (r)
  r = math.abs(r)
  if math.abs(r-1) < tkz_epsilon then
     r = nil
   elseif near_integer ( r ) then
     r = math.abs(math.round(r))
  end
  st = display_real (r)
  return sgn,st
end

function display (z)
  if (type(z) == "number") then return display_real (z)     else
      local real, imag
      real = z.re
      imag = z.im
 if is_zero ( imag ) then
  return display_real (real)
 else
   str = display_real (real)
   sgni,sti = display_imag (imag)
   if str == "0"  then 
     str=""
      sgni = "" end
 local  st = str ..sgni..sti.."i"
  return st
 end
end
end
