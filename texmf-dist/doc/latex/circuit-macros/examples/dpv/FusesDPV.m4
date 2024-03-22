.PS
# `FusesDPV.m4'
cct_init(svg_font(sans-serif,11bp__))

movewid = 0.25

 {
  fuse ; {"`fuse'" at last line.c+(0,-0.2)}
  move
  fuse(,D) ; {"`fuse(,D)'" at last line.c+(0,-0.2)}
  move
  fuse(,B) ; {"`fuse(,B)'" at last line.c+(0,-0.2)}
  move
  fuse(,C) ; {"`fuse(,C)'" at last line.c+(0,-0.2)}
  move
  fuse(,S,,,fill_(0.9))
  {"`fuse(,S,,,'" ljust at last [].sw+(-2bp__,-0.17) \
      "`fill_(0.9))'" ljust}
  move
  fuse(,SB) ; {"`fuse(,SB)'" at last line.c+(0,-0.2)}
  }
  move down; right_
  {
  fuse(,HB) ; {"`fuse(,HB)'" at last line.c+(0,-0.2)}
  move
  fuse(,HC,0.5,0.3) ; {"`...(,HC,0.5,0.3)'" at last line.c+(0,-0.25)}
  move
  cbreaker; {"`cbreaker'" at last line.c+(0,-0.2)}
  move
  cbreaker(,R,D); {"`...(,R,D)'" at last line.c+(0,-0.2)}
  move
  cbreaker(,,T); {"`...(,,T)'" at last line.c+(0,-0.2)}
  move
  cbreaker(,,TS); {"`...(,,TS)'" at last line.c+(0,-0.2) }
  }
  move down; right_
  {
  jumper ; {"`jumper'" at last line.c+(0,-0.2) }
  move
  jumper(,CJBED) ; {"`...(,CJBED)'" at last line.c+(0,-0.2) }
  move
  jumper(,body=outlined "gray" shaded "gray")
  { "`...(,body=outlined \"gray\" 'svg_backsl" wid 122bp__ \
      with .w at (last line.start, last "")
    "` shaded \"gray\")'" at last "".sw+(0,-10bp__) ljust }
  }

 command "</g>" # end font
.PE
