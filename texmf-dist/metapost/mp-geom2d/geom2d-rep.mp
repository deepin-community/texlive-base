picture repSavePict;
string  repSaveW;

% x and y labels
string gddXlabel;
gddXlabel := "$x$";
string gddYlabel;
gddYlabel := "$y$";

def Repere(expr l,h,ox,oy,ux,uy) =
  repLargeur := l; repHauteur := h;
  repOX := ox ; repOY := oy;
  repXmin := - ox / ux; repXmax := repXmin + l / ux;
  repYmin := - oy / uy; repYmax := repYmin + h / uy;
  repUX := ux; repUY := uy;
  repSaveW := gddW;
  gddW  := "xscaled repUX yscaled repUY shifted (repOX,repOY) scaled gddU";
enddef;

def RepereMinMax(expr xmin,xmax,ymin,ymax,ux,uy) =
  repLargeur := (xmax-xmin)*ux; repHauteur := (ymax-ymin)*uy;
  repOX := -xmin*ux ; repOY := -ymin*uy;
  repXmin := xmin; repXmax := xmax;
  repYmin := ymin; repYmax := ymax;
  repUX := ux; repUY := uy;
  repSaveW := gddW;
  gddW  := "xscaled repUX yscaled repUY shifted (repOX,repOY)  scaled gddU";
enddef;

def Debut =
  repSavePict := currentpicture; currentpicture := nullpicture;
enddef;

def repClip =
  clip currentpicture to (%
   ((0,0)--(repLargeur,0)--(repLargeur,repHauteur)--(0,repHauteur)--cycle)
  scaled gddU);
enddef;

def repStroke (expr c) =
  draw ((0,0)--(repLargeur,0)--(repLargeur,repHauteur)--(0,repHauteur)--cycle)
    scaled gddU withcolor c;
enddef;

def Fin =
    repClip; 
    addto repSavePict also currentpicture; currentpicture := repSavePict;
    gddW := repSaveW;
enddef;

def Axes =
    drawarrow ((repXmin,0)--(repXmax,0)) gddEnPlace;
    drawarrow ((0,repYmin)--(0,repYmax)) gddEnPlace;
    label.lrt(textext(gddXlabel),(repXmax,0) gddEnPlace);
    label.ulft(textext(gddYlabel),(0,repYmax) gddEnPlace);
enddef;

def AxesBords =
    drawarrow ((repXmin,repYmin)--(repXmax,repYmin)) gddEnPlace;
    drawarrow ((repXmin,repYmin)--(repXmin,repYmax)) gddEnPlace;
    label.lrt(textext(gddXlabel),(repXmax,repYmin) gddEnPlace);
    label.ulft(textext(gddYlabel),(repXmin,repYmax) gddEnPlace);
enddef;


vardef Graduations  =
    save xmin, xmax, ymin, ymax;
    xmin = round(repXmin); xmax = round(repXmax) ;
    ymin = round(repYmin); ymax = round(repYmax) ;
    SequenceTirets((xmin,0),(1,0),(0,-4),xmax-xmin);
    SequenceTirets((xmin+0.5,0),(1,0),(0,-2),xmax-xmin);
    SequenceTirets((0,ymin),(0,1),(-4,0),ymax-ymin+1);
    SequenceTirets((0,ymin+0.5),(0,1),(-2,0),ymax-ymin);
enddef;


vardef GraduationsBords  =
    save xmin, xmax, ymin, ymax;
    xmin = round(repXmin); xmax = round(repXmax) ;
    ymin = round(repYmin); ymax = round(repYmax) ;
    SequenceTirets((xmin,repYmin),(1,0),(0,+4),xmax-xmin);
    SequenceTirets((xmin+0.5,repYmin),(1,0),(0,+2),xmax-xmin);
    SequenceTirets((repXmin,ymin),(0,1),(+4,0),ymax-ymin);
    SequenceTirets((repXmin,ymin+0.5),(0,1),(+2,0),ymax-ymin);
enddef;

def ClipRepere =
    extra_endfig := extra_endfig & "repClip;";
enddef;

%
% SequenceTirets
% ------------------------------------------------------------------------------
vardef SequenceTirets(expr o,p,t,n) text a=
  save ot; pair ot; ot := o gddEnPlace;
  for i:=1 upto n:
    % tiret
    draw ot -- (ot shifted t) a;
    % avancement
    ot := (o + i*p) gddEnPlace;
  endfor
enddef;

vardef Unites(expr t) =
  label.bot(textext("$+"&decimal(t)&"$"),(t,-(3/gddU/repUY)) gddEnPlace);
  label.lft(textext("$+"&decimal(t)&"$"),(-(3/gddU/repUX),t) gddEnPlace);
enddef;

%vardef ValeursGraduations =
%  label.bot(textext("$+"&decimal(t)&"$"),(t,-(3/gddU/repUY)) gddEnPlace);
%  label.lft(textext("$+"&decimal(t)&"$"),(-(3/gddU/repUX),t) gddEnPlace);
%enddef;
%%% ----------------------------------------------------------------------------
%%% Grille
%%% ----------------------------------------------------------------------------

def GrilleRepere =
  save xmin, xmax, ymin, ymax;
  xmin = floor(repXmin); xmax = floor(repXmax) ;
  ymin = floor(repYmin); ymax = floor(repYmax) ;
  for i:=xmin upto xmax:
    draw ((i,ymin)--(i,ymax)) gddEnPlace;
  endfor;
  for i:=ymin upto ymax:
    draw ((xmin,i)--(xmax,i)) gddEnPlace;
  endfor;
enddef;

%%% ----------------------------------------------------------------------------
%%% CadreRepere
%%% ----------------------------------------------------------------------------
def CadreRepere =
  (repXmin,repYmin)--(repXmin,repYmax)--(repXmax,repYmax)--(repXmax,repYmin)--cycle
enddef;

endinput
