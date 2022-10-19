.PS
# test.m4
gen_init

divert(-1)

divert(0)dnl

gs = 0.1
gw = 3
gh = 3
define grid {($1*gs,$2*gs)}
B: box invis wid gw+2 ht gh+2 with .c at (0,0)
bix = gw/gs/2
G:[
C: 0,0
for i=-bix to bix do { line wid 0.4 outlined "gray" from grid(-bix,i) right gw }
for i=-bix to bix by 5 do { sprintf("%g",i) at grid(-bix,i) rjust }
for j=-bix to bix do { line wid 0.4 outlined "gray" from grid(j,-bix) up gh }
for j=-bix to bix by 5 do { sprintf("%g",j) at grid(j,-bix) below }

  line from grid(-bix,0) right gw
  line from grid(0,-bix) up gh
] with .C at B

textoffset = 0
xwid = 0.71; svg_font(Times,72bp__)
#xwid = 0.65; svg_font(sans-serif,72bp__)
#xwid = 0.64; svg_font(Arial,1)
#xwid = 0.64; svg_font(Helvetica,1)
#xwid = 0.54; svg_font(Courier,1)
#xwid = 0.67; svg_font(Cursive,1)
#xwid = 0.64; svg_font(Verdana,1)
#xwid = 0.70; svg_font(Georgia,1)
#xwid = 0.70; svg_font(Palatino,1)
#xwid = 0.70; svg_font(Garamond,1)
#xwid = 0.70; svg_font(Bookman,1)
##xwid = 0.70; svg_font(Comic Sans MS,1)
#xwid = 0.55; svg_font(Trebuchet MS,1)
#xwid = 0.78; svg_font(Arial Black,1)
#xwid = 0.49; svg_font(Impact,1)
[
C: 0,0
 "X" wid xwid at grid(0,0) above ljust ; showbox_(last "")
 "X" wid xwid at grid(0,0) below ljust ; showbox_(last "")
 "X" wid xwid at grid(0,0) above rjust ; showbox_(last "")
 "X" wid xwid at grid(0,0) below rjust ; showbox_(last "")
] with .C at G.C
[
  Q: box wid gw ht gh "X" ljust "Y" rjust "Z"
    line from Q.n to Q.s; line from Q.w to Q.e
] with .w at B.e

 "X" wid xwid at G.n above; showbox_(last "")


  command "</g>"
.PE
