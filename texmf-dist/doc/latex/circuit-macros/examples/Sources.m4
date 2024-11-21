.PS
# `Sources.m4'
cct_init

iflatex(`ifpsfrag(,`latexcommand({\sf)') ')

movewid = 2pt__
moveht = 0.275
define(`NL',`; move down $1; right_')
{
   {source     ; move ; "`\tt source'" ljust} NL
   {source(,I) ; move ; "`\tt source(,I)'" ljust} NL
   {C:source(,i) ; move ; "`\tt source(,i)'" ljust} NL
   {D:source(,ti) ; move ; "`\tt source(,ti)'" ljust} NL
   {source(,ii) ; move ; "`\tt source(,ii)'" ljust} NL
   {source(,V) ; move ; "`\tt source(,V)'" ljust} NL
   {source(,v) ; move ; "`\tt source(,v)'" ljust} NL
   {source(,tv) ; move ; "`\tt source(,tv)'" ljust} NL
   {source(,SC) ; move ; "`\tt source(,SC)'" ljust} NL
   {source(,AC); move ; "`\tt source(,AC)'" ljust} NL
   {source(,X) ; move ; "`\tt source(,X)'" ljust} NL
   {source(,G) ; move ; "`\tt source(,G)'" ljust} NL
   {source(,Q) ; move ; "`\tt source(,Q)'" ljust} NL #(0.3)
   {source(,F) ; move ; "`\tt source(,F)'" ljust} NL
   {geiger(,,,,fill_(0.9)); move;
     "`\tt \shortstack[l]{geiger(,{,},{,}\\ fill\_(0.9))}'" ljust} NL
}
   move right_ 2.0
{
   {source(,,0.4,,shaded "yellow") ; move ;
  "`\tt\shortstack[l]{source(,{,}0.4,{,}\\ shaded \"yellow\")}'" ljust} NL(0.35)
   {source(,P) ; move ; "`\tt source(,P)'" ljust} NL
   {source(,U) ; move ; "`\tt source(,U)'" ljust} NL
   {source(,H) ; move ; "`\tt source(,H)'" ljust} NL
   {source(,R) ; move ; "`\tt source(,R)'" ljust} NL
   {source(,S) ; move ; "`\tt source(,S)'" ljust} NL
   {source(,SCr) ; move ; "`\tt source(,SCr)'" ljust} NL
   {source(,T) ; move ; "`\tt source(,T)'" ljust} NL
   {source(,L) ; move ; "`\tt source(,L)'" ljust} NL
   {source(,B) ; move ; "`\tt source(,B)'" ljust} NL(moveht*0.8)
   {nullator   ; move ; "`\tt nullator'" ljust} NL(moveht*0.8)
   {norator    ; move ; "`\tt norator'" ljust} NL(moveht*0.9)
   {ttmotor(,G)   ; move ;  "`\tt ttmotor(,G)'" ljust} NL(moveht*1.1)
   {battery       ; move ;  "`\tt battery'" ljust}       NL(0.3)
   {battery(,3,R) ; move ;  "`\tt battery(,3,R)'" ljust} #NL(0.35)
}
   move right_ 2.0
   {source(,N) ; move ; "`\tt source(,N)'" ljust} NL
   {source(,NA) ; move ; "`\tt source(,NA)'" ljust} NL
   {source(,NB) ; move ; "`\tt source(,NB)'" ljust} NL
   {source(,"\rm mA");move; "`\tt source(,\"mA\")'" ljust} NL(0.31)
   {consource     ; move ;  "`\tt consource'" ljust}     NL(0.32)
   {consource(,I) ; move ;  "`\tt consource(,I)'" ljust} NL(0.32)
   {consource(,i) ; move ;  "`\tt consource(,i)'" ljust} NL(0.32)
   {consource(,ti) ; move ;  "`\tt consource(,ti)'" ljust} NL(0.32)
   {source(,SE) ; move ; "`\tt source(,SE)'" ljust} NL
   {consource(,V) ; move ;  "`\tt consource(,V)'" ljust} NL(0.32)
   {consource(,v) ; move ;  "`\tt consource(,v)'" ljust} NL(0.3)
   {consource(,tv) ; move ;  "`\tt consource(,tv)'" ljust} NL(0.3)
   {proximity ; move ;
     "`\tt \shortstack[l]{proximity\\ = consource(,P)}'" ljust} NL(0.35)

iflatex(`ifpsfrag(,`latexcommand(})')')
.PE
