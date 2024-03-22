.PS
# Planes.m4
threeD_init
NeedDpicTools

# These 3D diagrams are like many others: define the surface facets,
# use normal vectors to determine visibility, sort and plot the visible
# facets from back to front.

#                           Store a point as x_[i], y_[i], z_[i]
define(`mktriple',`
  x_[$1] = $2
  y_[$1] = $3
  z_[$1] = $4')
#                           Recover point coordinates
define(`triple',`x_[$1], y_[$1], z_[$1]')

define(`facetnormal',`cross3D(
 diff3D(triple($1*3+1),triple($1*3)),
 diff3D(triple($1*3+2),triple($1*3+1)))')

define(`facetcenter',`sprod3D(0.5,sum3D(triple($1*3),triple($1*3+2)))')

#                           Create npositive, arrays dcosine[1..npositive]
#                           and index ix[1..npositive] of sorted facets
#                           Uses macros facetnormal(i) and facetcenter(i)
define(`processfacets',`
  npositive = 0
  for i=1 to `$1' do {
    mktriple(0,facetnormal(i))
    dx = dot3D(triple(0),View3D)
    if dx > 0 then {
      dcosine[i] = dx/length3D(triple(0)) # direction cosine normal wrt View3D
      npositive +=1
      dist[npositive] = dot3D(facetcenter(i),View3D) # distance
      ix[npositive] = i
      }
    }
  dpquicksort(dist,1,npositive,ix) ')

ifelse(1,1,`
Threeplanes: [
#                           Size parameters
  a = 3/2
  b = 0.4
  d =  1
#                           Define intersecting lines in the plane
  A0: -a,-b
  A1:  a,-b
  B0: Rot_(A0,120)
  B1: Rot_(A1,120)
  C0: Rot_(A0,240)
  C1: Rot_(A1,240)

#                           Intersections
define(`lintersect',`intersect_(`$1'0,`$1'1,`$2'0,`$2'1)')
  AB: lintersect(A,B)
  BC: lintersect(B,C)
  CA: lintersect(C,A)

#                           Facets are rectangles here; store 3 corners
define(`mkfacet',`
  mktriple((`$1')*3,   0,`$2'.x,`$2'.y)
  mktriple((`$1')*3+1, 0,`$3'.x,`$3'.y)
  mktriple((`$1')*3+2,-d,`$3'.x,`$3'.y)
  ')
#                           Define the facets
  mkfacet(m4inx,A0,CA) mkfacet(m4inx,CA,A0)
  mkfacet(m4inx,CA,AB) mkfacet(m4inx,AB,CA)
  mkfacet(m4inx,AB,A1) mkfacet(m4inx,A1,AB)

  mkfacet(m4inx,B0,AB) mkfacet(m4inx,AB,B0)
  mkfacet(m4inx,AB,BC) mkfacet(m4inx,BC,AB)
  mkfacet(m4inx,BC,B1) mkfacet(m4inx,B1,BC)

  mkfacet(m4inx,C0,BC) mkfacet(m4inx,BC,C0)
  mkfacet(m4inx,BC,CA) mkfacet(m4inx,CA,BC)
  mkfacet(m4inx,CA,C1) mkfacet(m4inx,C1,CA)
  nfacets = m4x

#                           Wierd color
define(`colr',`ifelse(`$1',,"white",
 `rgbstring(`$1',ifelse(`$2',,`$1',`$2'),ifelse(`$3',,`$1',`$3'))')')

#                           Recover the 4th corner and draw
define(`drawfacet',`
  NW_facet: project(triple(($1)*3))
  NE_facet: project(triple(($1)*3+1))
  SE_facet: project(triple(($1)*3+2))
  SW_facet: project(x_[($1)*3+2],y_[($1)*3],z_[($1)*3])
  N_facet: 0.5 between NW_facet and NE_facet
  line from N_facet to NE_facet then to SE_facet then to SW_facet \
    then to NW_facet then to N_facet shaded colr(`$2',`$3',`$4')
# fill_(ifelse(`$2',,1,`(1-`$2')'))
  ')

#                           View angles azimuth, elevation, rotation (degrees)
  setview( 10, 40 )

#                           Draw facets, shading with view cosines
  processfacets(nfacets)
  for i=1 to npositive do { drawfacet(ix[i],max(0,1-2*dcosine[ix[i]]),
    dcosine[ix[i]],
    dcosine[ix[i]])
# for i=1 to npositive do { drawfacet(ix[i],dcosine[ix[i]]) 
  }

] # Threeplanes
')

# Bowl
#                           vertx_(facet_no,vertex_no)
  define vertx_ { ($1-1)*nvertices + $2 }

#                           Normal vector to a facet
define(`facetnormal',`cross3D(
 diff3D(triple(vertx_($1,2)),triple(vertx_($1,1))),
 diff3D(triple(vertx_($1,4)),triple(vertx_($1,1))))')

#                           Facet center
define(`facetcenter',`sprod3D(1/4,sum3D(
 sum3D(triple(vertx_(`$1',1)),triple(vertx_(`$1',2))),
 sum3D(triple(vertx_(`$1',3)),triple(vertx_(`$1',4)))))')

define(`drawplane',`
  NW_plane: project(triple(vertx_($1,1)))
  SW_plane: project(triple(vertx_($1,2)))
  SE_plane: project(triple(vertx_($1,3)))
  NE_plane: project(triple(vertx_($1,4)))
  N_plane: 0.5 between NW_plane and NE_plane
  shd = (`$2')^(1/4)
  line from N_plane to NE_plane then to SE_plane then to SW_plane \
    then to NW_plane then to N_plane \
    fill_(ifelse(`$2',,1,shd)) outlined rgbstring(shd,shd,shd)
# line from NW_plane to NE_plane
  line from SW_plane to SE_plane
  ')

ifelse(1,1,`
  nvertices = 4             # vertices per facet
Bowl: [
  elevation = 30
  setview( 0, 30 )
  nplanes = 40
  bigradius = 2
  smallradius = 1
  cupht = 1.5
  thin = smallradius/10
#                           Define the facet corners
  for i=1 to nplanes do {
    mktriple(vertx_(i,1),rot3Dz((i-1)/nplanes*twopi_,bigradius,0,0))
    mktriple(vertx_(i,2),rot3Dz((i-1)/nplanes*twopi_,smallradius,0,-cupht))
    mktriple(vertx_(i,3),rot3Dz((i  )/nplanes*twopi_,smallradius,0,-cupht))
    mktriple(vertx_(i,4),rot3Dz((i  )/nplanes*twopi_,bigradius,0,0))
    mktriple(vertx_(nplanes+i,1),triple(vertx_(i,4)))
    mktriple(vertx_(nplanes+i,2),triple(vertx_(i,3)))
    mktriple(vertx_(nplanes+i,3),triple(vertx_(i,2)))
    mktriple(vertx_(nplanes+i,4),triple(vertx_(i,1)))
    }
# for i=1 to nplanes do {
#   mktriple(vertx_(i,1),rot3Dz((i-1)/nplanes*twopi_,bigradius,0,0))
#   mktriple(vertx_(i,2),rot3Dz((i-1)/nplanes*twopi_,smallradius,0,-cupht))
#   mktriple(vertx_(i,3),rot3Dz((i-1)/nplanes*twopi_,smallradius-thin,0,-cupht))
#   mktriple(vertx_(i,4),rot3Dz((i-1)/nplanes*twopi_,bigradius-thin,0,0))
#   }
#                           Find the visible facets and sort
  processfacets(nplanes*2)

  for i=1 to npositive do { drawplane(ix[i],dcosine[ix[i]]) }
  ellipse wid 2*bigradius ht 2*bigradius*sin(elevation*dtor_) at project(0,0,0)

] #with .sw at Threeplanes.se
')

.PE
