% badshreeyantra.mp
% L. Nobre G.
% 2009

prologues := 1;

beginfig(1);
  numeric u, pA, pB, pC, pD;
  u = 5cm;
  path outercircle;
  outercircle = fullcircle scaled (2*u);
  draw outercircle;
  pA = 0.8;
  pB = 0.3;
  pC = -0.2;
  pD = 0.37;
%   message "pA: " & decimal(pA);
%   message "pB: " & decimal(pB);
%   message "pC: " & decimal(pC);
%   message "pD: " & decimal(pD);
  pA := pA*u;
  pB := pB*u;
  pC := pC*u;
  pD := pD*u;
  z1 = (pD,pA);
  z2 = (-pD,pA);
  z3 = (0,pC);
  draw z1--z2--z3--cycle;
  z4 = ((-u,pB)--(u,pB)) intersectionpoint outercircle;
  z5 = (-x4,pB);
  z6 = (0,-u);
  draw z4--z5--z6--cycle;
  z7 = (pD,-pA);
  z8 = (-pD,-pA);
  z9 = (0,pB);
  draw z7--z8--z9--cycle;
  z10 = (x4,-pB);
  z11 = (-x4,-pB);
  z12 = (0,u);
  draw z10--z11--z12--cycle;
  z13 = (z10--z12) intersectionpoint (z1--z3);
  z14 = (z10--z12) intersectionpoint (z4--z5);
  z16 = (0,-pA);
  z17 = (-x13,y13);
  z15 = whatever[z17,z13];
  z15 = whatever[z16,z14];
  z18 = (-x15,y15);
  draw z15--z16--z18--cycle;
  z19 = (0,pA);
  z20 = (x15,-y15);
  z21 = (-x15,-y15);
  draw z19--z20--z21--cycle;
  z22 = (z3--(u,pC)) intersectionpoint (z14--z16);
  z23 = (-x22,y22);
  z24 = (0,y13);
  draw z22--z23--z24--cycle;
  z25 = (0,-y15);
  z26 = (z3--z1) intersectionpoint (z22--z24);
  z27 = (-x26,y26);
  z28 = whatever[z19,z20];
  z28 = whatever[z26,z27];
  z29 = (-x28,y28);
  draw z25--z28--z29--cycle;
  z30 = (0,y10);
  z31 = (z7--z9) intersectionpoint (z1--z3);
  z32 = (-x31,y31);
  z33 = whatever[z31,z32];
  z33 = whatever[z22,z24];
  z34 = (-x33,y33);
  draw z30--z33--z34--cycle;
%  dotlabels.top(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34);
endfig;
end.
