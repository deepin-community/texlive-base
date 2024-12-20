.PS
# BtreeDPV.m4
# One way to draw a binary tree using pic macros
gen_init(svg_font(sans-serif,11bp__))
sinclude(tst.dim)
s_init(Btree)
maxpswid = 12
Btree: [
circlerad = 0.35

define n { [C: circle fill_(0.9) $1
            if "$2" != "" then {
              L: $2 with .ne at C.s-(circlerad/20, circlerad/2)
              line from C to L.C chop }
            if "$3" != "" then {
              R: $3 with .nw at C.s+(circlerad/20,-circlerad/2)
              line from C to R.C chop }
            ] }

# Redrawn from T. A. Standish, "Data Structure Techniques," Addison-Wesley 1980.
# Node data:
define Sirius { n("Sirius",Canopus,Vega) }
define Canopus { n("Canopus",AlphaCentauri,Capella) }
define AlphaCentauri { n("Alpha" "Centauri",Achernar,Arcturus) }
define Arcturus { n("Arcturus",Betelgeux) }
define Betelgeux { n("Betelgeux",BetaCentauri) }
define Capella { n("Capella",Rigel) }
define Rigel { n("Rigel",Procyon) }
define Achernar { n("Achernar") }
define BetaCentauri { n("Beta" "Centauri") }
define Procyon { n("Procyon") }
define Vega { n("Vega") }

# Build the tree from the root
S: Sirius

 command "</g>" # end font
]
Ttree: [
# TtreeDPV.m4
svg_font(sans-serif,10bp__)

#                           `Node(no in row, head [location],
#                              displacement of top of body (.n) wrt head,
#                              body Node 1, body Node 2, ...) '
define(`Node',`
  Head`$1': `$2'
  ifelse(`$3',,,` Body`$1': [
    Loopover_(`v',`v; define(`m4ct',m4Lx)',shift(shift(shift($@))))
    ] with .n at Head`$1' + `$3'
  connect(`$1',m4ct)')')

define(`connect',`Bot: move from Head$1.sw-(0,5bp__) to Head$1.se-(0,5bp__)
for_(1,`$2',1,
 `Top: move from Body$1.Head`'m4x.nw+(0,2bp__) \
              to Body$1.Head`'m4x.ne+(0,2bp__)
  Mov: move from Head$1 to Body$1.Head`'m4x
  if Bot.len*Top.len*Mov.len > 0 then {
    line from Intersect_(Mov,Top) to Intersect_(Mov,Bot)}')')

  vsep = 0.75
define(`txw',`wid `$1'mm__')dnl scaled by 14/12 for 14 pt type

  Node(1,"svg_it(h(h(h(x`'svg_sub(1),x`'svg_sub(2))," \
       + "h(x`'svg_sub(3),x`'svg_sub(4))),h(h(x`'svg_sub(5),x`'svg_sub(6))," \
       + "h(x`'svg_sub(7),x`'svg_sub(8)))))" txw(70) ,
     (0,-vsep),
     Node(1,"svg_it(h(h(x`'svg_sub(1),x`'svg_sub(2)),h(x`'svg_sub(3)," \
          + "x`'svg_sub(4))))" txw(32) ,
        (0,-vsep),
        Node(1,"svg_it(h(x`'svg_sub(1),x`'svg_sub(2)))" txw(14) ,
           (0,-vsep),
           Node(1,"svg_it(x`'svg_sub(1):=((A,pk`'svg_sub(A)),h`'svg_sub(1)))" \
                  txw(29) ),
           Node(2,"svg_it(x`'svg_sub(2):=((B,pk`'svg_sub(B)),h`'svg_sub(2)))" \
                  txw(29) with .n at last "".ne+(0.2,-vsep*2/3))),
        Node(2,"svg_it(h(x`'svg_sub(3),x`'svg_sub(4)))" txw(14) \
                  with .nw at Head1.ne+(Body1.wid/2+0.1,0),
           (0,-vsep),
           Node(1,"svg_it(x`'svg_sub(3):=" \
                + "((A,pk`'svg_prime`'svg_sub(A,,,-0.5ex)),h`'svg_sub(3)))" \
                  txw(29)),
           Node(2,"svg_it(x`'svg_sub(4):=((D,pk`'svg_sub(D)),h`'svg_sub(4)))" \
                  txw(29) with .n at last "".ne+(0.2,-vsep*2/3)))),
     Node(2,"svg_it(h(h(x`'svg_sub(5),x`'svg_sub(6)),h(x`'svg_sub(7)," \
          + "x`'svg_sub(8))))" txw(29) with .nw at Head1.ne+(Body1.wid/2,0),
        (0,-vsep),
        Node(1, "svg_it(h(x`'svg_sub(5),x`'svg_sub(6)))" txw(14) ,
           (0,-vsep*5/4),
           Node(1,"svg_it(x`'svg_sub(5):=((E,pk`'svg_sub(E)),h`'svg_sub(5)))" \
                  txw(29) ),
           Node(2,"svg_it(x`'svg_sub(6):=((H,pk`'svg_sub(H)),h`'svg_sub(6)))" \
                  txw(29) with .n at last "".ne+(0.2,-vsep*2/3))),
        Node(2,"svg_it(h(x`'svg_sub(7),x`'svg_sub(8)))" txw(14) \
                  with .nw at Head1.ne+(Body1.wid/2+0.1,0),
           (0,-vsep*5/4),
           Node(1,"svg_it(x`'svg_sub(7):=" \
                + "((D,pk`'svg_prime`'svg_sub(D,,,-0.5ex)),h`'svg_sub(7)))" \
                  txw(29) ),
           Node(2,"svg_it(x`'svg_sub(8):=((K,pk`'svg_sub(K)),h`'svg_sub(8)))" \
                  txw(29) with .n at last "".ne+(0.2,-vsep*2/3); \
                  move right 0.2)),
        Node(3,"svg_it(h(x`'svg_sub(9)))" txw(8) \
                  at 0.5 between Head1 and Head2)))

] with .w at last [].e+(-1,0)

 command "</g>" # end font
.PE
