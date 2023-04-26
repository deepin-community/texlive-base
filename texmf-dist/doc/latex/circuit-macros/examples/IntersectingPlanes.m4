.PS
## IntersectingPlanes.m4
## Projection of an object defined by 4-sided facets
threeD_init
NeedDpicTools

  setview( 10, 45)
#                           Define the object by its facets:
#                           size parameters
  a = 3/2
  b = 0.4
#                           depth
  d = -1
#                           line ends and intersections
  A0: -a,-b
  A1:  a,-b
  B0: Rot_(A0,120)
  B1: Rot_(A1,120)
  C0: Rot_(A0,240)
  C1: Rot_(A1,240)
  AB: intersect_(A0,A1,B0,B1)
  BC: intersect_(B0,B1,C0,C1)
  CA: intersect_(C0,C1,A0,A1)

  "A0" at project(0,A0.x,A0.y) rjust
  "A1" at project(0,A1.x,A1.y) ljust
  "B0" at project(0,B0.x,B0.y) ljust
  "B1" at project(0,B1.x,B1.y) rjust
  "C0" at project(0,C0.x,C0.y) ljust
  "C1" at project(0,C1.x,C1.y) rjust
#                           facet location parameters
define(`facet',`$1.x,$1.y, $2.x,$2.y')
array2(ffc,1,facet(A0,CA))
array2(ffc,2,facet(CA,A0))
array2(ffc,3,facet(CA,AB))
array2(ffc,4,facet(AB,CA))
array2(ffc,5,facet(AB,A1))
array2(ffc,6,facet(A1,AB))

array2(ffc,7,facet(AB,B0))
array2(ffc,8,facet(B0,AB))
array2(ffc,9,facet(BC,AB))
array2(ffc,10,facet(AB,BC))
array2(ffc,11,facet(B1,BC))
array2(ffc,12,facet(BC,B1))

array2(ffc,13,facet(C0,BC))
array2(ffc,14,facet(BC,C0))
array2(ffc,15,facet(BC,CA))
array2(ffc,16,facet(CA,BC))
array2(ffc,17,facet(CA,C1))
array2(ffc,18,facet(C1,CA))
nfacets = 18
#                           facet corners
define(`fSW',`0,ffc[($1,1)],ffc[($1,2)]')
define(`fNW',`d,ffc[($1,1)],ffc[($1,2)]')
define(`fSE',`0,ffc[($1,3)],ffc[($1,4)]')
define(`fNE',`d,ffc[($1,3)],ffc[($1,4)]')
#                           facet centre and normal
define(`Fcentre',`sprod3D(0.5,sum3D(fSW(i),fNE(i)))')
define(`Fnoarmal',`cross3D(diff3D(fSE($1),fSW($1)),diff3D(fNE($1),fSE($1)))')
#                           facet drawing routine
define(`drawfacet',`
  Loopover_(`X', `X: project(m4xpand(f`'X)(`$1'));', SW,SE,NE,NW)
  line from SW to SE then to NE then to NW then to SW shaded ifelse(`$3',,
    "white", `rgbstring(`$3',ifelse(`$4',,`$3',`$4'),ifelse(`$5',,`$3',`$5'))') 
  ifelse(`$2',,,`sprintf("%g",$2) at 1/2 between NW and SE') ')

#                           The rest is generic: sort visible facets by
#                           distance and plot (but with custom colors)
  nvis = 0
  smax = 0
  for i=1 to nfacets do {
    if dot3D(View3D,Fnoarmal(i)) >= 0 then {
      nvis +=1
      s[nvis] = dot3D(View3D,Fcentre(i))
      smax = max(smax,s[nvis])
      ix[nvis] = i
    } }
  dpquicksort(s,1,nvis,ix)

  for i=1 to nvis do { drawfacet(ix[i],ix[i],sqrt(i/nvis),i/nvis) }

.PE
