% dreamhouse.mp
% L. Nobre G.
% 2011

prologues := 2;

beginfig(1);
  numeric u;
  u = 5mm; % deve corresponder a um metro
  numeric theta, gamma;
  theta = 8.7;
  gamma = 25;
  numeric lqua, lwca, lqub, lcor, lpor, lwcb, cqua, cqub, lwcc, cwcc, lesc;
  lqua = 3.8u;
  lwca = 1.5u;
  lqub = 3.0u;
  lcor = 1.2u;
  lpor = 0.9u;
  lwcb = 2.0u;
  cqua = 4.0u;
  cqub = 5.0u;
  lwcc = 1.5u;
  cwcc = 1.5u;
  lesc = 3.0u;
  numeric lcas, cdoj, cfaf, cfat, csal, cesc, cwca, dcor, ldoj, extr;
  lcas = lqua+lwca+lqub;
  cdoj = cqub+lcor+lwcb;
  extr = cqua*sind(theta)/cosd(theta);
  csal = lwca+lqua+extr;
  ldoj = csal+lqub;
  cesc = csal+lqub-2*lpor-lqub;
  cwca = cqua-lcor;
  dcor = lcor/cosd(gamma);
  z1 = left*lpor;
  z2 = z1+cesc*dir(-90-gamma);
  z3 = z1+lesc*dir(180-gamma);
  z4 = z2+lesc*dir(180-gamma);
  z5 = z3+2*lpor*dir(90-gamma);
  z6 = z5+lqub*dir(90-gamma);
  z7 = z6+lwcb*dir(180-gamma);
  z8 = z5+lwcb*dir(180-gamma);
  z9 = z7+lcor*dir(180-gamma);
  z10= z9+lqub*dir(-90-gamma);
  z11= z9+cqub*dir(180-gamma)+extr*dir(-90-gamma);
  z12=z11+(lqub-extr)*dir(-90-gamma);
  z13=z12+cwca*dir(-gamma);
  z14=z12+cqua*dir(-gamma);
  z15=z12+lwca*dir(-90-gamma);
  z16=z15+cwca*dir(-gamma);
  z17=z11+(lcas-extr)*dir(-90-gamma);
  z18=z14+csal*dir(-90-gamma);
  z19=whatever[z17,z18];
  x19= 0;
  z20=z11+whatever*dir(theta-gamma);
  x20= 0;
  z21=whatever[z11,z6];
  x21= 0;
  z22=whatever[z4,z2];
  x22= 0;
  z23= right*lpor;
  z24=z22+whatever*dir(gamma);
  x24=x23;
  z25=z23+dcor*down;
  z26=z24+dcor*up;
  z27=z26+lcor*right;
  z28=z27+whatever*up;
  z28=z25+whatever*right;
  z33= (-x18,y18);
  z30= (-x6,y6);
  z29=z30+whatever*dir(gamma);
  z29=z33+whatever*dir(90+gamma);
  z31=z18+ldoj*dir(90-gamma);
  z32= (-x4,y4);
  z34= (-x3,y3);
  z35=z24+whatever*dir(gamma);
  z35=z27+whatever*down;
  z36=z35+lwcc*dir(gamma);
  z37=z36+cwcc*dir(90+gamma);
  z38=z37+whatever*left;
  z38=whatever[z28,z35];
  draw origin--z1--z2;
  draw z34--z23--z1--z3;
  draw z4--z6;
  draw z5--z8--z7;
  draw z9--z10--z12;
  draw z14--z18--z22--z33;
  draw z13--z16--z15;
  draw z18--z17--z11--z31--z21--z29--z33;
  draw z30--z32;
  draw z23--z24;
  draw z25--z28--z35;
  draw z36--z37--z38;
  pen outpen;
  outpen = pencircle scaled (0.2u);
  draw z11--z17--z18--z22--z33--z29--z21--z31--cycle withpen outpen;
endfig;

beginfig(2);
  numeric u;
  u = 5mm; % deve corresponder a um metro
  numeric theta, gamma;
  theta = 8.7;
  gamma = 25;
  numeric lqua, lwca, lqub, lcor, lpor, lwcb, cqua, cqub, lwcc, cwcc, lesc;
  numeric lcas, cdoj, cfaf, cfat, csal, cesc, cwca, dcor, ldoj, cwcb;
  numeric cmed, lare, mroo;
  lqua = 3.25u;
  lcor = 1.2u;
  lpor = 0.9u;
  cqua = 4.5u;
  lwcc = 2.0u;
  cwcc = 1.5u;
  lesc = 2.5u;
  csal = 5.8u;
  cwca = 2.0u;
  lare = 2.0u;
  mroo = 0.6u;
  cdoj = 5.5u;
  cwcb = 2*lcor;
  cqub = cqua+cwca-lcor;
  lwca = lqua-lcor;
  lqub = lqua;
  lwcb = lwca;
  lcas = lqua+lqub;
  ldoj = lcas;
  cesc = lqua;
  dcor = lcor/cosd(gamma);
  cmed = csal+lwca+cqua;
  z1 = left*lpor;
  z2 = z1+cesc*dir(-90-gamma);
  z3 = z34;
  z4 = z32+ldoj*dir(90+gamma);
  z5 = z1+2*lcor*dir(180-gamma);
  z6 = z7+lqub*dir(-90-gamma);
  z7 = z8+cwcb*dir(-gamma);
  z8 =z11+cqub*dir(-gamma);
  z9 = z8+lqub*dir(-90-gamma);
  z10=z12+(cqua+lwca)*dir(-gamma);
  z11=z12+lqub*dir(90-gamma);
  z12= z1+cmed*dir(180-gamma);
  z13=z10+lcor*dir(-90-gamma);
  z14= z7+lwcb*dir(-90-gamma);
  z15= z8+lwcb*dir(-90-gamma);
  z16=z13+cwca*dir(180-gamma);
  z17=z11+lcas*dir(-90-gamma);
  z18=z13+lwca*dir(-90-gamma);
  z19=z16+lwca*dir(-90-gamma);
  z20= z22+up*lcor/cosd(gamma);
  z21=whatever[z11,z7];
  x21= 0;
  z22=whatever[z18,z17];
  x22= 0;
  z23= right*lpor;
  z24=z20+whatever*dir(-90-gamma);
  z24=whatever[z2,z22];
  z25=z23+cesc*dir(-90+gamma);
  z26=z25+lcor*dir(90+gamma);
  z27=z25+cwcc*dir(90+gamma);
  z28=z27+lwcc*dir(gamma);
  z29=z30+lqub*dir(-90+gamma);
  z30= z4+lesc*dir(180+gamma);
  z31=z25+lwcc*dir(gamma);
  z32=z31+lare*dir(gamma);
  z33=z32+cdoj*dir(gamma);
  z34=z32+cesc*dir(90+gamma);  
  z35=z33+ldoj*dir(90+gamma);
  z36=z35+sqrt(2)*mroo*dir(45+gamma);
  z37=z36+whatever*dir(180+gamma-theta);
  x37= 0;
  z38=z11+sqrt(2)*mroo*dir(135-gamma);
  z39=z38+(lcas+2*mroo)*dir(-90-gamma);
  z40=z41+whatever*dir(180+gamma+theta);
  x40= 0;
  z41=z36+(ldoj+2*mroo)*dir(-90+gamma);
  z42=z30+lcor*dir(-90+gamma);
  draw z32--z34--z23--z1;
  draw z5--z6--z7;
  draw z14--z15;
  draw z8--z9;
  draw z27--z28--z31;
  draw z18--z10--z12;
  draw z13--z16--z19;
  draw z1--z2;
  draw z3--z4;
  draw z23--z25;
  draw z26--z20--z24;
  draw z29--z42;
  pen outpen;
  outpen = pencircle scaled (0.2u);
  draw z11--z17--z22--z33--z35--z21--cycle withpen outpen;
  draw z36--z37--z38--z39--z40--z41--cycle withpen outpen withcolor 0.5white;
  drawoptions( withcolor 0.75white);
%  dotlabels.bot(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20);
%  dotlabels.bot(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40);
%  dotlabels.bot(41,42);
  numeric aux;
  aux = abs(z35-z21)+abs(z33-z22)+abs(z21-z11)+abs(z22-z17);
  show aux*lqua/(u**2);
  label("QUA",(z12+z10+z17+z18)/4);
  label("QUB",(z11+z12+z8+z9)/4);
  label("WCA",(z19+z18+z16+z13)/4);
  label("WCB",(z14+z15+z8+z7)/4);
  label("SAL",(z2+z1+z10+z18)/4);
  label("COZ",(z21+z5+z29)/3);
  label("HAL",(z1+z2+z23+z25)/4);
  label("ESC",(z30+z29+z4+z3)/4);
  label("ARE",(z23+z34+z32)/3);
  label("DOJ",(z4+z32+z33+z35)/4);
  label("WCC",(z25+z27+z28+z31)/4);
endfig;

end.