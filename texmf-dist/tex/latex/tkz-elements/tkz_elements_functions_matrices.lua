-- tkz_elements_functions_matrices.lua
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
function print_matrix(m,mstyle)
  local mstyle = (mstyle or 'bmatrix')
  local m = (m.type=='matrix' and m.set or m)
  tex.sprint("$")
  tex.sprint("\\begin{"..mstyle.."}")
    for i = 1, #m do
        for j = 1, #m[1] do 
          local x = m[i][j]
          local st = display(x)
          tex.sprint(st)
          if j < #m[1] then tex.sprint(" & ")  end
       end
       tex.sprint("\\\\")
    end
    tex.sprint("\\end{"..mstyle.."}")
    tex.sprint("$")
end

function print_array(matrix)
local mdata = (matrix.type=='matrix' and matrix.set or matrix)
tex.sprint("\\{%")
  for i = 1, #mdata do
    local row = mdata[i]
    local row_str = "{\\{"
    for j = 1, #row do
        row_str = row_str .. " " .. tostring(row[j])
        if j < #row then
            row_str = row_str .. "  ,"
        end
    end
    if (i~=#mdata) and (j~=#row) then
   if i>1 then row_str = row_str .. " \\}}," else row_str = row_str .. " \\}}," end
    tex.sprint(row_str) 
else
  if i>1 then row_str = row_str .. " \\}}" else row_str = row_str .. " \\}}" end
   tex.sprint(row_str) 
    end
end
tex.sprint("\\}")
end

function mul_matrix(A, B)
local adata = (A.type=='matrix' and A.set or A)
local bdata = (B.type=='matrix' and B.set or B)
local C = {}
  for i = 1, #adata do
      C[i] = {}
      for j = 1, #bdata[1] do
          local num = adata[i][1] * bdata[1][j]
          for k = 2, #adata[1] do
              num = num + adata[i][k] * bdata[k][j]
          end
          C[i][j] = num
      end
  end
  return  matrix : new (C)
end


function add_matrix(A, B)
local adata = (A.type=='matrix' and A.set or A)
local bdata = (B.type=='matrix' and B.set or B)
    local S = {}
    for i = 1, #adata do
        local T = {}
        S[i] = T
        for j = 1, #adata[1] do
            T[j] = adata[i][j] + bdata[i][j]
        end
    end
    return matrix : new (S)
end

function k_mul_matrix(n, A)
local adata = (A.type=='matrix' and A.set or A)
    local S = {}
    for i = 1, #adata, 1 do
        local T = {}
        S[i] = T
        for j =1, #adata[1], 1 do
            T[j] = n * adata[i][j]
        end
    end
    return matrix : new (S)
end


function transposeMatrix(A)
local mdata = (A.type=='matrix' and A.set or A)
  local transposedMatrix = {}
  for i = 1, #mdata[1] do
      transposedMatrix[i] = {}
      for j = 1, #mdata do
          transposedMatrix[i][j] = mdata[j][i]
      end
  end
  return matrix : new  (transposedMatrix)
end

-- Function to calculate the determinant of a square matrix
function determinant(A)
   local matrix = (A.type=='matrix' and A.set or A)
   if #matrix == #matrix[1] then
    local n = #matrix
    if n == 1 then
        return matrix[1][1] -- Base case for 1x1 matrix
    elseif n == 2 then
        return matrix[1][1] * matrix[2][2] - matrix[1][2] * matrix[2][1] -- Base case for 2x2 matrix
    else
        local det = 0
        for j = 1, n do
            local minor = {}
            for i = 2, n do
                minor[i - 1] = {}
                for k = 1, n do
                    if k ~= j then
                        minor[i - 1][#minor[i - 1] + 1] = matrix[i][k]
                    end
                end
            end
            det = det + ((-1)^(j + 1)) * matrix[1][j] * determinant(minor) -- Recursive call for larger matrices
        end
        return det
    end
 else return nil end
end

function check_square_matrix (A)
   local matrix = (A.type=='matrix' and A.set or A)
   if #matrix == #matrix[1]
   then
      return true
   else
      return false
   end
end


function id_matrix (n)
 local   identityMatrix = {}
   for i = 1, n do
       identityMatrix[i] = {}
       for j = 1, n do
           if i == j then
               identityMatrix[i][j] = 1
           else
               identityMatrix[i][j] = 0
           end
       end
   end
   return matrix : new (identityMatrix)
end

function inverse_2x2(A)
     local m = (A.type=='matrix' and A.set or A)
    local a, b, c, d = m[1][1], m[1][2], m[2][1], m[2][2]
    local D = A.det
    if D == 0 then
        return nil  -- La matrice n'est pas inversible
    else
       local inv ={}
       inv[1]={}
        inv[1][1] = d / D
            inv[1][2] = -b / D
            inv[2]={}
            inv[2][1] = -c / D
            inv[2][2] = a / D
       return matrix : new (inv)
    end
end

function adjugate_(A)
   local m = (A.type=='matrix' and A.set or A)
   if #m == 2 then
     local a,b,c,d = m[2][2],-m[1][2],- m[2][1],m[1][1]
     return matrix : new ({{a,b},{c,d}})
   elseif #m == 3 then
    local a, b, c = m[1][1], m[1][2], m[1][3]
    local d, e, f = m[2][1], m[2][2], m[2][3]
    local g, h, i = m[3][1], m[3][2], m[3][3]
    return transposeMatrix(matrix : new ({
        {e * i - f * h, -(d * i - f * g), d * h - e * g},
        {-(b * i - c * h), a * i - c * g, -(a * h - b * g)},
        {b * f - c * e, -(a * f - c * d), a * e - b * d}
    }))
  else  return nil
  end
end

function inverse_3x3(A)
    local D = A.det
    if D == 0 then
        return nil  -- La matrice n'est pas inversible
    else
        local adj = adjugate_(A)
        local m = (adj.type=='matrix' and adj.set or adj)
         local inv = {}
         for i = 1, 3 do
             inv[i] = {}
             for j = 1, 3 do
                 inv[i][j] = m[i][j] / D
             end
         end
         return matrix : new (inv)
    end
end

-- inverse only for 2x2 or 3x3 matrix
function inv_matrix (A)
  if A.det ==0 then tex.print("Matrix not inversible: det = 0") return nil 
  else
   local M = (A.type=='matrix' and A.set or A)
        local n = #M
     if n == 2 then 
        local m = (A.type=='matrix' and A.set or A)
       local a, b, c, d = m[1][1], m[1][2], m[2][1], m[2][2]
       local D = A.det
          local inv ={}
          inv[1]={}
           inv[1][1] = d / D
               inv[1][2] = -b / D
               inv[2]={}
               inv[2][1] = -c / D
               inv[2][2] = a / D
          return matrix : new (inv)
      else
        local D = A.det
            local adj = adjugate_(A)
            local m = (adj.type=='matrix' and adj.set or adj)
             local inv = {}
             for i = 1, 3 do
                 inv[i] = {}
                 for j = 1, 3 do
                     inv[i][j] = m[i][j] / D
                 end
             end
             return matrix : new (inv)
        end
       end
end

function diagonalize_ (A)
    local m = (A.type=='matrix' and A.set or A)
    local trace =  m[1][1] + m[2][2]
    local a,b = m[1][1],m[1][2]
    local det = A.det
    local D = trace * trace - 4 * det
    if D > 0 then
      local va1 = (trace + math.sqrt(D)) / 2
      local va2 = (trace - math.sqrt(D)) / 2
     return matrix : new ({{va1,0},{0,va2}}),
            matrix : new ({{1,1},{ (va1 - a )/b, (va2 - a)/b}})
    else
      local va1 = point (trace/2 , math.sqrt(-D)/ 2) 
      local va2 = point (trace/2 , - math.sqrt(-D)/ 2) 
      return matrix : new ({{va1,0},{0,va2}})--,
          --   matrix : new ({{1,1},{ (va1 - a )/b, (va2 - a)/b}})
    end
  end

  function isDiagonal_(A)
     local matrix = (A.type=='matrix' and A.set or A)
   if  check_square_matrix (A) == true
   then
      for i = 1, #matrix do
          for j = 1, #matrix[1] do
              if i ~= j and matrix[i][j] ~= 0 then
                  return false
              end
          end
      end
      return true
   else
      return false
   end
  end

  function isOrthogonal_(A)
     local m = (A.type=='matrix' and A.set or A)
    if  (check_square_matrix (A) == true) and (A.det ~=0)
    then
      local mT = transposeMatrix (A)
      local mI = inv_matrix (A)
      if mT == mI then return true else  return false end
    else
       return false
    end
  end
  
  
  function homogenization_ (A)
    local m = (A.type=='matrix' and A.set or A)
   if A.cols ~= 1 then
       return nil
    else
      local a,b,c
      a=m[1][1]
      b=m[2][1]
      c= 1
     return matrix : new ({{a},{b},{c}}) 
    end
  end

  function get_element_( A,i,j )
      local m = (A.type=='matrix' and A.set or A)
  	if m[i] and m[i][j] then
  		return m[i][j]
  	end
  end   
  
  function get_htm_point(A)
           local m = (A.type=='matrix' and A.set or A)
       return point : new( m[1][1],m[2][1])
   end

  function htm_apply_ (A,z)
    local     V = homogenization_ ( 1/scale*z.mtx)
    local     W = A * V
   return     get_htm_point(W)
  end
  
  function htm_apply_L_ (A,obj)
    local x,y
    x = htm_apply_ (A,obj.pa)
    y = htm_apply_ (A,obj.pb)
    return line : new  (x,y)
  end
    
  function htm_apply_C_ (A,obj)
    local x,y
    x = htm_apply_ (A,obj.center)
    y = htm_apply_ (A,obj.through)
    return circle : new  (x,y)
  end
  
  function htm_apply_T_ (A,obj)
    local x,y,z
    x = htm_apply_ (A,obj.pa)
    y = htm_apply_ (A,obj.pb)
    z = htm_apply_ (A,obj.pc)
    return triangle : new  (x,y,z)
  end
  
  function htm_apply_Q_ (A,obj)
    local x,y,z,t
    x = htm_apply_ (A,obj.pa)
    y = htm_apply_ (A,obj.pb)
    z = htm_apply_ (A,obj.pc)
    t = htm_apply_ (A,obj.pd)
    if   obj.type    == "square" then 
      return square : new  (x,y,z,t)
    elseif  obj.type == "rectangle" then 
      return rectangle : new  (x,y,z,t)
    elseif  obj.type == "parallelogram" then 
      return parallelogram : new  (x,y,z,t)   
    elseif  obj.type == "quadrilateral"  then  
      return quadrilateral : new  (x,y,z,t)   
    end
  end