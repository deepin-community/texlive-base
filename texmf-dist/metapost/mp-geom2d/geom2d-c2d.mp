%%% --------------------------------------------------------------------------
%%% mp-gdd %%% Courbes du second degré
%%% --------------------------------------------------------------------------

gddC2Dparam := 15; % pour les tracés des parabole et hyperbole

% macros factorisées 

vardef Foyer(expr c,n) =
  % c : ellipse, parabole, hyperbole
  % n : 1 ou 2
  if(n=1):
    gddD[c]
  else:
    if(gddT[c]="parabole"): % si parabole c’est le même foyer
      gddD[c]
    else:
      gddE[c]
    fi
  fi
enddef;

vardef Excentricite(expr c)=
  gddX[c][3]
enddef;

vardef Inclinaison(expr c)=
  gddX[c][4]
enddef;

% Ellipse ----------------------------------------------------------------------

vardef Ellipse(expr C,A,B) = 
  % C : centre
  % A : vertex
  % B : co-vertex  
  save n,a,b,c,e,_tmp,slope; 
  pair _tmp;
  n = incr gddO;
  gddT[n] = "ellipse"; gddA[n] = PointImp(C); gddB[n] = PointImp(A);
  gddC[n] = PointImp(B);
  % calcul des deux foyers
  a = Longueur(C,A);
  b = Longueur(C,B);
  c = sqrt(a**2-b**2);
  e = c/a;
  _tmp = e*(Pt(A)-Pt(C));
  % les foyers
  gddD[n] = PairTOPoint(Pt(C)+_tmp);
  gddE[n] = PairTOPoint(Pt(C)-_tmp);
  gddX[n][1] = a;
  gddX[n][2] = b;
  gddX[n][3] = e;
  % angle du demi grand axe
  slope = angle(PairImp(A)-PairImp(C));
  gddX[n][4] = slope;
  n
enddef;

vardef EllipseF(expr A,B,a) = 
  % A : foyer 1
  % B : foyer 2  
  save n,b,c,e,_tmp,slope; 
  pair _tmp;
  n = incr gddO;
  gddT[n] = "ellipse"; 
  % Foyers
  gddD[n] = PointImp(A);
  gddE[n] = PointImp(B);
  % centre
  gddA[n] = Milieu(A,B);
  % La distance entre les deux foyers est égale à 2c 
  c = Longueur(A,B)/2;
  if(c>a):
    errmessage("le demi grand axe est trop petit");
  fi
  e = c/a;
  
  b = sqrt(a**2-c**2);
  
  % vertex et co-vertex 
  _tmp := 1.0/c*(Pt(B)-Pt(gddA[n]));
  gddB[n] = PairTOPoint(Pt(gddA[n])+a*_tmp);
  gddC[n] = PairTOPoint(Pt(gddA[n])+b*Pt(Rotation(_tmp,Pi/2)));
  gddX[n][1] = a;
  gddX[n][2] = b;
  gddX[n][3] = e;
  % angle du demi grand axe
  slope = angle(PairImp(gddB[n])-PairImp(gddA[n]));
  gddX[n][4] = slope;
  n
enddef;



vardef Vertex(expr c) = 
  gddB[c]
enddef;

vardef Covertex(expr c) = 
  gddC[c]
enddef;



vardef DemiGrandAxe(expr c)=
  gddX[c][1]
enddef;

vardef DemiPetitAxe(expr c)=
  gddX[c][2]
enddef;




vardef TangenteEllipse(expr e,p) = 
  % détermine la tangente à une ellipse e au point p
  % appartenant à l’ellipse
  % par la méthode de la bissectrice
  save F,Fp,M,B;
  F = Foyer(e,1);
  Fp = Foyer(e,2);
  M = PointImp(p);
  B = Bissectrice(F,M,Fp);
  DroitePerpendiculaire(B,M)
enddef;

vardef TangenteExterieureEllipse(expr ell, p,n) =
  % ell : ellipse
  % p : point
  % n : 1 ou 2 pour choisir la tangente
  % http://choumac44.free.fr/NGEOMETRIE/Ellipse.htm
  % Du point p comme centre tracer un arc de cercle de rayon PF'
  % Du foyer F comme centre tracer un arc de cercle de rayon 2a 
  % l'intersection des 2 arcs donne le point T 
  % Tracer la droite TF puis la droite TF' et sa médiatrice , l'intersection de
  % la médiatrice et la droite TF nous donne le point ( M ) ( contact avec la
  % courbe) -> ici on laisse MetaPost trouver l’intersection segment,ellipse
  save F,P,T,C,Ip,U,DU,M;
  P = PointImp(p);
  if(n=1):
  F1 = Foyer(ell,1);
  F2 = Foyer(ell,2);
  else:
  F1 = Foyer(ell,2);
  F2 = Foyer(ell,1);
  fi
  C1 = CercleCP(P,F1);
  C2 = Cercle(F2,2*DemiGrandAxe(ell));
  T1 = IntersectionCercles(C1,C2);
  T2 = IntersectionCercles(C2,C1);
  if(Longueur(F1,T1)<Longueur(F1,T2)):
    U = T1;
  else:
    U = T2;
  fi
  DU = Segment(F2,U);
  pair Ip;
  Ip := (gddTraceObjet(DU)) intersectionpoint (gddTraceObjet(ell));
  M = PointImp(Ip);
  Droite(P,M)
enddef;


%%% Paraboles ----------------------------------------------------------------

% Parabole par Foyer-Directrice.



vardef ParaboleFD(expr F,D) =
  % F : foyer (point)
  % D : directrice (droite)
  save u, v, w, d, i, n,_tmp,slope; 
  pair _tmp;
  n = incr gddO;
  (u,v,w) = EquationDroite(D);
  % ordonnée relative
  d := u * gddA[F] + v * gddB[F] + w;
  gddT[n] := "parabole"; 
  gddX[n][1] := D; % on stock la directrice
  gddX[n][2] := D; % on stock la directrice (compatibilité avec hyperbole)
  % sommet 
  _tmp := (((-d/2)*(u,v)) shifted PairImp(F));
  gddB[n] = PointImp(_tmp);
  gddC[n] = PointImp(_tmp);
  % le foyer (doublé pour compatibilité)
  gddD[n] := F;
  gddE[n] := F;
  gddX[n][3] := 1.0; % excentricité
  % angle du demi grand axe
  slope = angle(PairImp(gddA[D])-PairImp(gddB[D]))+90;
  gddX[n][4] = slope;
  i := -gddC2Dparam-1;
  gddP[n] := (
    ((i*(v,-u)+((i*i-d*d)/(2d))*(u,v))
    for i:= -gddC2Dparam upto gddC2Dparam:
      ..(i*(v,-u)+((i*i-d*d)/(2d))*(u,v))
    endfor)) shifted PairImp(F);
   n
enddef;

% Parabole par Foyer-Sommet
vardef ParaboleFS(expr F,S) =
enddef;


%% Hyperbole ----------------------------------------------------------

vardef HyperboleFD(expr F,D,e) =
  % F : foyer (point)
  % D : directrice (droite)
  % e : exentricité (numeric)
  % pm : +1 ou -1 pour les deux branches
  save u, v, w, d, i, n,_tmp,slope,aa,bb; 
  pair _tmp;
  n = incr gddO;

  (u,v,w) = EquationDroite(D);
  d := u * gddA[F] + v * gddB[F] + w;
  gddT[n] := "hyperbole"; 
  
  % sommets 
  _tmp := -(d+1*sqrt(e*e*d*d))/(e*e-1)*(u,v)shifted (ProduitScalaire(F,Vecteur(v,-u))*(v,-u));
  gddB[n] := PointImp(_tmp);
  _tmp := -(d-1*sqrt(e*e*d*d))/(e*e-1)*(u,v)shifted
  (ProduitScalaire(F,Vecteur(v,-u))*(v,-u));
  gddC[n] := PointImp(_tmp);
  % centre comme milieu des deux sommets
  gddA[n] = Milieu(gddB[n],gddC[n]);
  % le foyer (doublé pour compatibilité)
  gddD[n] := F;
  gddE[n] := RotationCentre(F, gddA[n], Pi);
  gddX[n][3] := e; % excentricité
  % directrices
  gddX[n][1] := D; % on stock la directrice
  gddX[n][2] := Droite(RotationCentre(gddA[D], gddA[n], Pi),RotationCentre(gddB[D], gddA[n], Pi));
  % angle de l’axe
  slope = angle(PairImp(gddA[D])-PairImp(gddB[D]))+90;
  gddX[n][4] = slope;
  % cercle principale
  gddX[n][5] = CercleD(gddB[n],gddC[n]);
  % asymptotes
  aa = IntersectionDroiteCercle(D,gddX[n][5],1);
  bb = IntersectionDroiteCercle(D,gddX[n][5],2);
  gddX[n][6] = Droite(gddA[n],aa);
  gddX[n][7] = Droite(gddA[n],bb);
  % tracés des moitiées
  i := -gddC2Dparam-1;
  gddPX[n][1] := (
    (
    (i*(v,-u)-(d+sqrt(e*e*d*d+i*i*(e*e-1)))/(e*e-1)*(u,v))
    for i:= -gddC2Dparam upto gddC2Dparam:
      ..(i*(v,-u)-(d+sqrt(e*e*d*d+i*i*(e*e-1)))/(e*e-1)*(u,v))
    endfor
  ) shifted (ProduitScalaire(F,Vecteur(v,-u))*(v,-u))
  );
  gddPX[n][2] := (
    (
    (i*(v,-u)-(d-sqrt(e*e*d*d+i*i*(e*e-1)))/(e*e-1)*(u,v))
    for i:= -gddC2Dparam upto gddC2Dparam:
      ..(i*(v,-u)-(d-sqrt(e*e*d*d+i*i*(e*e-1)))/(e*e-1)*(u,v))
    endfor
  ) shifted (ProduitScalaire(F,Vecteur(v,-u))*(v,-u))
  );
  n
enddef;

vardef CerclePrincipale(expr h)=
  %h : hyperbole
  gddX[h][5]
enddef;

vardef AsymptoteHyperbole(expr h,n)=
  % h : hyperbole
  % n : 1 ou 2 pour choisir l’hyperbole
  gddX[h][5+n]
enddef;

vardef DemiHyperbole(expr h,n)=
  gddPX[h][n]
enddef;

% sommet
vardef Sommet(expr p,n) =
  % p : parabole ou hyperbole
  % n : 1 ou 2, choisir un des sommets (le même pour la parabole)
  if n=1:
    gddB[p]
  else:
    gddC[p]
  fi
enddef;

vardef Directrice(expr p,n) = 
  % p : parabole ou hyperbole
  gddX[p][n]
enddef;
endinput