.PS
# Coxeter.m4
darrow_init

  customlinethick = 1.5

  linethick = customlinethick
  define(`dotrad_',`(3/2*linethick pt__)')

  Orig: (0,0)
  for i=0 to 4 do { P[i]: dot(at (i*linewid,0)) }
  line from Orig to P[4]
  P[-1]: dot(at (Rect_(linewid, 120))); line to Orig
  P[-2]: dot(at (Rect_(linewid,-120))); line to Orig

 Pa: dot(at P[4]+(linewid,0));         "$a$" at last [].n above
  arrow from P[4] to Pa chop linewid/4
 Pd: dot(at Pa+(linewid,0));           "$d$" at last [].w rjust
 Pe: dot(at Pd+(linewid,0));           "$e$" at last [].n above
 Pf: dot(at Pe+(linewid,0));           "$f$" at last [].n above
 Pb: dot(at Pd+(Rect_(linewid,120)));  "$b$" at last [].w rjust
 Pc: dot(at Pd+(Rect_(linewid,-120))); "$c$" at last [].w rjust
  line from Pb to Pd then to Pc
  line from Pd to Pf

  define(`customarc',
   `pushdef(`dfillcolor',`0.7,0.7,0.7') linethick_(0.4); dnl
    Darc(`$1',linewid, (`$2')*dtor_, (`$3')*dtor_,
      thick=linewid/6; wid=linewid*0.3; ht=linewid/6; ends=<->)dnl
    linethick_(customlinethick); popdef(`dfillcolor')')

  customarc((linewid,-linewid/3), 25,155);   "$d$" at (linewid,linewid*2/3)
  customarc((2*linewid,-linewid/3), 25,155); "$e$" at (2*linewid,linewid*2/3)
  customarc((3*linewid,-linewid/3), 25,155); "$f$" at (3*linewid,linewid*2/3)
  customarc(Orig,130,230);                   "$a$" at (Rect_(linewid,180))
  customarc(Orig, 10,110);                   "$b$" at (Rect_(linewid, 60))
  customarc(Orig,-110,-10);                  "$c$" at (Rect_(linewid,-60))
.PE
