xB = value(8)
z.A = point : new ( 0,0 ) 
z.B = point : new ( 
xB,0 )
L.AB = line : new ( z.A , z.B )
S = L.AB : square ()
_,_,z.C,z.D = get_points (S)
z.F = S.ac : projection (z.B)
L.BF = line : new (z.B,z.F)
T.ABC = triangle : new ( z.A , z.B , z.C )
L.bi = T.ABC : bisector (2)
z.c = L.bi.pb
L.Cc = line : new (z.C,z.c)
z.I = intersection (L.Cc,L.BF)