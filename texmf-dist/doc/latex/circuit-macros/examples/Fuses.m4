.PS
# `Fuses.m4'
cct_init

movewid = 0.25

 {
  fuse ; {"`\tt fuse'" at last line.c+(0,-0.2)}
  move
  fuse(,D) ; {"`\tt fuse(,D)'" at last line.c+(0,-0.2)}
  move
  fuse(,B) ; {"`\tt fuse(,B)'" at last line.c+(0,-0.2)}
  move
  fuse(,C) ; {"`\tt fuse(,C)'" at last line.c+(0,-0.2)}
  move
  fuse(,S,,,fill_(0.9))
   {"`\tt\shortstack[l]{fuse(,S,{,},\\fill\_(0.9))}'" \
    at last line.c+(0,-0.2)}
  move
  fuse(,SB) ; {"`\tt fuse(,SB)'" at last line.c+(0,-0.2)}
  }
  move down; right_
  {
  cbreaker; {"`\tt cbreaker'" at last line.c+(0,-0.25)}
  move
  cbreaker(,R); {"`\tt cbreaker(,R)'" at last line.c+(0,-0.25)}
  move
  cbreaker(,,D); {"`\tt $\ldots$(,{,}D)'" at last line.c+(0,-0.25)}
  move
  cbreaker(,,T); {"`\tt $\ldots$(,{,}T)'" at last line.c+(0,-0.25)}
  move
  cbreaker(,,TS); {"`\tt $\ldots$(,{,}TS)'" at last line.c+(0,-0.25) }
  }
  move down; right_
  {
  fuse(,HB) ; {"`\tt fuse(,HB)'" at last line.c+(0,-0.2)}
  move
  fuse(,HC,0.5,0.3) ; {"`\tt $\ldots$(,HC,0.5,0.3)'" at last line.c+(0,-0.27)}
  move
  jumper ; {"`\tt jumper'" at last line.c+(0,-0.2) }
  move
  jumper(,CJBED) ; {"`\tt $\ldots$(,CJBED)'" at last line.c+(0,-0.2) }
  move
  jumper(,body=outlined "gray" shaded "gray";)
  "`\tt $\ldots$(,body=outlined \"gray\" \textbackslash'" wid 168bp__ \
    at last line.start+(0,-20bp__) ljust \
  "`\tt \hphantom{body=}shaded \"gray\";)'" ljust
  }

.PE
