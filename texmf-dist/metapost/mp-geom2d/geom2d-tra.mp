%% === Pseudo-transparence =====================================================
%% Code emprunté à Anthony Phan :
%%   http://www-math.univ-poitiers.fr/~phan/metalpha.html

color   gdd_tc;
numeric gdd_ta;
picture gdd_ap;

def gdd_AlphaFill expr c =
    gdd_ap := nullpicture;
    gdd_AlphaPicture(currentpicture,c);
    addto currentpicture also gdd_ap;
enddef;

vardef gdd_AlphaPicture(expr p,c) =
    save p_; picture p_;
    p_ := nullpicture;
    addto p_ contour c withcolor gdd_ta[background,gdd_tc];
    for p__ within p:
      if (not clipped p__) and (not bounded p__):
        addto p_ also p__ withcolor
         gdd_ta[(redpart p__,greenpart p__,bluepart p__), gdd_tc];
      else:
        begingroup save gdd_ap;
         picture gdd_ap; gdd_ap = nullpicture;
         gdd_AlphaPicture(p__,pathpart p__);
         addto p_ also gdd_ap;
        endgroup;
      fi
    endfor;
    clip p_ to c;
    addto gdd_ap also p_;
enddef;

vardef colorieAvecTransparence(expr p,c,a)  =
    gdd_tc := c; gdd_ta := a;
    if path p:
      gdd_AlphaFill (p gddEnPlace)
    else:
      gdd_AlphaFill ((gddTraceObjet p) gddEnPlace)
    fi
enddef;

endinput;