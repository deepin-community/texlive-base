.PS
# cbresistor.m4
# https://tex.stackexchange.com/questions/709339/create-command-with-decoration-in-tikz
# https://www.google.com/search?client=firefox-b-d&q=resistor+color+code
cct_init
divert(-1)

                                `cbresistor(linespec, keys)
                                 keys:
                                   lgth=expr; wdth=expr;
                                   body=body attributes, e.g. shaded "green"
                                   type=A|B; pinched body shape
                                   colors=color:color:...;
                                     Up to 6 colors, a color may be nul '
define(`cbresistor',`eleminit_(`$1')
 pushkeys_(`$2',`lgth:dimen_/2; wdth:dimen_/5; body::N; colors::N; type::N')dnl
{line to rvec_(max(0,rp_len/2-m4lgth/2),0) thick linethick*3/2; M4cbW: Here
 ifelse(m4type,B,
  `[L:rotbox(m4lgth*3/23, m4wdth, shaded "darkgray" m4body,r=m4wdth/20)
    C:rotbox(m4lgth*17/23, m4wdth*9/10, shaded "darkgray" m4body) \
       with .W at L.E
    R:rotbox(m4lgth*3/23, m4wdth, shaded "darkgray" m4body,r=m4wdth/20) \
       with .W at C.E] with .L.W at Here; move to last [].R.E',
  `rotbox(m4lgth, m4wdth, shaded "darkgray" m4body) with .W at Here')
 ifelse(m4colors,,,`define(`m4bw',(m4lgth/23))dnl
   definergbcolor(silver,0.75,0.75,0.75)
   definergbcolor(gold,1,215/255,0)
   stacksplit_(`cbrstack',m4colors,:)stackreverse_(`cbrstack')dnl
   stackargs_(`m4pos',22,17,12,7,5,2)dnl
   stackdo_(`cbrstack',`ifelse(cbrstack,nul,,
    `{ move to M4cbW+vec_(m4pos*m4bw-m4bw/2,0)
       define(`m4ctr',ifelse(m4type,B,eval((m4pos>3)*(m4pos<20)),0))dnl
       line m4colorfix(outlined,cbrstack) thick m4bw*1.8/(1bp__) \
         from rvec_(0,-ifelse(m4ctr,1,0.9*)m4wdth/2) \
           to rvec_(0, ifelse(m4ctr,1,0.9*)m4wdth/2)
       ifelse(ifelse(cbrstack,silver,1,cbrstack,gold,1),1,
        `line outlined rgbstring(0.8,0.8,0.8) thick last line.thick \
         from 0.2 along_(last line) to 0.4 along_(last line)
         line outlined "white" thick last line.thick \
         from 0.25 along_(2nd last line) to 0.3 along_(2nd last line)')
       }')
     popdef(`m4pos')') stackdo_(`m4pos')')
 line to rvec_(max(0,rp_len/2-m4lgth/2),0) thick linethick*3/2}
 popdef(`m4lgth',`m4wdth',`m4body',`m4colors',`m4type')dnl
 line to rvec_(rp_len,0) invis ')

divert(0)dnl

linewid = 3/2*linewid
ifsvg(definergbcolor(Dandelion,0.95,0.65,0.2))
ifsvg(definergbcolor(Peach,0.76,0.5,0.1))

define(`dpr',
 `{ cbresistor(,type=B;
     body=m4colorfix(shaded,Dandelion) m4colorfix(outlined,Peach);
     colors=`$2') }
   {iflatex(`sprintf("\SI{%g}{\ohm}",`$1')')ifsvg("``$1'svg_Omega'") \
     at last line.end+(10bp__,-5bp__) rjust}
   move right_ moveht*5/6; down_ ')

 define(`elen_',(3/2*linewid))
 define(`dimen_',(5/4*linewid))
 down_
 foreach_(`pair',`dpr(patsubst(pair,-,`,'):nul:black:silver)',
  10-brown:black,
  12-brown:red,
  15-brown:green,
  18-brown:gray,
  22-red:red,
  27-red:Violet,
  33-orange:orange,
  39-orange:white,
  47-yellow:Violet,
  56-green:blue,
  68-blue:gray,
  82-gray:red)
 dpr(100,brown:black:nul:brown:gold)
 {"iflatex(\SI{5}{\percent},5 %)" at last line.end+(10bp__,-15bp__) rjust}

.PE
