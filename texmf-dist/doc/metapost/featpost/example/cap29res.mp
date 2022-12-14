verbatimtex
\documentclass[11pt]{article}
\usepackage{palatino,mathpazo,amsmath,amssymb}
\usepackage[squaren]{SIunits}
\usepackage[latin1]{inputenc}
\usepackage[portuges]{babel}
\newcommand{\veri}{\ensuremath{\hat{\text{i}}}}
\newcommand{\verj}{\ensuremath{\hat{\text{j}}}}
\newcommand{\verk}{\ensuremath{\hat{\text{k}}}}
\newcommand{\emf}{\ensuremath{\mathcal{E}}}
\newcommand{\startprob}[1]{\vspace{3mm}\noindent\framebox{#1}}
\begin{document}
etex

numeric un;
un = 1mm;
picture bigotimesp, bigodotp, efieldp, bfieldp, eforcep, bforcep, velocp, ip;
bigotimesp = btex $\bigotimes $ etex;
bigodotp = btex $\bigodot $ etex;
efieldp = btex $\vec{E} $ etex;
bfieldp = btex $\vec{B} $ etex;
eforcep = btex $\vec{F}_E $ etex;
bforcep = btex $\vec{F}_B $ etex;
velocp = btex $\vec{v} $ etex;
ip = btex $I$ etex;
picture amperp, voltip, maiscarga, menoscarg;
amperp = btex A etex;
voltip = btex V etex;
maiscarga = btex $+$ etex;
menoscarg = btex \rule{0pt}{9pt}$-$ etex;


drawoptions( withpen pencircle scaled 0.47un );
ahlength := 2un;
ahangle := 25;
labeloffset := 2un;
bboxmargin := 0un;

def drawcircledstring( expr Pos )( text TheString ) =
  begingroup
    picture strpic;
    path cirpath;
    pair llp, urp;
    numeric diametr;
    strpic = thelabel( TheString, origin ); 
    llp = llcorner strpic;
    urp = urcorner strpic;
    diametr = abs( urp - llp );
    cirpath = fullcircle scaled diametr shifted Pos;
    unfill cirpath;
    draw strpic shifted Pos;
    draw cirpath
  endgroup
enddef;

beginfig(1);
  numeric elen, forcelen, vlen, marginlen;
  elen = 30un;
  forcelen = 15un;
  vlen = 30un;
  marginlen = 10un;
  z1 = (-marginlen,forcelen);
  z2 = (-marginlen,-forcelen);
  z3 = (0,forcelen);
  z4 = (0,-forcelen);
  z5 = (vlen,0);
  drawarrow z1--z2;
  drawarrow origin--z3;
  drawarrow origin--z4;
  drawarrow origin--z5;
  label( bigotimesp, origin );
  label.ulft( efieldp, z2 );
  label.lft( bfieldp, origin );
  label.rt( eforcep, z3 );
  label.rt( bforcep, z4 );
  label.top( velocp, z5 );
endfig;

beginfig(2);
  numeric dlen, altur, vlen, forcelen, marginlen;
  marginlen = 7un;
  dlen = 25un;
  forcelen = 27.5un;
  altur = 40un;
  vlen = 15un;
  z1 = -0.5*(dlen,altur);
  z2 = 0.5*(dlen,-altur);
  z5 = 0.5*(-dlen,altur);
  z6 = 0.5*(dlen,altur);
  z3 = z1 - (0,marginlen);
  z4 = z2 - (0,marginlen);
  z7 = 0.5[z5,z6];
  z9 = (0,vlen);
  z8 = z7 + z9;
  z10= (forcelen,0);
  z11= (0.5*dlen+marginlen,marginlen);
  z12= 0.5[z3,z4];
  draw z1--z2--z6--z5--cycle;
  drawdblarrow z3--z4;
  drawarrow origin--z9;
  drawarrow origin--z10;
  drawarrow z7--z8;
  drawcircledstring( origin, menoscarg );
  label( bigotimesp, z11 );
  label.lft( velocp, z8 );
  label.lft( velocp, z9 );
  label.bot( bforcep, z10 );
  label.lft( bfieldp, z11 );
  label.top( btex $d$ etex, z12 );
endfig;

beginfig(3);
  numeric dlen, altur, vlen, forcelen, marginlen;
  numeric marginchar, marginvolt, marginfield, marginforce;
  numeric ycoo, xcoo, llim, hlim;
  marginchar = 3un;
  marginvolt = 10un;
  marginfield = 5un;
  marginforce = 6un;
  marginlen = 7un;
  dlen = 25un;
  forcelen = 27.5un;
  altur = 40un;
  vlen = 15un;
  z1 = -0.5*(dlen,altur);
  z2 = 0.5*(dlen,-altur);
  z5 = 0.5*(-dlen,altur);
  z6 = 0.5*(dlen,altur);
  z3 = z1 - (0,marginlen);
  z4 = z2 - (0,marginlen);
  z12= 0.5[z3,z4];
  z7 = 0.5[z5,z6];
  z9 = (0,vlen);
  z8 = z7 + z9;
  z10= (marginforce-0.5*dlen,0);  
  z11= -z10;
  z13= (-0.5*dlen+marginfield,0.25*altur);
  z15= (-0.5*dlen+marginforce,-0.25*altur);
  z14= (0.5*dlen-marginfield,0.25*altur);
  z16= (0.5*dlen-marginforce,-0.25*altur);
  z17= (-0.5*dlen-marginvolt,0);
  z18= -z17;
  z19= (-0.5*dlen-marginvolt,-0.5*altur-marginlen-marginvolt);
  z20= (0.5*dlen+marginvolt,-0.5*altur-marginlen-marginvolt);
  z21= 0.5[z19,z20];
  z22= (-0.5*dlen,0);
  z23= -z22;
  draw z1--z2--z6--z5--cycle;
  draw z22--z17--z19--z20--z18--z23;
  drawdblarrow z3--z4;
  drawarrow z11--z10;
  drawarrow z13--z14;
  drawarrow z15--z16;
  drawarrow z7--z8;
  drawcircledstring( z21, btex \rule[-1mm]{0pt}{12pt}V etex );
  label.lft( velocp, z8 );
  label.llft( bforcep, z16 );
  label.llft( efieldp, z14 );
  label.lrt( eforcep, z10 );
  label.top( btex $d$ etex, z12 );
  xcoo = 0.5*dlen-marginchar;
  llim = -0.5*altur+marginchar;
  hlim = 0.5*altur-marginchar;
  for ycoo=llim step marginchar until hlim:
    label( maiscarga, (-xcoo,ycoo) );
    label( menoscarg, (xcoo,ycoo) );
  endfor;    
endfig;

beginfig(4);
  numeric alen, blen, marginfield, margincurrent, ilen;
  blen = 40un;
  alen = 5*blen/12;
  ilen = 8un;
  marginfield = 5un;
  margincurrent = 1.6un;
  z17 = unitvector( (alen,blen) );
  z18 = (blen-2*marginfield,0);
  z1 = origin;
  z2 = (blen,0);
  z3 = (0,alen);
  z4 = 0.25[z1,z2];
  z5 = 0.45[z2,z3];
  z6 = 0.35[z3,z1];
  z7 = 0.5[z1,z2]+margincurrent*down;
  z8 = z7+ilen*right;
  z9 = 0.65[z2,z3]+margincurrent*z17;
  z10= z9+ilen*unitvector((-blen,alen));
  z11= 0.5[z3,z1]+margincurrent*left;
  z12= z11+ilen*down;
  z13= marginfield*(1,-1);
  z14= z13+z18;
  z15= z3+marginfield*(1,1);
  z16= z15+z18;
  draw z1--z2--z3--cycle;
  drawarrow z7--z8;
  drawarrow z9--z10;
  drawarrow z11--z12;
  drawarrow z13--z14;
  drawarrow z15--z16;
  label.llft( bfieldp, z14 );
  label.llft( bfieldp, z16 );
  label.rt( ip, z8 );
  label.ulft( ip, z10 );
  label.bot( ip, z12 );
  label.top( btex $b$ etex, z4 );
  label.bot( btex $c$ etex, z5 );
  label.rt( btex $a$ etex, z6 );
endfig;
 
beginfig(5);
  numeric alen, blen, marginfield, margincurrent, ilen;
  blen = 40un;
  alen = 5*blen/12;
  ilen = 8un;
  marginfield = 5un;
  margincurrent = 1.6un;
  z17 = unitvector( (alen,blen) );
  z18 = (blen-2*marginfield,0);
  z1 = origin;
  z2 = (blen,0);
  z3 = (0,alen);
  z4 = 0.25[z1,z2];
  z5 = 0.45[z2,z3];
  z6 = 0.35[z3,z1];
  z7 = 0.5[z1,z2]+margincurrent*down;
  z8 = z7+ilen*right;
  z9 = 0.5[z2,z3]+margincurrent*z17;
  z10= z9+ilen*unitvector((-blen,alen));
  z11= 0.5[z3,z1]+margincurrent*left;
  z12= z11+ilen*down;
  z13= 0.65[z3,z1];
  z14= z13+z18;
  z15= z3+marginfield*(1,1);
  z16= z15+z18;
  drawarrow z11--z12;
  drawarrow z13--z14;
  drawarrow z3--z1;
  label.llft( bfieldp, z14 );
  label.bot( ip, z12 );
  label.rt( btex $\vec{a}$ etex, z6 );
  label.lrt( bigodotp, z13 );
  label.lrt( btex $\vec{F}_a$ etex, 0.13[z13,z14] );
endfig;

beginfig(6);
  numeric alen, blen, marginfield, margincurrent, ilen;
  blen = 40un;
  alen = 5*blen/12;
  ilen = 8un;
  marginfield = 5un;
  margincurrent = 1.6un;
  z17 = unitvector( (alen,blen) );
  z18 = (blen-2*marginfield,0);
  z1 = origin;
  z2 = (blen,0);
  z3 = (0,alen);
  z4 = 0.25[z1,z2];
  z5 = 0.45[z2,z3];
  z6 = 0.35[z3,z1];
  z7 = 0.5[z1,z2]+margincurrent*down;
  z8 = z7+ilen*right;
  z9 = 0.5[z2,z3]+margincurrent*z17;
  z10= z9+ilen*unitvector((-blen,alen));
  z11= 0.5[z3,z1]+margincurrent*left;
  z12= z11+ilen*down;
  z13= marginfield*(1,-1);
  z14= z13+z18;
  z15= z3+marginfield*(1,1);
  z16= z15+z18;
%  drawarrow z11--z12;
  drawarrow z13--z14;
  drawarrow z1--z2;
  label.llft( bfieldp, z14 );
%  label.bot( ip, z12 );
  label.top( btex $\vec{b}$ etex, z4 );
%  label.lrt( bigodotp, z13 );
%  label.lrt( btex $\vec{F}_a$ etex, 0.13[z13,z14] );
endfig;

beginfig(7);
  numeric alen, blen, marginfield, margincurrent, ilen, ralpha, rphi;
  path pc, pb, palpha, pphi;
  ralpha = 6un;
  rphi = 4un;
  blen = 40un;
  alen = 5*blen/12;
  ilen = 8un;
  marginfield = 5un;
  margincurrent = 1.6un;
  z17 = unitvector( (alen,blen) );
  z18 = (blen-2*marginfield,0);
  z1 = origin;
  z2 = (blen,0);
  z3 = (0,alen);
  z4 = 0.25[z1,z2];
  z5 = 0.45[z2,z3];
  z6 = 0.35[z3,z1];
  z7 = 0.5[z1,z2]+margincurrent*down;
  z8 = z7+ilen*right;
  z9 = 0.65[z2,z3]+margincurrent*z17;
  z10= z9+ilen*unitvector((-blen,alen));
  z11= 0.5[z3,z1]+margincurrent*left;
  z12= z11+ilen*down;
  z14= z2+ilen*up;
  z13= z14-z18;
  pb = z13--z14;
  pc = z2--z3;
  z19 = pb intersectionpoint pc;
  pphi = halfcircle scaled 2rphi shifted z19 cutafter pc;
  palpha =  halfcircle scaled 2ralpha shifted z19 cutbefore pc;
  z20 = pphi intersectionpoint (z19--(z19+1.1*rphi*dir(0.5*angle((-blen,alen)))));
  z21 = palpha intersectionpoint (z19--(z19+1.1*ralpha*dir(180-0.5*angle((blen,alen)))));
  label.lft( btex $\alpha$ etex, z21 );
  label.top( btex $\phi$ etex, z20 );
  draw pphi;
  draw palpha;
  drawarrow pc;
  drawarrow z9--z10;
  drawarrow pb;
  label.llft( bfieldp, z14 );
  label.ulft( ip, z10 );
  label.bot( btex $\vec{c}$ etex, z5 );
endfig;
 
beginfig(8);
  numeric raya, rayb, angs, angf, angr;
  path pc, pd, ps, pf, pr, pI;
  raya = 9un;
  rayb = 11un;
  angs = 15;
  angf = 64;
  angr = 240;
  pc = fullcircle scaled 2raya;
  pd = fullcircle scaled 2rayb;
  ps = origin--1.1*rayb*dir(angs);
  pf = origin--1.1*rayb*dir(angf);
  pr = origin--raya*dir(angr);
  pI = pd cutbefore ps cutafter pf;
  draw pc;
  draw pr;
  drawarrow pI;
  label.top( btex $R$ etex, 0.5*raya*dir(angr) );
  label.rt( btex $A$ etex, origin );
  label.top( btex $I$ etex, point 0.5 of pI );
endfig;

beginfig(9);
  numeric raya, rayb, ang, lenf, lenb, lenm;
  path pc, pm;
  raya = 11un;
  rayb = 0.5raya;
  ang = 41;
  lenm = 1.35raya;
  lenf = 1.25lenm;
  lenb = 0.4lenm;
  z1 = (lenf,0);
  z2 = lenm*dir(ang);
  pm = origin--z2;
  z3 = raya*dir(ang+90);
  z4 = (-lenb,0);
  z5 = raya*dir(ang+270);
  z6 = rayb*dir(0.5*ang);
  pc = halfcircle scaled 2rayb cutafter pm;
  drawarrow z4--z1;
  drawarrow pm;
  draw z3--z5;
  draw pc;
  label.rt( btex $41\degree$ etex, z6 );
  label.rt( btex $\vec{\mu}$ etex, z2 );
  label.llft( bfieldp, z1 );
  label( bigotimesp, origin );
  label.llft( btex $\vec{\tau}$ etex, origin ); 
endfig;

verbatimtex
\end{document}
etex

end.
