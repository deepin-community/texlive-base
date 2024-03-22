.PS
# Shadow.m4
gen_init
NeedDpicTools
s_init(HSV)

divert(-1)
                               `shadowellipse(options,text)
                                Draws a shadowed ellipse
                                with gradient from white at the top to
                                hsv-specified color at the bottom
                                Default is uniform lightgray shade
                                Arg 2 is a text label written at the center'
define(`shadowellipse',`[ Orig: Here
 m4shadow_keys(`$1')
 [
   ellipse wid m4wid ht m4ht invis shaded m4shadow ] wid 0 ht 0 \
     at (m4shadowthick+m4thick bp__/2,-(m4shadowthick+m4thick bp__/2))
#    at ((m4shadowthick)/2,-(m4shadowthick)/2)
ifelse(m4hue,,,`
 define pElBshade { v = m4ht*($`'1)
   if v < m4rad then { h = (m4wid/2-m4rad)+sqrt(m4rad^2-(m4rad-v)^2) } \
   else { if v < m4ht-m4rad then { h = m4wid/2 } \
   else { h = (m4wid/2-m4rad)+sqrt(m4rad^2-(m4rad-(m4ht-v))^2) } }
   line from (-h,v) to (h,v) thick m4thick outlined rgbstring($`'2,$`'3,$`'4)
   }
 nsteps = rnd(m4ht/(m4thick bp__)*1.1)
 hsvtorgb(m4hue,m4sat,m4val,r,g,b)
 ShadeObject(pElBshade,nsteps,
   0,   r, g, b,
   1,   1, 1, 1) with .c at Orig ')
  Ellipse: ellipse ht m4ht wid m4wid thick m4thick outline m4outlined \
   at Orig ifelse(m4hue,,shaded m4shaded)
  ifelse(`$2',,,`m4lstring(`$2',"`$2'") at Ellipse')
 `$3']')
                               `shadowbox(options,text) Draws a shadowed box
                                with gradient from white at the top to
                                hsv-specified color at the bottom
                                Default is uniform lightgray shade
                                Arg 2 is a text label written at the center'
define(`shadowbox',`[ Orig: Here
 m4shadow_keys(`$1')
 [
   box invis rad m4rad ht m4ht wid m4wid shaded m4shadow ] wid 0 ht 0 \
     at (m4shadowthick+m4thick bp__/2,-(m4shadowthick+m4thick bp__/2))
#  box rad m4rad+m4thick bp__/2+m4shadowthick/2 ht m4ht wid m4wid \
#    thick m4shadowthick/(1bp__) outlined m4shadow ] wid 0 ht 0 \
#    at ((m4shadowthick+m4thick bp__)/2,-(m4shadowthick+m4thick bp__)/2)
ifelse(m4hue,,,`
 define pBxBshade { v = m4ht*($`'1)
   if v < m4rad then { h = (m4wid/2-m4rad)+sqrt(m4rad^2-(m4rad-v)^2) } \
   else { if v < m4ht-m4rad then { h = m4wid/2 } \
   else { h = (m4wid/2-m4rad)+sqrt(m4rad^2-(m4rad-(m4ht-v))^2) } }
   line from (-h,v) to (h,v) thick m4thick outlined rgbstring($`'2,$`'3,$`'4)
   }
 nsteps = rnd(m4ht/(m4thick bp__)*1.1)
 hsvtorgb(m4hue,m4sat,m4val,r,g,b)
 ShadeObject(pBxBshade,nsteps,
   0,   r, g, b,
   1,   1, 1, 1) with .c at Orig ')
  Box: box rad m4rad ht m4ht wid m4wid thick m4thick outline m4outlined \
   at Orig ifelse(m4hue,,shaded m4shaded)
  ifelse(`$2',,,`m4lstring(`$2',"`$2'") at Box')
 `$3']')
define(`m4shadow_keys',
# Box size parameters
`setkey_(`$1',ht,boxht)dnl
 setkey_(`$1',wid,boxwid)dnl
 setkey_(`$1',rad,boxht/8)dnl
 setkey_(`$1',thick,linethick)dnl
# Shadow thickness
 setkey_(`$1',shadowthick,2*lthick)dnl
# HSV color for gradient shading
 setkey_(`$1',hue)dnl Default is blank for a shade fill;
 setkey_(`$1',sat,1)dnl
 setkey_(`$1',val,1)dnl
# Named colors
 setkey_(`$1',shaded,"lightgray",N)dnl
 setkey_(`$1',outlined,"gray",N)dnl
 setkey_(`$1',shadow,"lightgray",N)dnl
')

divert(0)dnl

w = 0.3
boxwid = w
dh = 30
# Hue from 0 to 360
T:[ for i=0 to 361 by dh do { shadowbox(hue=i) } ]
  { s_box(hue=0) at T.w rjust; s_box(hue=360) at T.e ljust }
  { for i=0 to 361 by dh do { s_box("%g",i) at T.nw+(w/2+i/dh*w,0) above } }
  { s_box(hue) at T.n+(0,12bp__) above }

# Hue from 0 to 360; sat=0.5; val=0.5
Ta:[ for i=0 to 361 by dh do { shadowbox(hue=i;sat=0.5;val=0.5) } ] \
   with .nw at last [].sw
  { s_box(`\shortstack[r]{sat=0.5\\val=0.5}') at Ta.w rjust }

# Hue = 0; sat=0 to 1
U:[ for i=0 to 361 by dh do { shadowbox(hue=0;sat=i/360) } ] \
   with .nw at last [].sw
  { s_box(`\shortstack[r]{hue=0\\sat=0}') at U.w rjust
    s_box(sat=1) at U.e ljust }

# Hue = 0; val=0 to 1
V:[ for i=0 to 361 by dh do { shadowbox(hue=0;val=i/360) } ] \
   with .nw at last [].sw
  { s_box(`\shortstack[r]{hue=0\\val=0}') at V.w rjust
    s_box(val=1) at V.e ljust }

# Miscellaneous
W:[
   shadowbox
   DefineRGBColor(verylight,0.95,0.95,0.95); shadowbox(shaded=verylight)
   shadowbox(hue=0;val=0)
   DefineHSVColor(cx,110,0.5,0.5); shadowbox(shaded=cx)
   shadowbox(shaded="yellow")
   DefineHSVColor(lx,120,0.4,0.5); shadowbox(hue=120;sat=0.3;val=0.2;shadow=lx)
 ] with .nw at last [].sw

ellipsewid = w
#linethick = 5
X:[
   shadowellipse(shadowthick=lthick)
   ellipse thick 5
   ellipse thick 5 shaded "gray"
 ] with .nw at last [].sw+(0,-0.1)

.PE
