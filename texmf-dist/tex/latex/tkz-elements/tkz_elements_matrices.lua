-- tkz_elements_matrices.lua
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

-- ----------------------------------------------------------------------------
matrix={}
function matrix: new (value)
    local type          = 'matrix'
    local rows          = #value
    local cols          = #value[1]
    local set           = value
    local det           = determinant(value)
    local o =  {set    = set,
                rows   = rows,
                cols   = cols,
                det    = det,
                type   = type }
    setmetatable(o, self)
    self.__index = self
    return o
end

function matrix.__mul(m1,m2)
  if getmetatable(m1) ~= matrix then return  k_mul_matrix(m1, m2) end  
  if getmetatable(m2) ~= matrix then return  k_mul_matrix(m2, m1) end
  return mul_matrix(m1,m2)
end

function matrix.__add(m1,m2)
  return add_matrix(m1,m2)
end

function matrix.__sub(m1,m2)
  return add_matrix(m1,k_mul_matrix(-1, m2))
end

function matrix.__pow( m, num )
  if num =='T' then 
  return transposeMatrix(m)
  else
	if num == 0 then
		return matrix:new( #m,"I" )
	end
	if num < 0 then
		local i; m,i = inv_matrix ( m )
      if not m then return m, i end
		num = -num
	end
	local mt = m
	for i = 2,num	do
		mt = mul_matrix(mt,m)
	end
	return mt
end
end

function matrix.__tostring( A )
  local mt = (A.type=='matrix' and A.set or A)
	local k = {}
	for i = 1,#mt do
		local n = {}
		for j = 1,#mt[1] do
			n[j] = display(mt[i][j])
		end
		k[i] = table.concat(n, " ")
	end
	return table.concat(k)
end

function matrix.__eq( A , B )
  local mt1 = (A.type=='matrix' and A.set or A)
  local mt2 = (B.type=='matrix' and B.set or B)
	if A.type ~= B.type then
		return false
	end

	if #mt1 ~= #mt2 or #mt1[1] ~= #mt2[1] then
		return false
	end

	for i = 1,#mt1 do
		for j = 1,#mt1[1] do
			if mt1[i][j] ~= mt2[i][j] then
				return false
			end
		end
	end
	return true
end

function matrix : square(n,...)
   local m = {}
   local t = table.pack(...)
   if n*n == #t then
      for i = 1, n do
           m[i] = {}
          for j = 1, n do
                  m[i][j] = t[n*(i-1)+j]
          end
      end
      return matrix : new (m)
   else
      return nil
   end
end

function matrix: vector (...)
  local m = {}
  local t = table.pack(...)
  for i = 1, #t do
       m[i] = {}
      m[i][1] = t[i]
  end
  return matrix : new (m)
end

function matrix : homogenization ()
  return homogenization_ (self)
end

function matrix : htm_apply (...)
  local obj,nb,t
  local tp = table.pack(...)
  obj = tp[1]
  nb = tp.n
  if nb == 1 then 
     if obj.type == "point" then
        return htm_apply_ ( self,obj )
     elseif    obj.type == "line" then 
           return  htm_apply_L_ (self,obj)
     elseif    obj.type == "triangle" then
          return   htm_apply_T_ (self,obj)
     elseif    obj.type == "circle" then
        return     htm_apply_C (self,obj)
      elseif   obj.type == "square"
            or obj.type == "rectangle"
            or obj.type == "quadrilateral"
            or obj.type == "parallelogram" then
        return     htm_apply_Q (self,obj)
      end
  else
    t = {}
     for i=1,tp.n do
    table.insert(t , htm_apply_ ( self , tp[i])) 
       end
    return table.unpack ( t )      
  end
end

function matrix: k_mul (n)
  return k_mul_matrix(n, self)
end

function matrix : get (i,j)
  return get_element_( self,i,j )
end

function matrix: inverse ()
  return inv_matrix (self)
end

function matrix: adjugate ()
  return adjugate_ (self)
end

function matrix: transpose ()
  return transposeMatrix (self)
end

function matrix: is_diagonal ()
  return isDiagonal_ (self)
end

function matrix: is_orthogonal ()
  return isOrthogonal_ (self)
end

function matrix: diagonalize () -- return two matrices D and P
  return diagonalize_ (self)
end

function matrix: print (style,fmt)
  local style = (style or 'bmatrix')
  local fmt  = (fmt or 0)
  return print_matrix (self,style,fmt)
end

function matrix: identity (n)
  return id_matrix (n)
end

-------------------------
-- homogeneous transformation matrix
function matrix : htm (phi,a,b,sx,sy)
  local tx = (a or 0)
  local ty = (b or 0)
  local sx = (sx or 1)
  local sy = (sy or 1)
  local phi = (phi or 0)
  return matrix : square (3,sx*math.cos(phi),-math.sin(phi),tx,math.sin(phi),sy*math.cos(phi),ty,0,0,1)
end
-------------------------

function matrix: is_orthogonal ()
  return isOrthogonal_ (self)
end

return matrix

