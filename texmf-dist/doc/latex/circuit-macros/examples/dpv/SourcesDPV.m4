.PS
# `SourcesDPV.m4'
cct_init(svg_font(sans-serif,11bp__))
textwid = 0.7
movewid = 2pt__
moveht = 0.275
define(`NL',`; move down $1; right_')
{
   {source     ; move ; "`source'" ljust} NL
   {source(,I) ; move ; "`source(,I)'" ljust} NL
   {C:source(,i) ; move ; "`source(,i)'" ljust} NL
   {D:source(,ti) ; move ; "`source(,ti)'" ljust} NL
   {source(,ii) ; move ; "`source(,ii)'" ljust} NL
   {source(,V) ; move ; "`source(,V)'" ljust} NL
   {source(,v) ; move ; "`source(,v)'" ljust} NL
   {source(,tv) ; move ; "`source(,tv)'" ljust} NL
   {source(,SC) ; move ; "`source(,SC)'" ljust} NL
   {source(,AC); move ; "`source(,AC)'" ljust} NL
   {source(,X) ; move ; "`source(,X)'" ljust} NL
   {source(,G) ; move ; "`source(,G)'" ljust} NL
   {source(,Q) ; move ; "`source(,Q)'" ljust} NL #(0.3)
   {source(,F) ; move ; "`source(,F)'" ljust} NL
   {geiger(,,,,fill_(0.9)); move;
     "`geiger(,,,,'" ljust "`fill_(0.9))'" ljust} NL
}
   move right_ 2.0

{
   {source(,,0.4,,shaded "yellow") ; move ;
  "`source(,,0.4,,'" ljust "`shaded \"yellow\")'" ljust} NL(0.35)
   {source(,P) ; move ; "`source(,P)'" ljust} NL
   {source(,U) ; move ; "`source(,U)'" ljust} NL
   {source(,H) ; move ; "`source(,H)'" ljust} NL
   {source(,R) ; move ; "`source(,R)'" ljust} NL
   {source(,S) ; move ; "`source(,S)'" ljust} NL
   {source(,SCr) ; move ; "`source(,SCr)'" ljust} NL
   {source(,T) ; move ; "`source(,T)'" ljust} NL
   {source(,L) ; move ; "`source(,L)'" ljust} NL
   {source(,B) ; move ; "`source(,B)'" ljust} NL(moveht*0.8)
   {nullator   ; move ; "`nullator'" ljust} NL(moveht*0.8)
   {norator    ; move ; "`norator'" ljust} NL(moveht*0.9)
   {ttmotor(,G)   ; move ;  "`ttmotor(,G)'" ljust} NL(moveht*1.1)
   {battery       ; move ;  "`battery'" ljust}       NL(0.3)
   {battery(,3,R) ; move ;  "`battery(,3,R)'" ljust}

}
   move right_ 2.0
   {source(,N) ; move ; "`source(,N)'" ljust} NL
   {source(,NA) ; move ; "`source(,NA)'" ljust} NL
   {source(,NB) ; move ; "`source(,NB)'" ljust} NL
   {source(,"mA");move; "`source(,\"mA\")'" ljust} NL(0.31)
   {consource     ; move ;  "`consource'" ljust}     NL(0.32)
   {consource(,I) ; move ;  "`consource(,I)'" ljust} NL(0.32)
   {consource(,i) ; move ;  "`consource(,i)'" ljust} NL(0.32)
   {consource(,ti) ; move ;  "`consource(,ti)'" ljust} NL(0.32)
   {source(,SE) ; move ; "`source(,SE)'" ljust} NL
   {consource(,V) ; move ;  "`consource(,V)'" ljust} NL(0.32)
   {consource(,v) ; move ;  "`consource(,v)'" ljust} NL(0.3)
   {consource(,tv) ; move ;  "`consource(,tv)'" ljust} NL(0.3)
   {proximity ; move ;
     "`proximity'" ljust "` = consource(,P)'" wid 80bp__ ljust} NL(0.35)

 command "</g>" # end font
.PE
