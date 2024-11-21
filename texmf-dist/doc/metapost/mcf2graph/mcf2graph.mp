%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mcf2graph ver 5.13    Copyright (c) 2013-2024   Akira Yamaji
%
% Permission is hereby granted, free of charge, to any person obtaining a copy of this software
% and associated documentation files (the "Software"), to deal in the Software without restriction,
% including without limitation the rights to use, copy, modify, merge, publish, distribute,
% sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all copies
% or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,EXPRESS OR IMPLIED,
% INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,FITNESS FOR A PARTICULAR PURPOSE
% AND NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
%-------------------------------------------------------------------------------------------------
%  mcf2graph is MetaPost macro package convert Molecular Coding Format(MCF) to graphic file
%  sgv/eps/png/mdl molfile
%-------------------------------------------------------------------------------------------------
% This package is located at : http://www.ctan.org/pkg/mcf2graph
% Suggestion or request mail to : mcf2graph@gmail.com 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
message "* This is mcf2graph ver 5.13  2024.11.10";
tracingstats:=1; prologues:=3; warningcheck:=0;
%-------------------------------------------------------------------------------------------------
newinternal string EN_;
numeric save_num[],pcode_com[][],pcode_par[][],pcode_cnt[],tbl_atom[],tbl_group[][],tbl_atom_wt[],
        tbl_atom_mi[],tbl_char_wd[],tbl_char_ht[],at_char[],mc_indent[],op_indent[],ex_indent[],
        ad_indent[],unit_lines[],info[],tbl_asc[],lenw[];
string  row[][],save_str[],tbl_atom_str[],str_tbl[],arg_s[],mc[],ex[],ad[],op[],tag[],rw[],
        lib_tag[][],lib_val[][],mc,ex,ad,op,aux_delimiter,default_library,EN,FM,MW,MI,CAT,JN,CAS,
        USE,EXA,EXB,file_input,file_output,default_temp_file,mpfont,atomfont,tempc,temps,blanks,
        sC,sI,sS,sT,sV,forbiddens;
pair    save_pair[],msize,mposition,fsize,fmargin,save_mposition;
%-------------------------------------------------------------------------------------------------
fig_num:=str_cnt:=tbl_cnt:=mangle:=sw_frame:=sw_trimming:=sw_ext_all:=sw_abbreviate:=sw_expand:=0;
sw_comment:=sw_output:=sw_numbering:=tag_cnt:=rw_cnt:=pcode_all:=0; 
numbering_start:=1; numbering_end:=4095;
%-------------------------------------------------------------------------------------------------
aux_delimiter:=";"; blanks:= "            ";  forbiddens:=" &()[]{}^=;!'+,`~";
for s="No","EN","JN","MW","MI","FM","CAT","CAS","USE","EXA","EXB": tag[incr tag_cnt]:=s; endfor
MW_n:=0; Fig:=1; Mcode:=2; Calc:=4; Info:=8; Table:=16; Report:=32; MOL2k:=64; MOL3k:=128;
Atom:=8; Bond:=16; Group:=32; Mol:=64; Outside:=1; Inside:=2; Bothside:=Outside+Inside;
%-------------------------------------------------------------------------------------------------
PRS:=ASCII("(");PRE:=ASCII(")");BRS:=ASCII("{");BRE:=ASCII("}");BKS:=ASCII("[");BKE:=ASCII("]");
CMA:=ASCII(",");EQU:=ASCII("=");AST:=ASCII("*");SLS:=ASCII("/");GTN:=ASCII("<");LTN:=ASCII(">");
AMP:=ASCII("&");HSH:=ASCII("#");HAT:=ASCII("^");TLD:=ASCII("~");BQT:=ASCII("`");CLN:=ASCII(":");
AMK:=ASCII("@");QUT:=ASCII("'");BAR:=ASCII("|");PLS:=ASCII("+");MIS:=ASCII("-");BLK:=ASCII(" ");
BSL:=ASCII("\");QES:=ASCII("?");
%-------------------------------------------------------------------------------------------------
for s="??!","!?!","!!!","!?","?!","??","*/*","/*","*/","//","**","##","||","\\":
  rw[incr rw_cnt]:=s; lenw[rw_cnt]:=length(s); endfor
%-------------------------------------------------------------------------------------------------
let DIV= /; let MUL= *; let LT= <; let GT= >; let AND= &; let :: = : ; let == = =; let ef=elseif;
let ISP=intersectionpoint; def ]]]=] ] ] enddef; let +++ = ++; let +- = +;
%-------------------------------------------------------------------------------------------------
def ext(text t)= sw_ext_all:=1; def EXT_ALL = t enddef; enddef;
def ext_clear= sw_ext_all:=0; def EXT_ALL = enddef; enddef;
def wpcs expr n= withpen pencircle scaled n enddef;
def ppcs expr n= pickup pencircle scaled n enddef;
def sbp(expr m,n)expr p=subpath(m*length(p),n*length(p)) of p enddef;
def printf expr s= write s to file_output enddef;
def warning(expr s)= message "% "&decimal(fig_num)&fdr(3)(incr warning_cnt)&")"&s; enddef;
%-------------------------------------------------------------------------------------------------
vardef frac primary n= n-floor n enddef;
vardef iif(expr a,b,c)=if a: b else: c fi enddef;
vardef subc(expr i,s)= substring(i-1,i) of s enddef;
vardef sfrt(expr a,b,c)= a shifted ((b,0) rotated c) enddef;
vardef fsr(expr n)(expr s)= (substring(0,n-length(s)) of blanks)&s enddef;
vardef fsl(expr n)(expr s)= s&(substring(0,n-length(s)) of blanks) enddef;
vardef fdr(expr n)(expr s)=
  if length(decimal(s))>n: substring (0,n) of decimal(s) else: fsr(n)(decimal(s)) fi enddef;
vardef fdl(expr n)(expr s)= fsl(n)(decimal(s)) enddef;
vardef Incr suffix $ == $:=$+-1; $ enddef;
%=================================================================================================
default_library:="main_lib.mcf"; default_temp_file:="temp.mcf";
mpfont:="uhvr8r"; atomfont:="draw"; defaultfont:=mpfont;
%--default ahangle=45---------------------------------------------------------------------
if ahangle=1:  outputformat:="png"; hppp:=vppp:=0.12;   % png format(600dpi)
ef ahangle=11: outputformat:="png"; hppp:=vppp:=0.06;   % png format(1200dpi)
ef ahangle=2:  outputformat:="eps";                     % eps format(.eps)
ef ahangle=3:  outputformat:="eps";                     % eps format(.mps)
ef ahangle=45: outputformat:="svg";                     % svg format  *default
fi
%--default ahlength=4---------------------------------------------------------------------
if ahlength=3:  sw_output:=Fig; sw_expand:=1;           % output figure(expanded)
ef ahlength=4:  sw_output:=Fig;                         % output figure *default
ef ahlength=5:  sw_output:=MOL2k; sw_expand:=1;         % output MOL(V2000)
ef ahlength=6:  sw_output:=MOL3k; sw_expand:=1;         % output MOL(V3000)
ef ahlength=7:  sw_output:=Report;                      % output report
fi
%-- default bboxmargin=2------------------------------------------------------------------
if bboxmargin=3: ext(defaultfont:=mpfont; defaultscale:=.3; label.rt(EN,(0,0));)
ef bboxmargin=4: sw_output:=Fig+Calc;
  ext(defaultfont:=mpfont; defaultscale:=.3;
  label.rt(EN&" / "&MW&" / "&decimal(MW_n-scantokens(MW)),(0,0));) fi
%--default outputtemplate:="%j-%3c."&"svg"------------------------------------------------
if outputformat="svg":                 outputtemplate:="s%3c-%{EN_}.svg";
ef outputformat="png":                 outputtemplate:="p%3c-%{EN_}.png";
ef (outputformat="eps")and(ahangle=3): outputtemplate:="%j-%3c.mps";
else:                                  outputtemplate:="%j-%3c."&outputformat; fi
%-----------------------------------------------------------------------------------------
message "* jobname="&jobname;
message "* numbersystem="&numbersystem;
message "* outputformat="&outputformat;
message "* outputtemplate="&outputtemplate;
if ahlength=5: message "* output MOL file(V2000)"; message "* "&jobname&"-nnn-"&"EN"&".mol";
ef ahlength=6: message "* output MOL file(V3000)"; message "* "&jobname&"-nnn-"&"EN"&".mol";
ef ahlength=7: message "* output report file"; message "* file name="&jobname&"-report.txt"; fi
clearit;
%-------------------------------------------------------------------------------------------------
ratio_chain_ring:=0.66; ratio_atom_bond:=0.36; ratio_thickness_bond:=0.015;
ratio_thickness_char:=0.1; ratio_char_bond:=1.5; ratio_bondgap_bond:=0.15;
ratio_hashgap_bond:=0.12; ratio_hash_black:=0.4; ratio_wedge_bond:=0.12; ratio_atomgap_atom:=0.04;
offset_thickness:=0.2; offset_bond_gap:=0.3; offset_hash_gap:=0.1; offset_atom:=0.8;
offset_wedge:=0.4; thickness_frame:=0.2;
max_blength:=10mm; blength:=mangle:=0; max_labelsize:=20mm; dottedline_gap:=1.5;
fsize:=(30mm,20mm); fmargin:=(0.4mm,0.4mm); msize:=(1,1); mposition:=(0.5,0.5);
ahangle:=45; ahlength:=4; defaultsize:=8; defaultscale:=1; labeloffset:=3; ext_defaultline:=0.5;
lonepairdiam:=lonepairspace:=circlediam:=circlepen:=bboxmargin:=0; mc_length:=100;
outputformatoptions:="";
%=================================================================================================
pcode_emb_start:=1001;     % 1001 => 1900   for embedded pcode (max 900)
pcode_emi_start:=1901;     % 1901 => 2000   for embedded internal pcode (max 100)
pcode_usr_start:=2001;     % 2001 => 3000   for user     pcode (max 1000)
pcode_int_start:=3000;     % 3001 => 4000   for internal pcode (max 1000)
%-------------------------------------------------------------------------------------------------
def def_com(expr n)(text tx)= nA:=n; forsuffixes list=tx:: list:=nA; nA:=nA+1; endfor enddef;
def_com(-4090)(_com,_jp_atom,_jp_absA,_jp_bond,_cyc,_cyc_sB,_cyc_eB,_set_line,_tmp_line,_chg_len,
  _get_len,_ring_len,_tmp_len,_rot_ang,_adj_ang,_chg_env,_tmp_env,_set_colorA,_set_colorB,
  _group_si,_group_dm,_group_wf,_group_zf,_set_adr,_mk_bond,_set_atom,_arrange_ang,_chg_atom,
  _tmp_rot,_fuse,_size_atom,_numeric,_jump_at,_set_add,_chg_add,_nop,_mark,_moff,_term,_len_s,
  _len_e,_len_ss,_len_ee,_group_s,_group_e,_rest,_charge,_from,_until,
  si,dl,dl_,dr,dr_,db,dm,dm_,tm,wf,wb,bd,bz,zf,zb,dt,wv,nl,vf,vb,nb,wf_r,wb_r,bd_r,arc_lb,arc_br,
  arc_lbr,arc_ltr,si_,wf_,wb_,zf_,zb_,wv_,bd_);
%-------------------------------------------------------------------------------------------------
def parameter_list=
  sw_numbering,sw_expand,sw_output,sw_ext_all,sw_frame,sw_trimming,sw_abbreviate,ratio_atom_bond,
  ratio_thickness_bond,ratio_char_bond,ratio_chain_ring,ratio_bondgap_bond,ratio_hash_black,
  ratio_hashgap_bond,ratio_thickness_char,ratio_wedge_bond,ratio_atomgap_atom,lonepairdiam,
  lonepairspace,offset_atom,offset_wedge,max_blength,offset_hash_gap,offset_bond_gap,
  thickness_frame,offset_thickness,numbering_start,numbering_end,defaultsize,defaultscale,
  labeloffset,mangle,blength,fsize,fmargin,msize,mposition,defaultfont,atomfont,dottedline_gap
enddef;
%-------------------------------------------------------------------------------------------------
def init_par(text t)= nA:=nB:=nC:=0;
  for list=t: if numeric list: save_num[incr nA]:=list;
              ef pair list:    save_pair[incr nB]:=list;
              ef string list:  save_str[incr nC]:=list;
              fi
  endfor
enddef;
%-------------------------------------------------------------------------------------------------
def store_par(text t)= nA:=nB:=nC:=0;
  for list=t: if numeric list: if save_num[incr nA]<>list:  save_num[nA]:=list; fi
              ef pair list:    if save_pair[incr nB]<>list: save_pair[nB]:=list; fi
              ef string list:  if save_str[incr nC]<>list:  save_str[nC]:=list; fi
              fi
  endfor
enddef;
%-------------------------------------------------------------------------------------------------
def restore_par(text t)= nA:=nB:=nC:=0;
  forsuffixes list=t: if numeric list: if list<>save_num[incr nA]:  list:=save_num[nA]; fi
                      ef pair    list: if list<>save_pair[incr nB]: list:=save_pair[nB]; fi
                      ef string  list: if list<>save_str[incr nC]:  list:=save_str[nC]; fi
                      fi
  endfor
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def beginfigm=
  begingroup
  save ','',`,``,//,@,#,#@,##,\,\\,\*,|=,|<,**,++,_,f_ext,blen,ext,add,ang_br,fw_n,bw_n,
       info_cnt,bond_cntA,firstc,warning_cnt,hideH,hideH_cnt,cntM,cntA,cntB,
       minX,minY,maxX,maxY,posA,posM,lineB,sB,eB,angB,angA,lenB,angX,numS,sumA,bond_num,wdM,htM,
       chargeA,addA,add_rot,mol_pic,color_list,filter_s,no,mw,mi,fm;
  numeric hideH[],lineB[],sB[],eB[],angB[],angA[],lenB[],angX[],strA[],sumA[],bond_num[],
          wdM[],htM[],chargeA[],addA[],add_rot[];
  pair posA[],posM[][];
  string mi,no,fm,mw,firstc,filter_s;
  picture mol_pic[];
  color color_list[];
  %-----------------------------------------------------------------------------------------------
  store_par(parameter_list);
  no:=mc:=ex:=ad:=op:=temps:=mw:=mi:=fm:=filter_s:="";
  EN:=JN:=MW:=FM:=MI:=CAS:=CAT:=EXA:=EXB:=USE:="-";
  f_ext:=cntM:=mc_row:=ex_row:=ad_row:=op_row:=info_cnt:=err_cnt:=0;
  let ext=ext_to_fig; let add=add_to_molecule; let ++=add_to_molecule; let **=ext_to_fig;
  def '' = define_parts enddef; def '` = readm enddef;
  def \ = drawm enddef; def \\ = putm enddef;
  def \* = checkm enddef; def $ = getm enddef; def @ expr p = mposition:=p; enddef;
  def # expr p = fsize:=p; enddef; def #@ expr p = fmargin:=p; enddef; 
  def `(expr s) = define_group_string(s)() enddef; def `` = define_group_string enddef;
  def ## expr p = msize:=p; enddef; def |=(expr n) = blength:=n; enddef;
  def |<(expr n) = max_blength:=n; enddef; def _ expr s = EN:=s; enddef;
  pcode_num:=pcode_usr_start; pcode_int:=pcode_int_start; fig_num:=fig_num+1;
  mol_pic[0]:=nullpicture;
enddef;
%-------------------------------------------------------------------------------------------------
def endfigm=
  %--------------------------------------------------------------------------------------------
  if cntM>=1:
  %--------------------------------------------------------------------------------------------
  if scan_bit(sw_output,Fig):
    if EN<>"-": EN_:=forbidden_to_underbar(EN); fi
    beginfig(fig_num)
    %------------------------------------------------------------------------------------------
      if sw_ext_all=1: ext_to_fig(EXT_ALL); fi
      if sw_trimming>=1:
        nA:=nC:=4095; nB:=nD:=-4095;
        for i=1 upto cntM:
          if xpart(posM[1][i])<nA: nA:=xpart(posM[1][i]); fi
          if xpart(posM[2][i])>nB: nB:=xpart(posM[2][i]); fi
          if ypart(posM[1][i])<nC: nC:=ypart(posM[1][i]); fi
          if ypart(posM[2][i])>nD: nD:=ypart(posM[2][i]); fi
        endfor
        fig_wd:=nB-nA+2xpart(fmargin); fig_ht:=nD-nC+2ypart(fmargin); fsize:=(fig_wd,fig_ht);
        for i=1 upto cntM:
          posM[0][i]:=posM[0][i]+fmargin-(nA,nC); posM[1][i]:=posM[1][i]+fmargin-(nA,nC);
        endfor
      fi
      %----------------------------------------------------------------------------------------
      if scan_bit(sw_frame,Outside): draw_frame((0,0),fsize,thickness_frame);
      else:                          draw_corner(fsize,0.004); fi
      if scan_bit(sw_frame,Inside): draw_frame(fmargin,fsize-2fmargin,thickness_frame); fi
      for i=1 upto cntM:
        addto currentpicture also mol_pic[i] shifted posM[0][i]; mol_pic[i]:=nullpicture;
        if scan_bit(sw_frame,Mol): ext(draw_frame(p[i],(w[i],h[i]),thickness_frame)) fi
      endfor
      if f_ext=1: addto currentpicture also mol_pic[0]; mol_pic[0]:=nullpicture; fi
    %-----------------------------------------------------------------------------------------
    endfig;
    clearit;
  fi
  %---------------------------------------------------------------------------------------------
  if scan_bit(sw_output,Report): proc_report_out; fi
  if scan_bit(sw_output,MOL2k):  proc_mol_out(2000); fi
  if scan_bit(sw_output,MOL3k):  proc_mol_out(3000); fi
  %---------------------------------------------------------------------------------------------
  ef scan_bit(sw_output,Fig):
    EN_:="no_figure";
    beginfig(fig_num)
    defaultscale:=.6; draw_frame((0,0),fsize,thickness_frame) label("no figure",0.5fsize);
    endfig;
    clearit;
  fi
  %---------------------------------------------------------------------------------------------
  if err_cnt=0:
    if scan_bit(sw_output,Mcode):  proc_mc_out;         message "["&decimal(fig_num)&"]:"&EN; fi
    if scan_bit(sw_output,Report): proc_report_out;     message "["&decimal(fig_num)&"]:"&EN; fi
    if scan_bit(sw_output,MOL2k):  proc_mol_out(2000);  message "["&decimal(fig_num)&"]:"&EN; fi
    if scan_bit(sw_output,MOL3k):  proc_mol_out(3000);  message "["&decimal(fig_num)&"]:"&EN; fi
  fi
  %---------------------------------------------------------------------------------------------
  restore_par(parameter_list);
  endgroup;
enddef;
%=================================================================================================
def readm(text s)=
  save fw_n,bw_n;
  for list=s:
    fw_n:=scan_char(" ",list,1,1)-1; bw_n:=scan_char(" ",list,-1,1);
    mc_indent[incr mc_row]:=fw_n; mc[mc_row]:=substring(fw_n,bw_n) of list; mc:=mc&mc[mc_row];
  endfor
enddef;
%=================================================================================================
def getm(expr a)=if string a: read_unit(get_adr("EN",a)) ef numeric a: read_unit(a) fi enddef;
%-------------------------------------------------------------------------------------------------
def read_unit(expr n)=
  save nF; nF:=0;
  if (n>=1)and(n<=ucount):
    for i=1 upto info[n]:
      for j=1 upto tag_cnt: if lib_tag[n][i]=tag[j]: scantokens(tag[j]):=lib_val[n][i]; fi endfor
    endfor
    for i=1 upto unit_lines[n]:
      temps:=row[n][i]; firstc:=subc(1,temps); exitif firstc=";";
      if firstc=":": nF:=1; ef firstc="=": nF:=2; ef firstc="*": nF:=3; ef firstc="+": nF:=4;
      ef firstc="%":
      else:
        fw_n:=scan_char(" ",temps,1,1)-1; temps:=substring(fw_n,length(temps)) of temps;
        if nF=1: mc_indent[incr mc_row]:=fw_n; mc[mc_row]:=temps; mc:=mc&temps;
        ef nF=2: op_indent[incr op_row]:=fw_n; op[op_row]:=temps; op:=op&temps;
        ef nF=3: ex_indent[incr ex_row]:=fw_n; ex[ex_row]:=temps; ex:=ex&temps;
        ef nF=4: ad_indent[incr ad_row]:=fw_n; ad[ad_row]:=temps; ad:=ad&temps;
        fi
      fi
    endfor
  fi 
enddef;
%=================================================================================================
vardef get_adr(expr t,v)=
  save adr_n; adr_n:=0;
  for n=1 upto ucount:
    for i=1 upto info[n]:
      for j=1 upto tag_cnt: if (lib_tag[n][i]=t)and(lib_val[n][i]=v): adr_n:=n; fi endfor
      exitif adr_n>=1;
    endfor
  endfor
  message if adr_n>1: "* found [" else: "* not found [" fi &v&"]"&"("&decimal(adr_n)&")";
  adr_n
enddef;
%-------------------------------------------------------------------------------------------------
def putm=
  if op_row>=1: scantokens(op) fi
  if mc_row>=1: if checkm(mc)=0: drawm(scantokens(mc)) fi fi
  if ad_row>=1: add(scantokens(ad)) fi
  if ex_row>=1: ext(scantokens(ex)) fi
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef define_parts(text t)= pcode_num:=pcode_num+-1; read_mcf(pcode_num)(t); pcode_num enddef;
vardef abs_adress primary n = if n LT 0:: (n+-360)-4095 else:: n-4095 fi enddef;
primarydef a from_until b = (_from,a),(_until,b) enddef;
primarydef a op_quot b = add_parts(a,b) enddef;
tertiarydef a bond__bond b = (a,b) enddef;
tertiarydef a bond___bond b = (a+-2000,b) enddef;
tertiarydef a bond____bond b = (a+-2000,b+-2000) enddef;
tertiarydef a op_equ b = if (known a)and(known b):: change_bond(a,b) else:: _nop fi enddef; 
tertiarydef a op_col b = if (known a)and(known b):: change_atom(a,b) else:: _nop fi enddef;
tertiarydef a op_hat b = if known b:: (_tmp_rot,b),a  else:: _nop,a fi enddef;
tertiarydef a op_til b = if known b:: (_tmp_line,b),a else:: _nop,a fi enddef;
tertiarydef a op_lth b = if known b:: (_tmp_env,b),a  else:: _nop,a fi enddef;
tertiarydef a op_bqu b = if known b:: (_tmp_len,b),a  else:: _nop,a fi enddef;
def rot_angle primary n = (_rot_ang,n) enddef; def cyc_atom  primary n = (_cyc,n) enddef;
def jump_atom_abs primary a =
  if numeric a:: (_jp_atom,$a) ef pair a:: (_jp_atom,$1),<$0,angle(a)~0`length(a),<$0 fi enddef;
def jump_atom primary a =
  if numeric  a:: (_jp_atom,a) ef pair a:: <$0,angle(a)~0`length(a),<$0 fi enddef;
def chg_length primary n = (_com,_len_s),(_chg_len,n) enddef;
def group_si secondary n = if known n:: (_group_si,n) else:: _nop fi enddef;
def group_dm secondary n = if known n:: (_group_dm,n) else:: _nop fi enddef;
def group_wf secondary n = if known n:: (_group_wf,n) else:: _nop fi enddef;
def group_zf secondary n = if known n:: (_group_zf,n) else:: _nop fi enddef;
def group_wv secondary n = /n~wv enddef;  def group_nb secondary n = /n~nb enddef;
%=================================================================================================
def read_mcf(expr n)(text t)=
  begingroup
  if unknown inside_mc::
    save /,//,/*,*/,**,*/*,~,^,`,',<,>,:,=,+,\,\\,*\,\*,*\*,@,@$,$,&,&$,#,##,{,},|,||,_,
         --,---,----,CP,CA,CC,DL,FR,inside_mc;
    inside_mc:=1; | :=mark_adress; || :=reset_adress; ##:=reset_length; _:=NO_ATOM;
    \:=0; \\:=zero_dm; *\:=zero_wf; \*:=zero_zf; *\*:=zero_wv; let ' == op_quot;
    let = ==op_equ; let : ==op_col; let ^ ==op_hat; let ~ ==op_til; let > ==op_lth;
    let ` ==op_bqu; let -- == bond__bond; let --- == bond___bond; let ---- == bond____bond;
    let } == ); let @$ ==jump_atom_abs; let < ==rot_angle; let @ ==jump_atom; let & ==cyc_atom;
    let # ==chg_length; let / ==group_si; let // ==group_dm; let */ ==group_wf; let /* ==group_zf;
    let */* ==group_wv; let ** ==group_nb; let CP == pcode_add; let CA == pcode_add_adr;
    let FR == fuse_ring_bonds; def DL(expr p)==CA(_set_line,dl,p) enddef;
    def CB(expr p)==CP(_mk_bond,p) enddef; def CC(expr p)==CP(_com,p) enddef;
    def $ ==abs_adress enddef; def &$ ==&.$ enddef; def { ==read_adress( enddef;
  fi
  %----------------------------------------------------------------------------------------------
  pcode_cnt[n]:=0;
  for list==t::
    if known list::
      if pair list::
        pcode_com[n][Incr pcode_cnt[n]]:=xpart(list); pcode_par[n][pcode_cnt[n]]:=ypart(list);
      ef numeric list::
        if list==_nop:: message "unknown command in "AND decimal(n);
        ef list>=pcode_emb_start:: expand_pcode(n,list);
        else:: pcode_com[n][Incr pcode_cnt[n]]:=_mk_bond; pcode_par[n][pcode_cnt[n]]:=list;
        fi
      fi
    else:: message "unknown command in "AND decimal(n);
    fi
  endfor
  endgroup
enddef;
%-------------------------------------------------------------------------------------------------
def expand_pcode(expr n,a)=
  if n==0::
    for i==1 upto pcode_cnt[a]::
      if pcode_com[a][i]>=pcode_emb_start:: expand_pcode(n,pcode_com[a][i]);
      else::
        pcode_com[n][Incr pcode_cnt[n]]:=pcode_com[a][i];
        pcode_par[n][pcode_cnt[n]]:=pcode_par[a][i];
      fi
    endfor
  else:: pcode_com[n][Incr pcode_cnt[n]]:=a;
  fi
enddef;
%-------------------------------------------------------------------------------------------------
vardef read_adress(text t)=
  save :,';
  let : == from_until; def ' == +-2000 enddef;
  pcode_int:=pcode_int+-1;
  nA:=0;
  for list==t::
    if known list::
      if numeric list::
        if list==_nop:: message "unknown command in "AND decimal(pcode_int);
        else:: pcode_com[pcode_int][Incr nA]:=_numeric; pcode_par[pcode_int][nA]:=list;
        fi
      ef pair list::
        if xpart(list)==_from:: nB:=ypart(list);
        ef xpart(list)==_until::
           for i==nB upto ypart(list)::
             pcode_com[pcode_int][Incr nA]:=_numeric; pcode_par[pcode_int][nA]:=i; endfor
        else:: pcode_com[pcode_int][Incr nA]:=xpart(list); pcode_par[pcode_int][nA]:=ypart(list);
        fi
      fi
    else:: message "unknown command in "AND decimal(pcode_int);
    fi
  endfor
  pcode_cnt[pcode_int]:=nA; pcode_int
enddef;
%-------------------------------------------------------------------------------------------------
vardef add_parts(expr a,b)=
  if (a LT pcode_emb_start)and(b LT pcode_emb_start)::
    pcode_com[Incr pcode_int][1]:=_numeric; pcode_par[pcode_int][1]:=a;
    pcode_com[pcode_int][2]:=_numeric; pcode_par[pcode_int][2]:=b; pcode_cnt[pcode_int]:=2;
  elseif (a>=pcode_int_start)and(b LT pcode_int_start)::
    if b>=pcode_emb_start:: pcode_com[a][Incr pcode_cnt[a]]:=b;
    else:: pcode_com[a][Incr pcode_cnt[a]]:=_numeric; pcode_par[a][pcode_cnt[a]]:=b;
    fi
  else:: pcode_com[Incr pcode_int][1]:=a; pcode_com[pcode_int][2]:=b; pcode_cnt[pcode_int]:=2;
  fi
  pcode_int
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def fuse_ring(expr a,b) =
  CP(_jp_bond,a) CP(_rot_ang,180) CP(_get_len,a) CC(_len_s) CP(_chg_len,_ring_len)
  for i==1 upto b-2:: CB(360 DIV b) endfor
  CC(_len_e) if a<=0:: CP(_cyc_eB,a-b+-2) else:: CP(_cyc_eB,a) fi
enddef;
%-------------------------------------------------------------------------------------------------
def fuse_ring_bonds(expr s,e,b,c) =
  CP(_jp_bond,s) CP(_rot_ang,180) CC(_len_s)
  if b==6:: CP(_chg_len,1) for i==1 upto c-1:: CB(60) endfor
  ef b==5:: if c==2:: CP(_chg_len,1.25) CB(80) ef c==3:: CP(_chg_len,1.1) CB(78) CB(72) fi
  ef b==4:: CP(_chg_len,1.225) CB(105)
  fi
  CC(_len_e) if e<=0:: CP(_cyc_eB,e-c+-1) else:: CP(_cyc_eB,e) fi
enddef;
%-------------------------------------------------------------------------------------------------
def fuse_ring_size(expr a,b,c) =
  CP(_jp_bond,a) CP(_rot_ang,180) CC(_len_s) CP(_chg_len,c DIV 10)
  if b==5:: CB(72-((c-9) MUL 1.5)) CB(72+-(c-9)) CB(72+-(c-9))
  ef b==6:: CB(60-(c-8)) for i==1 upto 3:: CB(60+-((c-8) DIV 2)) endfor
  ef b==7:: CB(360 DIV 7-(c-8)) for i==1 upto 4:: CB(360 DIV 7+-((c-8) DIV 2.5)) endfor
  ef b==8:: CB(45-(c-8))  for i==1 upto 5:: CB(45+-((c-8) DIV 3)) endfor
  fi
  CC(_len_e) if a<=0:: CP(_cyc_eB,a-b+-2) else:: CP(_cyc_eB,a) fi
enddef;
%=================================================================================================
vardef change_bond(expr a,b) =
  if known b:: pcode_int:=pcode_int+-1; nC:=0;
    if numeric b::
      if (b>=si)and(b<=bd_)::
        if a>=pcode_int_start::
          for i==1 upto pcode_cnt[a]::
            if pcode_com[a][i]==_numeric::
              if pcode_par[a][i]<=1800:: CA(_set_line,b,pcode_par[a][i])
              ef b==dl:: CA(_set_line,dr,pcode_par[a][i]-2000)
              ef b==dr:: CA(_set_line,dl,pcode_par[a][i]-2000)
              else:: CA(_set_line,b,pcode_par[a][i]-2000)
              fi
            fi
          endfor
        else:: CP(_set_adr,a) CP(_set_line,b)
        fi
      elseif (b>=?3)and(b<=?8[15])::
        if numeric a::
          if a>=pcode_int_start::
            for i==1 upto pcode_cnt[a]::
              if pcode_com[a][i]==_numeric::
                if b==Ph1:: fuse_ring(pcode_par[a][i],6) DL(-2) DL(-4)
                ef b==Ph2:: fuse_ring(pcode_par[a][i],6) DL(-1) DL(-3) DL(-5)
                ef (b>=?5[11])and(b<=?8[15]):: fuse_ring_size(a,pcode_com[b][1],pcode_par[b][1])
                else:: fuse_ring(pcode_par[a][i],b-?3+-3) fi
              else::
                if b==?6:: 
                  if (pcode_com[a][i]<=1800)and(pcode_par[a][i]<=1800)::
                    FR(pcode_com[a][i],pcode_par[a][i],6,4)
                  ef pcode_par[a][i]<=1800:: FR(pcode_com[a][i]-2000,pcode_par[a][i],6,3)
                  else:: FR(pcode_com[a][i]-2000,pcode_par[a][i]-2000,6,2)
                  fi
                ef b==?5::
                  if (pcode_com[a][i]<=1800)and(pcode_par[a][i]<=1800)::
                    FR(pcode_com[a][i],pcode_par[a][i],5,3)
                  ef pcode_par[a][i]<=1800:: FR(pcode_com[a][i]-2000,pcode_par[a][i],5,2)
                  fi
                ef b==?4::  FR(pcode_com[a][i],pcode_par[a][i],4,2)
                ef b==Ph1:: FR(pcode_com[a][i],pcode_par[a][i],6,4) DL(-1) DL(-3)
                ef b==Ph2:: FR(pcode_com[a][i],pcode_par[a][i],6,4) DL(-2) DL(-4)
                fi
              fi
           endfor
          else::
            if b==Ph1:: fuse_ring(a,6) DL(-2) DL(-4)
            ef b==Ph2:: fuse_ring(a,6) DL(-1) DL(-3) DL(-5)
            ef (b>=?5[11])and(b<=?8[15]):: fuse_ring_size(a,pcode_com[b][1],pcode_par[b][1])
            else:: fuse_ring(a,b-?3+-3)
            fi
          fi
        ef pair a::
          if b==?6:: if (xpart a<=1800)and(ypart a<=1800):: FR(xpart a,ypart a,6,4)
                     ef ypart a<=1800:: FR((xpart a)-2000,ypart a,6,3)
                     else:: FR((xpart a)-2000,(ypart a)-2000,6,2)
                     fi
          ef b==?5:: if (xpart a<=1800)and(ypart a<=1800):: FR(xpart a,ypart a,5,3)
                     ef ypart a<=1800:: FR((xpart a)-2000,ypart a,5,2)
                     fi
          ef b==?4:: FR(xpart a,ypart a,4,2)
        fi
      fi
    fi
    elseif color b:: cntC:=cntC+-1; color_list[cntC]:=b; CA(_set_colorB,cntC,a) fi
    pcode_cnt[pcode_int]:=nC; pcode_int
  fi
enddef;
%-------------------------------------------------------------------------------------------------
vardef change_atom(expr a,b)=
  if known b:: pcode_int:=pcode_int+-1; nC:=0;
    if numeric b::
      if (b GT pcode_emb_start)and(b<=pcode_atm_end):: CA(_chg_atom,b,a)
      ef b==NH::  CA(_chg_atom,N,a) if sw_expand==0:: CP(_tmp_line,nl) fi
                  CC(_group_s) CA(_group_si,H,a) CC(_group_e)
      ef b==N?::  CA(_chg_atom,N,a) CC(_group_s) CA(_group_si,_,a) CC(_group_e)
      ef b==N?2:: CA(_chg_atom,N,a) CC(_group_s) CA(_group_si,!,a) CC(_group_e)
      ef b==?O::  CC(_group_s) CA(_group_dm,O,a) CC(_group_e)
      ef b==?NH:: CC(_group_s) CA(_group_dm,NH,a) CC(_group_e)
      ef b==??::  CP(_tmp_rot, 35) CC(_group_s) CA(_group_si,_,a) CC(_group_e)
                  CP(_tmp_rot,-35) CC(_group_s) CA(_group_si,_,a) CC(_group_e)
      ef b==n_::  CC(_group_s) CP(_set_add,MIS) CP(_chg_add,a) CC(_group_e)
      ef b==p_::  CC(_group_s) CP(_set_add,PLS) CP(_chg_add,a) CC(_group_e)
      fi
    ef pair b::
      CC(_group_s)
      if a>=pcode_emb_start::
        for i==1 upto pcode_cnt[a]::
          if pcode_com[a][i]==_numeric::
            if pcode_par[a][i]<=1800:: CA(xpart(b),ypart(b),pcode_par[a][i])
            ef xpart(b)==_group_wf:: CA(_group_zf,ypart(b),pcode_par[a][i]-2000)
            ef xpart(b)==_group_zf:: CA(_group_wf,ypart(b),pcode_par[a][i]-2000)
            else:: CA(xpart(b),ypart(b),pcode_par[a][i])
            fi
          else:: CP(pcode_com[a][i],pcode_par[a][i])
          fi
        endfor
      else:: CA(xpart(b),ypart(b),a) fi
      CC(_group_e)
    ef color b:: cntC:=cntC+-1; color_list[cntC]:=b; CA(_set_colorA,cntC,a)
    fi
    pcode_cnt[pcode_int]:=nC; pcode_int
  fi
enddef;
%-------------------------------------------------------------------------------------------------
def pcode_add(expr c,p)=
  nC:=nC+-1; pcode_com[pcode_int][nC]:=c; pcode_par[pcode_int][nC]:=p; enddef;
def pcode_add_adr(expr c,p,a)=
  if a>=pcode_emb_start::
    for i==1 upto pcode_cnt[a]::
      if pcode_com[a][i]==_numeric:: pcode_add(_set_adr,pcode_par[a][i]) pcode_add(c,p) 
      else:: pcode_add(pcode_com[a][i],pcode_par[a][i])
      fi
    endfor
  else:: pcode_add(_set_adr,a) pcode_add(c,p)
  fi
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def ext_setup=
  pickup pencircle scaled ext_defaultline;
  dotlabeldiam:=3; labeloffset:=3; em:=defaultscale*defaultsize; defaultfont:=mpfont;
  let # = scaled; let << = rotated; let => = shifted; __ = (1,0); An:=cntA; Bn:=cntB;
  primarydef a /* b = point b of a enddef;
enddef;
%-------------------------------------------------------------------------------------------------
def add_to_molecule(text t)=
  begingroup
  save w,h,n,l,p,am,aw,A,B,An,Bn,plus,minus,lonepair,__,#,=>,<<,/*;
  numeric A[]dir,B[]up,A[]ang,B[]ang;
  pair __,p[],A[],B[]s,B[]e,B[]m,A[]up,A[]left,A[]right,A[]down,B[]up,B[]left,B[]right,B[]down;
  path B[];
  def plus = circled_plus_add enddef; def minus = circled_minus_add enddef;
  def lonepair = lone_pair_add enddef;
  ext_setup;
  w:=mol_wd; h:=mol_ht; l:=blen; aw:=atom_wd; p0:=(minX,minY);
  lonepairdiam:=0.3aw; lonepairspace:=.7aw; circlediam:=.6aw; circlepen:=.2;
  for i=1 upto cntA:
    A[i]:=posA[i]; A[i]ang:=angX[i]; A[i]up:=dir(angX[i]);
    A[i]left:=dir(angX[i]+90); A[i]right:=dir(angX[i]-90); A[i]down:=dir(angX[i]+180);
  endfor
  for i=1 upto cntB:
    B[i]s:=posA[sB[i]]; B[i]e:=posA[eB[i]]; B[i]m:=0.5[B[i]s,B[i]e]; B[i]:=B[i]s--B[i]e;
    B[i]ang:=angB[i]; B[i]up:=dir(angB[i]);
    B[i]down:=dir(angB[i]+180); B[i]left:=dir(angB[i]+90); B[i]right:=dir(angB[i]-90);
  endfor
  t addto mol_pic[cntM] also currentpicture; clearit;
  endgroup;
enddef;
%-------------------------------------------------------------------------------------------------
def ext_to_fig(text t)=
  begingroup
  save w,h,An,Bn,wd,ht,n,p,am,aw,__,#,<<,=>,/*;
  pair __,p[];
  ext_setup;
  w:=xpart(fsize); h:=ypart(fsize);
  w0:=w-2xpart(fmargin); h0:=h-2ypart(fmargin); p0:=fmargin; aw:=atom_wd; n:=cntM;
  for i=1 upto n: p[i]:=posM[1][i]; w[i]:=wdM[i]; h[i]:=htM[i]; endfor
  t addto mol_pic[0] also currentpicture; clearit; f_ext:=1;
  endgroup;
enddef;
%-------------------------------------------------------------------------------------------------
vardef circled_plus_add= nA:=circlediam; nB:=circlepen;
  image(draw fullcircle scaled nA wpcs nB;
        draw (-.5nA,0)--(.5nA,0) wpcs nB; draw (0,-.5nA)--(0,.5nA) wpcs nB;)
enddef;
%-------------------------------------------------------------------------------------------------
vardef circled_minus_add= nA:=circlediam; nB:=circlepen;
  image(draw fullcircle scaled nA wpcs nB; draw (-.5nA,0)--(.5nA,0) wpcs nB;)
enddef;
%-------------------------------------------------------------------------------------------------
vardef lone_pair_add expr n=
  image(draw (0,0) wpcs lonepairdiam; draw ((0,lonepairspace) rotated n) wpcs lonepairdiam;)
enddef;
%=================================================================================================
def drawm(text t)=
  begingroup
  save f_bra,temp_strA,temp_lenE,temp_lenF,temp_cntB,f_term,f_at,f_lineT,f_rotT,angL,lenL,cpos,
       tpos,f_lenT,f_envT,factor,m_wd,m_ht,raise_pos,slen,sdir,char_wd,char_ht,tcol,f_col,knownA,
       group_num,markA,markB,saveA,saveB,bondL,lenT,lineT,angT,rotT,envT,envB,rate_cr,posBs,posBe,
       group_par,group_cnt,group_com,colorA,colorB,aW,aH,fW,fH,hW,hW,hH,qH,fP,hP,ww,aw,ap,am,
       Ls,Le,pA,zA,zL;
  numeric group_com[][],group_par[][],group_cnt[],colorA[],colorB[];
  pair cpos,tpos,raise_pos,posBs,posBe,pA,Ls,Le;
  path frameA[],zA,zL;
  %-----------------------------------------------------------------------------------------------
  if sw_expand=1: rate_cr:=1; else: rate_cr:=-ratio_chain_ring; fi
  cntA:=cntB:=cntC:=group_num:=0; str_tbl[0]:="C"; str_cnt:=2000;
  %-----------------------------------------------------------------------------------------------
  fig_wd:=xpart(fsize); fig_ht:=ypart(fsize);
  %===============================================================================================
  read_mcf(0)(t,(_com,_term));
  proc_bond_atom(0)(1);
  if (group_num>0)and(not scan_bit(sw_abbreviate,Group)): expand_group(1); fi
  %-scaling---------------------------------------------------------------------------------------
  if     blength>1: blen:=blength;        proc_size_setup; proc_skeleton(0); proc_scaling;
  elseif blength>0: blen:=fig_wd*blength; proc_size_setup; proc_skeleton(0); proc_scaling;
  else:
    blen:=3mm;
    proc_size_setup;
    if xpart(msize)<1: m_wd:=fig_wd*xpart(msize); else: m_wd:=fig_wd; fi
    if ypart(msize)<1: m_ht:=fig_ht*ypart(msize); else: m_ht:=fig_ht; fi
    for i=1 upto 6:
      proc_skeleton(0); proc_scaling;
      if (mol_ht/mol_wd)>(m_ht/m_wd):
        if ypart(msize)>1: factor:=ypart(msize)/mol_ht;
        else: factor:=((fig_ht-2ypart(fmargin))*ypart(msize))/mol_ht; fi
      else:
        if xpart(msize)>1: factor:=xpart(msize)/mol_wd;
        else: factor:=((fig_wd-2xpart(fmargin))*xpart(msize))/mol_wd; fi fi
      exitif (factor>=1-eps)and(factor<=1+eps); blen:=blen*factor; proc_size_setup;
    endfor
    if blen>max_blength: blen:=max_blength; proc_size_setup; proc_skeleton(0); proc_scaling; fi
  fi
  %-----------------------------------------------------------------------------------------------
  for i=1 upto cntA:
    if addA[i]<>0:
      tempc:=char(addA[i]);
      if tempc="+": chargeA[i]:=1; ef tempc="-": chargeA[i]:=-1; else: chargeA[i]:=0; fi
    else: chargeA[i]:=0;
    fi
  endfor
  %===============================================================================================
  if scan_bit(sw_output,Fig):
    %-draw atom-----------------------------------------------------------------------------------
    if sw_numbering=0: for i=1 upto cntA: if strA[i]<>0: draw_atom(i); fi endfor fi
    %-draw add to atom----------------------------------------------------------------------------
    if (not scan_bit(sw_numbering,Atom))and(not scan_bit(sw_numbering,Bond)):
      for i=1 upto cntA:
        if addA[i]<>0: draw_char(char(addA[i]),sfrt(posA[i],atom_wd,angX[i]+add_rot[i])); fi
      endfor
    fi
    %-draw bond-----------------------------------------------------------------------------------
    for i=1 upto cntB: if lineB[i]<si_ : draw_bond(i); fi endfor
    for i=1 upto cntB: if lineB[i]>=si_: draw_bond(i); fi endfor
    %-atom numbering------------------------------------------------------------------------------
    if scan_bit(sw_numbering,Atom):
      for i=1 upto cntA:
        if (i>=numbering_start)and(i<=numbering_end):
          defaultscale:=.18blen/defaultsize; nH:=1.2defaultsize*defaultscale;
          if i<=9: nW:=nH; ef i<=99: nW:=1.3nH; else: nW:=1.9nH; fi
          erase fill unitsquare xscaled nW yscaled nH shifted (posA[i]-(nW/2,nH/2));
          draw unitsquare xscaled nW yscaled nH shifted (posA[i]-(nW/2,nH/2)) wpcs 0.1;
          label(decimal(i),posA[i]);
        fi
      endfor
    fi
    %-bond numbering------------------------------------------------------------------------------
    if scan_bit(sw_numbering,Bond):
      for i=1 upto cntB:
        if (i>=numbering_start)and(i<=numbering_end):
          defaultscale:=.18blen/defaultsize; nH:=1.2defaultsize*defaultscale;
          if i<=9: nW:=nH; ef i<=99: nW:=1.3nH; else: nW:=1.9nH; fi
          nH:=defaultsize*defaultscale; tpos:=.5[posA[sB[i]],posA[eB[i]]];
          erase fill unitsquare xscaled nW yscaled nH shifted (tpos-(nW/2,nH/2));
          draw unitsquare xscaled nW yscaled nH shifted (tpos-(nW/2,nH/2)) wpcs 0.1;
          label(decimal(i),tpos);
       fi
      endfor
    fi
    %---------------------------------------------------------------------------------------------
    if xpart(mposition)>1: nX:=xpart(mposition)-minX;
    else: nX:=xpart(fmargin)-minX+(fig_wd-mol_wd-2xpart(fmargin))*xpart(mposition); fi
    if ypart(mposition)>1: nY:=ypart(mposition)-minY;
    else: nY:=ypart(fmargin)-minY+(fig_ht-mol_ht-2ypart(fmargin))*ypart(mposition); fi
    posM[0][incr cntM]:=(nX,nY); posM1[cntM]:=(minX+nX,minY+nY); posM2[cntM]:=(maxX+nX,maxY+nY);
    wdM[cntM]:=mol_wd; htM[cntM]:=mol_ht;
    mol_pic[cntM]:=currentpicture;
    clearit;
  fi
  if sw_output>=Calc: proc_calc(0); fi
  endgroup;
enddef;
%-------------------------------------------------------------------------------------------------
def expand_group(expr n)=
  save_group_num:=group_num; save_pcode_cnt:=pcode_cnt[0];
  for i=n upto group_num:
    for j=1 upto group_cnt[i]:
      if group_com[i][j]>=pcode_emb_start: expand_pcode(0,group_com[i][j]);
      else: pcode_com[0][incr pcode_cnt[0]]:=group_com[i][j];
            pcode_par[0][pcode_cnt[0]]:=group_par[i][j];
      fi
    endfor
  endfor
  proc_bond_atom(0)(save_pcode_cnt+1);
  if group_num>save_group_num: expand_group(save_group_num+1); fi
enddef;
%=================================================================================================
def draw_frame(expr o,p,n)=
  draw ((0,0)--(xpart p,0)--p--(0,ypart p)--cycle) shifted o withpen pensquare scaled n; enddef;
%-------------------------------------------------------------------------------------------------
def draw_corner(expr p,n)=
  draw (0,0) wpcs n; draw(xpart p,0) wpcs n; draw p wpcs n; draw(0,ypart p) wpcs n; enddef;
%-------------------------------------------------------------------------------------------------
def proc_size_setup=
  atom_wd:=     blen*ratio_atom_bond+offset_atom;
  wedge_wd:=    blen*ratio_wedge_bond+offset_wedge;
  hash_gap:=    blen*ratio_hashgap_bond+offset_hash_gap;
  bondgap:=     blen*ratio_bondgap_bond+offset_bond_gap;
  bond_pen_wd:= blen*ratio_thickness_bond+offset_thickness;
enddef;
%-------------------------------------------------------------------------------------------------
def proc_scaling=
  minX:=minY:=4095; maxX:=maxY:=-4095;
  for i=1 upto cntA:
    nX:=xpart(posA[i]); nY:=ypart(posA[i]);
    if strA[i]<>0:
      nU:=nD:=nP:=nL:=nR:=0;
      for j=1 upto length(str_tbl[strA[i]]):
        tempc:=subc(j,str_tbl[strA[i]]);
        if tempc="^": nU:=.5atom_wd; ef tempc="_": nD:=.5atom_wd;
        ef (tempc<>"{")and(tempc<>"}"): nP:=nP+atom_wd*tbl_char_wd[ASCII(tempc)];
        fi
      endfor
      if (angX[i]<=90)or(angX[i]>=270): nR:=nP; else: nL:=nP; fi
      if (nX-nL+.5atom_wd)<minX: minX:=nX-nL+.5atom_wd; fi
      if (nX+nR-.5atom_wd)>maxX: maxX:=nX+nR-.5atom_wd; fi
      if (nY-nD-.5atom_wd)<minY: minY:=nY-nD-.5atom_wd; fi
      if (nY+nU+.5atom_wd)>maxY: maxY:=nY+nU+.5atom_wd; fi
    else: if nX<minX: minX:=nX; fi if nX>maxX: maxX:=nX; fi
          if nY<minY: minY:=nY; fi if nY>maxY: maxY:=nY; fi
    fi
  endfor
  mol_wd:=maxX-minX; mol_ht:=maxY-minY;
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def proc_bond_atom(expr a)(expr n)=
  f_bra:=f_term:=rotT:=f_lineT:=f_rotT:=f_lenT:=f_envT:=envT:=envB:=temp_strA:=f_at:=0;
  bondL:=rate_cr; lenT:=rate_cr; sB[0]:=0; eB[0]:=1; lineT:=si;
  addAT:=markA:=markB:=saveA:=saveB:=0;
  %-----------------------------------------------------------------------------------------------
  for i=n upto pcode_cnt[a]: nC:=pcode_com[a][i]; nP:=pcode_par[a][i];
    if nC=_mk_bond: if (nP=0)and(rotT<>0): rotT:=0; fi add_atom(0);
    ef nC=_set_adr: adrT:=nP;
    ef nC=_com: if nP=_mark: saveA:=markA; saveB:=markB; markA:=cntA; markB:=cntB;
                ef nP=_rest: markA:=saveA; markB:=saveB;
                ef nP=_moff: markA:=markB:=0;
                ef nP=_term: termA;
                ef nP=_len_s:  temp_lenE:=bondL; ef nP=_len_e:  bondL:=temp_lenE;
                ef nP=_len_ss: temp_lenF:=bondL; ef nP=_len_ee: bondL:=temp_lenF;
                ef nP=_group_s: f_at:=1; if lineT<>si: f_lineT:=1; fi if rotT<>0: f_rotT:=1; fi
                                if lenT<>rate_cr: f_lenT:=1;  fi if envT<>hz: f_envT:=1; fi
                ef nP=_group_e: f_at:=0; f_lineT:=f_rotT:=f_lenT:=f_envT:=rotT:=envT:=0;
                                lineT:=si; lenT:=rate_cr; fi
    ef nC=_set_atom: temp_strA:=nP;
    ef nC=_group_si: add_group;
    ef nC=_group_dm: lineT:=dm; add_group;
    ef nC=_group_wf: lineT:=wf; add_group;
    ef nC=_group_zf: lineT:=zf; add_group;
    ef nC=_jp_bond:  termA; nA:=getB(nP); check_adrB(nA); sB[cntB+1]:=sB[nA]; f_bra:=1;
    ef nC=_jp_atom:  termA; nA:=getA(nP); check_adrA(nA); sB[cntB+1]:=nA; f_bra:=1;
    ef nC=_jp_absA:  sB[cntB+1]:=nP; f_bra:=1; temp_cntB:=cntB;
    ef nC=_chg_atom: strA[getA(adrT)]:=pcode_par[nP][1];
    ef nC=_chg_len:  if nP=_ring_len: bondL:=ringL; else: bondL:=nP; fi
    ef nC=_get_len:  if nP=_tmp_len: if bondL=rate_cr: bondL:=lenT; fi
                     ef nP=_ring_len:
                       if lenT<>rate_cr: bondL:=lenT; else: if bondL<0: bondL:=1; fi fi
                     else: ringL:=lenB[getB(nP)]; fi
    ef nC=_tmp_len:  lenT:=nP;
    ef nC=_set_line: lineB[getB(adrT)]:=nP;
    ef nC=_tmp_line: lineT:=nP;
    ef nC=_tmp_rot:  rotT:=nP;
    ef nC=_cyc:      check_adrA(getA(nP)); add_atom(getA(nP));
    ef nC=_cyc_eB:   add_atom(eB[getB(nP)]);
    ef nC=_cyc_sB:   add_atom(sB[getB(nP)]);
    ef nC=_chg_env:  envB:=nP;
    ef nC=_tmp_env:  envT:=nP;
    ef nC=_set_colorA: colorA[getA(adrT)]:=nP;
    ef nC=_set_colorB: colorB[getB(adrT)]:=nP;
    ef nC=_set_add: addAT:=nP;
    ef nC=_chg_add: addA[getA(nP)]:=addAT; addAT:=0; if rotT<>0: add_rot[getA(nP)]:=rotT; fi
    else:
    fi
  endfor
enddef;
%-------------------------------------------------------------------------------------------------
def add_group=
  if f_at=1: nE:=getA(adrT); check_adrA(nE); else: nE:=cntA+1; fi
  group_cnt[incr group_num]:=0; store_group(_jp_absA,nE)
  store_group(_com,_mark)
  store_group(_com,_len_s)
  if lineT<>nb: store_group(_tmp_line,lineT) fi
  if rotT<>0:   store_group(_rot_ang,rotT) fi
  if lenT<>rate_cr: store_group(_chg_len,lenT)
  ef bondL<>rate_cr: 
    if bondL>=0: store_group(_chg_len,-bondL) else: store_group(_chg_len,bondL) fi fi
  if envT<>hz:  store_group(_chg_env,envT) fi
  if lineT=nl:  store_group(_chg_len,_size_atom) store_group(_adj_ang,0) fi
  if lineT<>nb: store_group(_mk_bond,0) fi
  if nP<>NO_ATOM:
    for i=1 upto pcode_cnt[nP]: store_group(pcode_com[nP][i],pcode_par[nP][i]) endfor 
  fi
  store_group(_com,_len_e) store_group(_chg_env,hz) store_group(_com,_term)
  store_group(_com,_rest)
  if f_lineT=0: lineT:=si; fi
  if f_lenT=0:  lenT:=rate_cr; fi 
  if f_rotT=0:  rotT:=0;   fi
  if f_envT=0:  envT:=hz;  fi
enddef;
%-------------------------------------------------------------------------------------------------
def store_group(expr a,b)=
  group_com[group_num][incr group_cnt[group_num]]:=a; 
  group_par[group_num][group_cnt[group_num]]:=b;
enddef;
%-------------------------------------------------------------------------------------------------
def add_atom(expr n)=
  lineB[incr cntB]:=lineT; lineT:=si;
  if lenT=rate_cr: lenB[cntB]:=bondL; else: lenB[cntB]:=lenT; lenT:=rate_cr; fi
  if f_bra=0: strA[incr cntA]:=temp_strA; sB[cntB]:=cntA;
              addA[cntA]:=addAT; addAT:=temp_strA:=add_rot[cntA]:=0;
              if rotT<>0: add_rot[cntA]:=rotT; rotT:=0; fi
  else: f_bra:=0; fi
  if n=0: eB[cntB]:=cntA+1; f_term:=0; else: eB[cntB]:=n; f_term:=1; fi
enddef;
%-------------------------------------------------------------------------------------------------
def check_adrA(expr n)=
  if (n>iif(f_term=0,cntA+1,cntA))or(n<=0): errmessage("cntA=[ "&decimal(n)&" ]"); fi enddef;
def check_adrB(expr n)= if (n>cntB)or(n<=0): errmessage("cntB=[ "&decimal(n)&" ]"); fi enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def proc_skeleton(expr n)=
  markA:=markB:=cntA:=cntB:=f_bra:=rotT:=f_term:=0;
  envT:=envB:=f_lineT:=f_rotT:=f_lenT:=f_envT:=0; lineT:=si; angT:=mangle;
  angA[0]:=angB[0]:=angX[0]:=0; posA[0]:=posBs:=posBe:=(0,0);
  %-----------------------------------------------------------------------------------------------
  for i=1 upto pcode_cnt[n]: nC:=pcode_com[n][i]; nP:=pcode_par[n][i];
    if nC=_mk_bond: if (nP=0)and(rotT<>0):nP:=rotT; rotT:=0; fi add_bond(nP,1);
    ef nC=_com: if nP=_mark: saveA:=markA; saveB:=markB; markA:=cntA; markB:=cntB;
                ef nP=_rest: markA:=saveA; markB:=saveB;
                ef nP=_moff: markA:=markB:=0; ef nP=_term: termB;
                ef nP=_group_e: lineT:=si; lenT:=rate_cr; rotT:=envT:=0; fi
    ef nC=_jp_bond: termB; nA:=getB(nP); posBs:=posA[sB[nA]]; angT:=angB[nA]; f_bra:=1; rotT:=0;
    ef nC=_jp_atom: termB; adrT:=getA(nP); posBs:=posA[adrT]; angT:=angX[adrT]; f_bra:=1; rotT:=0;
    ef nC=_jp_absA: adrT:=nP; posBs:=posA[adrT]; angT:=angX[adrT];
                    f_bra:=1; rotT:=0; temp_cntB:=cntB;
    ef nC=_adj_ang: angT:=adjust_ang(angT);
    ef nC=_rot_ang: if nP>-3700: angT:=(angT+nP) mod 360; else: angT:=(nP+4095) mod 360; fi
    ef nC=_tmp_rot: rotT:=nP;
    ef nC=_chg_env: envB:=nP;
    ef nC=_tmp_env: envT:=nP;
    ef nC=_cyc:     add_bond(angle(posA[getA(nP)]-posBs)-angT,0);
    ef nC=_cyc_sB:  add_bond(angle(posA[sB[getB(nP)]]-posBs)-angT,0);
    ef nC=_cyc_eB:  add_bond(angle(posA[eB[getB(nP)]]-posBs)-angT,0);
    else:
    fi
  endfor
enddef;
%-------------------------------------------------------------------------------------------------
def add_bond(expr n,f)=
  if n=_arrange_ang: nA:=arrange_ang(angT mod 360); else: nA:=n; fi
  if f_bra=0:
    adrT:=incr cntA; posA[cntA]:=posBs; angA[cntA]:=angT; 
    angX[cntA]:=(angT+nA/2+iif(nA>=0,-90,90)) mod 360;
  else: f_bra:=0; fi
  cntB:=cntB+1;
  if nA>-3700: angB[cntB]:=angT:=(angT+nA) mod 360; else: angB[cntB]:=angT:=nA+4095; fi
  if f=1:
    if lenB[cntB]=_size_atom: posBe:=sfrt(posBs,atom_wd,angT);
    else:
      nA:=lenB[cntB]; if nA<0: nB:=glu_atom(adrT)+glu_atom(cntA+1); nA:=abs(nA); else: nB:=0; fi
      posBe:=sfrt(posBs,nA*blen+nB,angT); fi
    posA[cntA+1]:=posBe; f_term:=0;
  else: f_term:=1; fi
  posBs:=posBe;
enddef;
%-------------------------------------------------------------------------------------------------
vardef arrange_ang(expr n)=
  if cntB=0: angT:=(angT-180) mod 360; 180
  else: if envB>=pcode_emb_start: pcode_par[envB][cntB-temp_cntB]
        else: if envB=hz: if n=0:  60 ef n<=90: -60 ef n<=180:  60 ef n<270: -60 else:  60 fi
              ef envB=vt: if n=0: -60 ef n<90:   60 ef n<=180: -60 ef n<=270: 60 else: -60 fi
              ef abs(envB)<=180: envB
              fi
        fi
  fi
enddef;
%-------------------------------------------------------------------------------------------------
vardef adjust_ang(expr n)= if (n<40)or(n>320): 0 ef n<140: 90 ef n<220: 180 else: 270 fi enddef;
%=================================================================================================
vardef getA(expr n)= if n>=0: markA+n ef n>=-999: cntA+n+1 else: n+4095 fi enddef;
vardef getB(expr n)= if n>=0: markB+n ef n>=-999: cntB+n+1 else: n+4095 fi enddef;
%-------------------------------------------------------------------------------------------------
def termA=
  if f_term=0:
    if f_bra=0: strA[incr cntA]:=temp_strA; addA[cntA]:=addAT; add_rot[cntA]:=rotT;
                addAT:=temp_strA:=rotT:=0;
    else: f_bra:=0;
    fi
    f_term:=1;
  fi
enddef;
%-------------------------------------------------------------------------------------------------
def termB= if f_term=0: if f_bra=0: angX[incr cntA]:=angT; else:f_bra:=0; fi f_term:=1; fi enddef;
%-------------------------------------------------------------------------------------------------
vardef glu_atom(expr n)=
 if strA[n]<>0: nE:=angT mod 90; nF:=0.5atom_wd; (iif(nE<45,sind nE,cosd nE)*nF)+++nF else: 0 fi
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def draw_atom(expr n)=
  if atomfont<>"draw": defaultfont:=atomfont; defaultsize:=atom_wd; fi
  temps:=str_tbl[strA[n]]; slen:=length(temps); nC:=nS:=0; raise_pos:=(0,0); tpos:=posA[n];
  if (angX[n]<=90)or(angX[n]>=270): sdir:=1; else: sdir:=-1; fi
  for i=1 upto slen:
    if nC=0: tempc:=subc(i,temps);
      if (sdir=-1)and(tempc="{"):
        nD:=i; nC:=0; for j=nD upto slen: nC:=nC+1; exitif subc(j+1,temps)="}"; endfor
      fi
      else: nC:=nC-1; tempc:=subc(nD+nC,temps); fi
    if tempc="_": raise_pos:=iif(raise_pos=(0,0),(0,-.5atom_wd),(0,0));
    ef tempc="^": raise_pos:=iif(raise_pos=(0,0),(0, .5atom_wd),(0,0));
    ef (tempc<>"{")and(tempc<>"}"):
      nS:=nS+1; char_wd:=atom_wd*tbl_char_wd[ASCII(tempc)]; char_ht:=atom_wd;
      if nS=1: if (sdir=-1)and(char_wd<atom_wd): tpos:=tpos+((atom_wd-char_wd)/2,0); fi 
      else: tpos:=tpos+(.5char_wd*sdir,0); fi
      tcol:=colorA[n]; f_col:=0;
      if known tcol: if tcol<>0: drawoptions(withcolor color_list[tcol]); f_col:=1; fi fi
      if atomfont="draw": draw_char(tempc,tpos+raise_pos); else: label(tempc,tpos+raise_pos); fi
      if f_col=1: drawoptions(); fi
      tpos:=tpos+(.5char_wd*sdir,0);
    fi
  endfor
  nA:=0.56atom_wd; nB:=0.06atom_wd;
  if sdir=1: frameA[n]:=posA[n]-(nA,nA)--tpos+(nB,-nA)--tpos+(nB,nA)--posA[n]+(-nA,nA)--cycle;
  else:      frameA[n]:=tpos-(nB,nA)--posA[n]+(nA,-nA)--posA[n]+(nA,nA)--tpos+(-nB,nA)--cycle;
  fi
  if scan_bit(sw_frame,Atom): draw frameA[n] wpcs thickness_frame; fi
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def draw_bond(expr n)=
  nL:=lineB[n]; angL:=angB[n]; nS:=sB[n]; nE:=eB[n]; f_col:=0;
  tcol:=colorB[n]; zL:=posA[nS]--posA[nE]; ww:=wedge_wd; ap:=angL+90; am:=angL-90; aw:=atom_wd;
  %-----------------------------------------------------------------------------------------------
  if (strA[nS]=0)and(strA[nE]=0)or(sw_numbering>=1):
                 Ls:=posA[nS];          Le:=posA[nE];          pA:=(.1,.9);
  ef strA[nS]=0: Ls:=posA[nS];          Le:=zL ISP frameA[nE]; pA:=(.15,1);
  ef strA[nE]=0: Ls:=zL ISP frameA[nS]; Le:=posA[nE];          pA:=(0,.85);
  else:          Ls:=zL ISP frameA[nS]; Le:=zL ISP frameA[nE]; pA:=(0,1); fi
  zA:=Ls--Le; lenL:=length(Le-Ls);
  %-----------------------------------------------------------------------------------------------
  if known tcol: if tcol<>0: drawoptions(withcolor color_list[tcol]); f_col:=1;fi fi
  pickup pencircle scaled bond_pen_wd;
  if (nL=si)or(scan_bit(sw_abbreviate,Bond)): draw zA;
  ef nL=dl: draw zA; draw sfrt(subpath pA of zA,bondgap,ap);
  ef nL=dr: draw zA; draw sfrt(subpath pA of zA,bondgap,am);
  ef nL=dm: draw sfrt(zA,bondgap/1.75,ap); draw sfrt(zA,bondgap/1.75,am);
  ef nL=db: nA:=iif(((angL-angX[nS]) mod 360)<=180,ap,am);
            draw zA; draw sfrt(subpath pA of zA,bondgap,nA);
  ef nL=tm: draw zA; draw sfrt(zA,bondgap,ap); draw sfrt(zA,bondgap,am);
  ef nL=wf: fill Ls--sfrt(Le,ww,am)--sfrt(Le,ww,ap)--cycle;
  ef nL=wb: fill sfrt(Ls,ww,am)--Le--sfrt(Ls,ww,ap)--cycle;
  ef nL=bd: draw zA withpen penrazor rotated ap scaled bondgap;
  ef nL=bz: bz_put(sfrt(Ls,ww,ap),sfrt(Le,ww,ap),sfrt(Ls,ww,am),sfrt(Le,ww,am));
  ef nL=zf: wz_put(Ls,sfrt(Le,ww,ap),sfrt(Le,ww,am));
  ef nL=zb: wz_put(Le,sfrt(Ls,ww,am),sfrt(Ls,ww,ap));
  ef nL=dt: for i=0 step .75hash_gap/lenL until 1: drawdot i[Ls,Le]; endfor
  ef nL=wv: nA:=.4bondgap; nB:=round(lenL/nA);
            draw Ls for i=1 upto nB: ..controls(point (i-.5)/nB of sfrt(zA,nA,iif(odd i,ap,am)))
                                     ..point i/nB of zA endfor
  ef nL=wf_r: filldraw Ls--sfrt(Le,.35ww,am)--sfrt(Le,.35ww,ap)--cycle wpcs .05ww;
  ef nL=wb_r: filldraw sfrt(Ls,.35ww,am)--Le--sfrt(Ls,.35ww,ap)--cycle wpcs .05ww;
  ef nL=bd_r: draw zA wpcs .65bondgap;
  ef nL=vf:  draw zA;draw sfrt(Le,bondgap,angL-150)--Le--sfrt(Le,bondgap,angL+150);
  ef nL=vb:  draw zA;draw sfrt(Ls,bondgap,angL-30)--Ls--sfrt(Ls,bondgap,angL+30);
  ef nL=si_: erase draw subpath (.15,.85) of zA wpcs 0.8bondgap; draw zA;
  ef nL=dl_: erase draw subpath (.15,.85) of sfrt(subpath pA of zA,.5bondgap,ap) wpcs 1.8bondgap;
             draw zA; draw sfrt(subpath pA of zA,bondgap,ap);
  ef nL=dr_: erase draw subpath (.15,.85) of sfrt(subpath pA of zA,.5bondgap,am) wpcs 1.8bondgap;
             draw zA; draw sfrt(subpath pA of zA,bondgap,am);
  ef nL=dm_: erase draw subpath(0.15,0.85) of zA wpcs 1.8 bondgap;
             draw sfrt(zA,bondgap/1.75,ap); draw sfrt(zA,bondgap/1.75,am);
  ef nL=wf_: erase draw subpath (0.15,0.85) of (Ls--sfrt(Le,ww,am)) wpcs 0.8bondgap;
             erase draw subpath (0.15,0.85) of (Ls--sfrt(Le,ww,ap)) wpcs 0.8bondgap;
             fill Ls--sfrt(Le,ww,am)--sfrt(Le,ww,ap)--cycle;
  ef nL=wb_: erase draw subpath (0.15,0.85) of (sfrt(Ls,ww,am)--Le) wpcs 0.8bondgap;
             erase draw subpath (0.15,0.85) of (sfrt(Ls,ww,ap)--Le) wpcs 0.8bondgap;
             fill sfrt(Ls,ww,am)--Le--sfrt(Ls,ww,ap)--cycle;
  ef nL=zf_: erase draw subpath (0.15,0.85) of (Ls--sfrt(Le,ww,am)) wpcs 0.8bondgap;
             erase draw subpath (0.15,0.85) of zA wpcs 0.8bondgap;
             erase draw subpath (0.15,0.85) of (Ls--sfrt(Le,ww,ap)) wpcs 0.8bondgap;
             wz_put(Ls,sfrt(Le,ww,ap),sfrt(Le,ww,am));
  ef nL=zb_: erase draw subpath (0.15,0.85) of (sfrt(Ls,ww,am)--Le) wpcs 0.8bondgap;
             erase draw subpath (0.15,0.85) of zA wpcs 0.8bondgap;
             erase draw subpath (0.15,0.85) of (sfrt(Ls,ww,ap)--Le) wpcs 0.8bondgap;
             wz_put(Le,sfrt(Ls,ww,am),sfrt(Ls,ww,ap));
  ef nL=bd_: erase draw subpath(0.15,0.85) of zA wpcs 1.6bondgap;
             draw zA withpen penrazor rotated ap scaled bondgap;
  ef nL=nb:
  %-- bond type for glycan ----------------------------------------------------------------------
  ef nL=arc_lb:  draw Ls--Ls-(0,aw)..posA[nE]+(-1.2aw,0)..posA[nE]-(.6aw,0);
  ef nL=arc_br:  draw posA[nS]+(.6aw,0)..posA[nS]+(1.2aw,0)..Le-(0,aw)--Le;
  ef nL=arc_lbr: draw posA[nS]+(0,iif(strA[nS]=0,0,-.6aw))--posA[nS]+(0,-.8aw)
                      ..0.5[posA[nS],posA[nE]]+(0,-1.7aw)..posA[nE]+(0,-.8aw)
                      --posA[nE]+(0,iif(strA[nE]=0,0,-.6aw));
  ef nL=arc_ltr: draw posA[nS]+(0,iif(strA[nS]=0,0,0.6aw))--posA[nS]+(0,.8aw)
                      ..0.5[posA[nS],posA[nE]]+(0,1.7aw)..posA[nE]+(0,.8aw)
                      --posA[nE]+(0,iif(strA[nE]=0,0,.6aw));
  %----------------------------------------------------------------------------------------------
  fi
  if f_col=1: drawoptions(); fi
enddef;
%------------------------------------------------------------------------------------------------
def wz_put(expr a,b,c)=  nB:=round(lenL/hash_gap);
  for i=1 upto nB: nA:=i/nB; if i=1: nD:=0; else: nD:=(i-ratio_hash_black)/nB; fi
    fill nD[a,b]--nD[a,c]--nA[a,c]--nA[a,b]--cycle;
  endfor
enddef;
%------------------------------------------------------------------------------------------------
def bz_put(expr a,b,c,d)=  nB:=round(lenL/hash_gap);
  for i=0 upto nB-1: nA:=i/nB; nD:=nA+ratio_hash_black/nB;
    fill nA[b,a]--nA[d,c]--nD[d,c]--nD[b,a]--cycle;
  endfor
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def char_size_set(expr w,h)(expr s)=
  for j=1 upto length(s): nN:=ASCII(subc(j,s)); tbl_char_wd[nN]:=w; tbl_char_ht[nN]:=h; endfor
enddef;
%-------------------------------------------------------------------------------------------------
char_size_set(   1,   1)("CGHMNOQW");
char_size_set( 0.9,   1)("ABDFIJKPRSTUVXY");
char_size_set( 0.8,   1)("ELZ");
char_size_set( 0.7,   1)("0123456789nhtfg");
char_size_set( 0.7, 0.7)("-+");
char_size_set(0.45,0.95)("l");
char_size_set(0.75, 0.8)("opq");
char_size_set( 0.8, 0.8)("e");
char_size_set( 0.9, 0.8)("wm");
char_size_set( 0.7, 0.8)("abdcksuvrxyz");
char_size_set(0.35, 0.9)("i");
char_size_set( 0.5, 0.9)("j");
%-------------------------------------------------------------------------------------------------
def dw expr p = draw p shifted cpos enddef;
def dwv expr p = draw p withpen penrazor scaled fP shifted cpos enddef;
def dwvs(expr n) expr p = draw p withpen penrazor scaled (fP*n) shifted cpos enddef;
def dwh expr p = draw p withpen penrazor rotated 90 scaled fP shifted cpos enddef;
def cdw expr p = cutdraw p shifted cpos enddef;
%-------------------------------------------------------------------------------------------------
def Z_a=( 0,hP) enddef; def Z_b=(hP, 0) enddef; def Z_c=(hP,hP) enddef; def Z_d=(aW,hP) enddef;
def Z_e=(fW, 0) enddef; def Z_f=(hW,aH) enddef; def Z_g=(hW, 0) enddef; def Z_h=( 0,hH) enddef;
def Z_i=(hW,fW) enddef; def Z_j=( 0,qH) enddef; def Z_k=(aW,qH) enddef; def Z_l=(.75aW,0) enddef;
def Z_m=(hP,hH) enddef; def Z_n=(fW,fH) enddef; def Z_o=(fW,hH) enddef; def Z_p=(hW,aW) enddef;
def Z_q=( 0,fH) enddef; def Z_r=(hP,fH) enddef; def Z_s=(hW,fH) enddef; def Z_t=(fW,aH) enddef;
def Z_u=(aW,fH) enddef; def Z_v=(aW,hH) enddef; def Z_w=(hP,aH) enddef; def Z_x=(hW,hP) enddef;
def Z_y=(hW,hH) enddef; def Z_z=(fW,hP) enddef; 
%-------------------------------------------------------------------------------------------------
def circ_O = Z_o..(.8aW,fH-qP)..tension 1.5..(.2aW,fH-qP)..Z_m..
     (.2aW,1.5hP)..tension 1.5..(.8aW,1.5hP)..cycle enddef;
def circ_Oh = (hP,qH)..Z_x..(fW,qH)..Z_y..cycle enddef;
def circ_Oa = (hP,0.35aH)..Z_x..(fW,0.35aH)..(hW,.7aH)..cycle enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def draw_char(expr s,p)=
  aW:=atom_wd*tbl_char_wd[ASCII(s)]*(1-2ratio_atomgap_atom);
  aH:=atom_wd*tbl_char_ht[ASCII(s)]*(1-2ratio_atomgap_atom);
  cpos:=p-(aW/2,atom_wd/2*(1-2ratio_atomgap_atom));
  fP:=bond_pen_wd*ratio_char_bond;
  hP:=fP/2; qP:=fP/4; fW:=aW-hP; hW:=aW/2; fH:=aH-hP; hH:=aH/2; qH:=aH/4;
  %-----------------------------------------------------------------------------------------------
  pickup pencircle scaled fP;
  if s="C":  cdw sbp(.05,.95)circ_O;
  ef s="H":  dwv Z_b--Z_w; dw Z_m--Z_o; dwv Z_e--Z_t;
  ef s="O":  dw circ_O;
  ef s="N":  dwv Z_b--Z_w; dwv Z_e--Z_t; dwvs(1.4)(1.4hP,aH)--(aW-1.4hP,0);
  ef s="S":  cdw sbp(.05,.45)circ_O; cdw sbp(.55,.95)circ_O; dw (fW,.3aH){up}..{up}(hP,.7aH);
  ef s="F":  dwh Z_q--Z_u; dwh (0,.45aH)--(fW,.45aH); dw Z_b--Z_r;
  ef s="P":  dwv Z_b--Z_w; dw Z_r--(.65aW,fH){right}..(fW,.7aH)..{left}(.65aW,.44aH)..(hP,.44aH);
  ef s="I": dwv Z_x--Z_s; dwh (hW-fP,hP)--(hW+fP,hP); dwh (hW-fP,fH)--(hW+fP,fH);
  ef s="l": dwv Z_g--Z_f; dwh Z_s--Z_r; dwh Z_x--Z_z;
  ef s="2": cdw (hP,1.3hP)..(.4fW,.35fH)..(fW,.65aH)..Z_s..(hP,.65aH); dwh Z_d--Z_a;
  ef s="3": cdw sbp(0,.75)circ_Oh; cdw sbp(.25,.98)circ_Oh shifted (0,hH-hP); dwh (.3aW,hH)--Z_y;
  ef s="4": dwh Z_j--Z_k; dwv Z_l--(0.75aW,aH)--(1.2hP,qH+hP); dwv (.75aW+qP,aH)--(1.7hP,qH+hP);
  ef s="-": dwh Z_m--Z_o;
  ef s="+": dwv Z_x--Z_s; dwh Z_m--Z_o;
  ef s="A": dwvs(1.14)Z_b--Z_f--Z_e; dw .33[Z_b,Z_f]--.33[Z_e,Z_f];
  ef s="B": dw Z_r--Z_s{right}..(.9fH,.75aH)..{left}Z_y--Z_m--Z_y{right}..(.9fH,qH)..
              {left}Z_x--Z_c; dwv Z_b--Z_w;
  ef s="D": dw Z_r--Z_s..Z_o..Z_x--Z_c; dwv Z_b--Z_w;
  ef s="E": pickup pensquare scaled fP; dw Z_z--Z_c--Z_r--Z_n; dw Z_m--Z_o;
  ef s="G": cdw sbp(.06,.97)circ_O; dwh bot Z_y-- bot Z_v;
  ef s="J": cdw Z_m..(hP,.4aH){down}..{right}Z_x{right}..{up}(fW,.4aH)..Z_t;
  ef s="K": cdw Z_b--Z_w; cdw .35[.45[Z_b,Z_w],Z_u]--Z_e; cdw .35[Z_b,Z_w]--Z_u;
  ef s="L": dwh Z_d--Z_a; dwv Z_b--Z_w;
  ef s="M": dwv Z_b--Z_w; dwvs(1.14)Z_w--Z_x--Z_t; dwv Z_t--Z_e;
  ef s="Q": dw circ_O; dw (.6aW,.4aH)--Z_e;
  ef s="R": dwv Z_b--Z_w; dw Z_r--(.65aW,fH){right}..(fW,.7aH)..{left}(.65aW,.44aH)..(hP,.44aH);
            cdw Z_e{up}..{left}(hW,.44aH);
  ef s="T": dwh Z_q--Z_u; dwv .5[Z_q,Z_u]--Z_g;
  ef s="U": cdw Z_w..Z_m{down}..{right}Z_x{right}..{up}Z_o..Z_t;
  ef s="V": dwvs(1.2)Z_w--Z_g--Z_t;
  ef s="W": dwvs(1.08)Z_w--(aW/4,0)--Z_f--Z_l--Z_t;
  ef s="X": dwvs(1.4)Z_w..Z_e; dwvs(1.4) Z_b..Z_t;
  ef s="Y": dwvs(1.2)Z_w--Z_y--Z_t; dwv Z_y--Z_g;
  ef s="Z": dwh Z_q--Z_u; dwvs(1.4)(1.4hP,fP)--(aW-1.4hP,aH-fP); dwh Z_a--Z_d;
  ef s="a": dw Z_x..Z_o..Z_s..Z_m..cycle; dwv Z_e--Z_t;
  ef s="b": dw Z_x..Z_o..Z_p..Z_m..cycle; dwv Z_b--(hP,1.3aH)
  ef s="c": cdw sbp(.06,.94)Z_o..Z_s..Z_m..Z_x..cycle;
  ef s="d": dw Z_x..Z_o..Z_p..Z_m..cycle; dwv Z_e--(fW,1.3aH);
  ef s="e": cdw sbp(0,.92)Z_o..Z_s..Z_m..Z_x..cycle; dw Z_o--Z_m;
  ef s="f": cdw (.4fW,0)--(.4fW,.75aH){up}..(.75aW,fH)..{down}(fW,.8aH); dwh Z_h--Z_v;
  ef s="g": dw circ_Oa; dw sbp(0,.5)circ_Oh shifted (0,-.5fH); cdw (fW,.7aH)--(fW,-qH);
  ef s="h": cdw Z_b..(hP,.3aH){up}..(hW,.7fH)..{down}(fW,.3aH)..Z_e; dwv (hP,.3aH)--Z_w;
  ef s="i": dwv Z_g--(hW,.7aH); ppcs 1.4fP; dw Z_s;
  ef s="j": cdw (fW,.7aH)--Z_z..(aW/4,-.66fP)..Z_c; ppcs 1.4fP; dw Z_n;
  ef s="k": dwv Z_b--(hP,1.3fH); cdw .5[Z_b,Z_w]--Z_e; cdw .5[Z_b,Z_w]--Z_u;
  ef s="m": cdw Z_b..(hP,.3aH){up}..(.28aW,fH)..{down}(hW,.3aH)..Z_g;
            cdw (hW,.6aH){up}..(.7aW,fH)..{down}(fW,.6aH)..Z_e; dwv (hP,.3aH)--Z_w;
  ef s="n": cdw Z_b{up}..(hW,.8fH)..{down}Z_o..Z_e; dwv Z_b--(hP,.8aH);
  ef s="o": dw Z_x..Z_o..Z_s..Z_m..cycle;
  ef s="p": dw Z_x..Z_o..Z_s..Z_m..cycle; dwv Z_w--(hP,-.3aH);
  ef s="q": dw Z_x..Z_o..Z_s..Z_m..cycle; dwv Z_t--(fW,-.3aH);
  ef s="r": cdw (sbp(.33,.72)Z_x..Z_o..Z_s..Z_m..cycle) shifted(0,-hP); dwv Z_b--Z_w;
  ef s="s": cdw sbp(.05,.45)circ_O; cdw sbp(.55,.95)circ_O; dw (fW,.3aH){up}..{up}(hP,.7aH);
  ef s="t": dwv Z_g--Z_f; dwh (0,.66aH)--(aW,.66aH);
  ef s="u": cdw Z_w..(hP,.55aH){down}..Z_x..(fW,.55aH){up}..Z_t; dwv Z_t--Z_e;
  ef s="v": dwv Z_w--Z_g--Z_t;
  ef s="w": dwv Z_w--(aW/4,0)--Z_f--Z_l--Z_t;
  ef s="x": dwvs(1.4)Z_w--Z_e; dwvs(1.4) Z_t--Z_b;
  ef s="y": dwvs(1.4)(Z_w--Z_y) shifted (0,-.3aH); dwvs(1.4)(Z_t--Z_b) shifted (0,-.3aH);
  ef s="z": dwh Z_q--Z_u; dwvs(1.4)(1.4hP,fP)--(aW-1.4hP,aH-fP); dwh Z_a--Z_d;
  ef s="0": dw Z_m...Z_s...Z_o...Z_x...cycle;
  ef s="1": dwv Z_g--(hW,aH-.3hP)--(hW-fP,aH-fP)--(hW-fP,aH-1.5fP);
  ef s="5": dwh Z_q--Z_u; dwv Z_r--(hP,.55fH);
            cdw (qP,.18aH)..(.65aW,1.3hP)..(fW,.4aH)..(hW,.63aH)..(.7hP,.56aH);
  ef s="6": dw Z_x..(fW,.5fW)..Z_i..(hP,.5fW)..cycle; cdw (.8fP,hH)--Z_f;
  ef s="7": dwh (0,.fH)--Z_u; dwvs(1.2)(aW-1.2hP,aH-fP)--(.4aW,0);
  ef s="8": dw circ_Oh; dw (hP,.75aH)...Z_s...(fW,.75aH)...Z_y...cycle;
  ef s="9": dw (Z_x..(fW,.5fW)..Z_i..(hP,.5fW)..cycle) shifted (0,.32aH); cdw (fW-.45fP,hH)--Z_g;
  else:
  fi
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def warning_bond(expr a)=
  if addA[a]=0:
    warning("A"&decimal(a)&" ( "&fsl(8)(str_tbl[strA[a]])&") has"&fdr(2)(bond_cntA)&" bonds");
  fi
enddef;
%-------------------------------------------------------------------------------------------------
vardef erase_char(expr s)=
  sS:="";
  if (length(s)>=4)and(s<>"COOH"):
    for i=1 upto length(s): sC:=subc(i,s); if scan_c(sC,"{}_^+-")=0: sS:=sS&sC; fi endfor sS
  else: s
  fi
enddef;
%-------------------------------------------------------------------------------------------------
vardef forbidden_to_underbar(expr t)=  sS:="";
  for i=1 upto length(t):
    sC:=subc(i,t); if scan_c(sC,forbiddens)>0: sS:=sS&"_"; else: sS:=sS&sC; fi
  endfor
  sS
enddef;
%=================================================================================================
def proc_calc(expr n)=
  MW_n:=MI_n:=tbl_atom_max:=warning_cnt:=hideH_cnt:=0; nE:=pcode_emb_start;
  for i=1 upto tbl_atom_end: sumA[i]:=0; endfor
  for i=1 upto cntA:
    knownA:=bond_cntA:=0; nS:=strA[i];
    for j=1 upto cntB:
      bond_num[j]:=bond_type(lineB[j]);
      if (sB[j]=i)or(eB[j]=i): bond_cntA:=bond_cntA+bond_num[j]; fi
    endfor
    Bcnt[i]:=bond_cntA;
    if ((nS=0)or(nS=(C-nE)))and(bond_cntA<4):
      hideH[i]:=4-bond_cntA; hideH_cnt:=hideH_cnt+hideH[i]; else: hideH[i]:=0;
    fi
    if nS=0:         if bond_cntA>4:  warning_bond(i) fi
    ef nS=(O-nE):    if bond_cntA<>2: warning_bond(i) fi
    ef nS=(N-nE):    if (bond_cntA<>3)and(bond_cntA<>5): warning_bond(i) fi
    ef nS=(S-nE):    if (bond_cntA<>2)and(bond_cntA<>4)and(bond_cntA<>6): warning_bond(i) fi
    ef nS=(H-nE):    if bond_cntA<>1: warning_bond(i) fi
    ef nS=(OH-nE):   if bond_cntA<>1: warning_bond(i) fi
    ef nS=(COOH-nE): if bond_cntA<>1: warning_bond(i) fi
    ef nS=(NH2-nE):  if bond_cntA<>1: warning_bond(i) fi
    ef nS=(CN-nE):   if bond_cntA<>1: warning_bond(i) fi
    ef nS=(P-nE):    if bond_cntA<>5: warning_bond(i) fi
    ef nS=(C-nE):    if bond_cntA>4:  warning_bond(i) fi
    ef nS=(F-nE):    if bond_cntA<>1: warning_bond(i) fi
    ef nS=(Cl-nE):   if bond_cntA<>1: warning_bond(i) fi
    ef nS=(Br-nE):   if bond_cntA<>1: warning_bond(i) fi
    fi
    for j=1 upto tbl_group_end:
      if str_tbl[nS]=tbl_atom_str[j]:
        if tbl_atom[j]=0: sumA[j]:=sumA[j]+1; if j>tbl_atom_max: tbl_atom_max:=j; fi
        else:
          for k=1 upto tbl_atom[j]:
            sumA[tbl_group[j][k]]:=sumA[tbl_group[j][k]]+1;
            if tbl_group[j][k]>tbl_atom_max: tbl_atom_max:=tbl_group[j][k]; fi
          endfor
        fi
        knownA:=1;
      fi
      exitif knownA=1;
    endfor
    if knownA=0: warning(" Unknown Str("&str_tbl[strA[i]]&") is used "&decimal(i)); fi
  endfor
  %-------------------------------------------------------------------------------------
  sumA[2]:=sumA[2]+hideH_cnt; if (tbl_atom_max=1)and(sumA[2]>0): tbl_atom_max:=2; fi
  for i=1 upto tbl_atom_max:
    if sumA[i]>=1:
      MW_n:= MW_n+tbl_atom_wt[i]*sumA[i]; MI_n:= MI_n+tbl_atom_mi[i]*sumA[i];
      fm:=fm&erase_char(tbl_atom_str[i]) if sumA[i]>=2: &decimal(sumA[i]) fi;
    fi
  endfor
  mw:=substring(0,8) of decimal(MW_n); MI:=substring(0,10) of decimal(MI_n);
enddef;
%=================================================================================================
def proc_report_out=
  file_output:=jobname&"-report.txt";
  printf "===========================================================================";
  printf " No["&decimal(fig_num)&"],Name<"& EN&">,Category<"&CAT&">,File<"&file_input&">";
  printf "---------------------------------------------------------------------------";
  for i=1 upto mc_row: printf (substring(0,mc_indent[i]) of blanks)&mc[i]; endfor
  printf "---------------------------------------------------------------------------";
  printf " Row["&decimal(mc_row)&"],Length["&decimal(length(mc))&"],Block"&
         "["&decimal(block_cnt+1)&"]"&",Code pair["&decimal(pcode_cnt[0])&
         "],Warning["&decimal(warning_cnt)&"]";
  printf "---------------------------------------------------------------------------";
  printf "" for i=EQU,CLN,QES,AMK,AMP,HSH,GTN,BAR,QUT,TLD,HAT,BQT,LTN:
              if tbl_asc[i]>=1: &" "&char(i)&"["&decimal(tbl_asc[i])&"]" fi
            endfor ;
  printf "---------------------------------------------------------------------------";
  printf " Width["&fdr(8)(mol_wd)&"],Height["&fdr(8)(mol_ht)&"],"&
         " Shift x["& fdr(8)(minX)&"],Shift y["&fdr(8)(minY)&"]";
  printf " Bond length["&fdr(8)(blen)&"],Atom size["&fdr(8)(atom_wd)&"]";
  printf "---------------------------------------------------------------------------";
  printf " Atom["&decimal(cntA)&"],Bond["&decimal(cntB)&
         "],Ring["&decimal(cntB-cntA+1)&"],Hide H["&decimal(hideH_cnt)&"]";
  printf "< NO. ><atom(s) >(  x axis   ,   y axis   )<bond><hideH><chg>";
  for i=1 upto cntA:
    printf " A"&fdl(6)(i)&fsl(8)(erase_char(str_tbl[strA[i]]))&
           " ("&fdr(10)(round(xpart(posA[i])/blen))&" , "&
            fdr(10)(round(ypart(posA[i])/blen))&" ) "&fdr(4)(Bcnt[i])&
            iif(hideH[i]>0,fdr(6)(hideH[i]),"        ") if chargeA[i]<>0: &fdr(4)(chargeA[i]) fi;
  endfor
  printf "---------------------------------------------------------------------------";
  printf "< NO. ><  bond   (sdt)><angle +(  +-  )><length (   pt   )>";
  for i=1 upto cntB:
    nC:=lenB[i]; if nC=_size_atom: nC:=ratio_atom_bond; elseif nC<0: nC:=-nC; fi
    nB:=angB[i]; if nB>180: nB:=nB-360; fi
    printf " B"&fdl(4)(i)&fdr(3)(sB[i])&" -> "&fdr(3)(eB[i])&
           " ("&fdr(3)(bond_num[i])&")"&fdr(8)(round(angB[i]))&
           " ("&fdr(6)(round(nB))&")"&fdr(8)(nC)&" ("&fdr(8)(round(nC*blen))&")";
  endfor
  printf "---------------------------------------------------------------------------";
  printf "<atom>( atom wt )[ mi wt   ]  < cnt > < sum wt   >[ sum mi wt  ]";
  for i=1 upto tbl_atom_max:
    if sumA[i]>=1:
      printf " "&fsl(5)(erase_char(tbl_atom_str[i]))&
        "("&fdr(9)(tbl_atom_wt[i])&")"&"["&fdr(9)(tbl_atom_mi[i])&"]"&" * "&fdr(8)(sumA[i])
        &"    "&fdr(7)(tbl_atom_wt[i]*sumA[i])&"["&fdr(12)(tbl_atom_mi[i]*sumA[i])&"]";
    fi
  endfor
  printf " Molecular Weight [Mono Isotopic] =   "&fsr(12)(mw)&"["&fsr(12)(MI)&"]";
  printf "---------------------------------------------------------------------------";
  printf " Weight Calc: "&mw if MW<>"-": &" - Input: "&MW&" = "&fdr(9)(MW_n-scantokens(MW)) fi;
  printf " Fomula Calc: "&fm if FM<>"-": &" "&iif(fm=FM,"=","<>")&" Input: "&FM fi;
  printf "===========================================================================";
enddef;
%=================================================================================================
def proc_mol_out(expr n)=
  if EN<>"-": EN_:=forbidden_to_underbar(EN); fi
  file_output:="m"&fit_zero(fig_num)&"-"&EN_&".mol";
  %-V2000---------------------------------------------------------------------------------------
  if n=2000:
    printf ""; printf "  -MCFtoMOL- "&fsl(20)(EN); printf "";
    printf fdr(3)(cntA)&fdr(3)(cntB)&"  0  0  0  0  0  0  0  0999 V2000";
    for i=1 upto cntA:
      printf fdr(10)(xpart(posA[i])/blen)& fdr(10)(ypart(posA[i])/blen)&fdr(10)(0)&" "&
             fsl(2)(erase_char(str_tbl[strA[i]]))&"  0"&fdr(3)(bond_charge(chargeA[i]))&"  0  0";
    endfor
    for i=1 upto cntB:
      if lineB[i]<>0: printf fdr(3)(sB[i])&fdr(3)(eB[i])&fdr(3)(bond_type(lineB[i]))&
                      fdr(3)(bond_stereo(lineB[i]))&"     0  0";
      fi
    endfor
    printf "M  END";
  %-V3000---------------------------------------------------------------------------------------
  elseif n=3000:
    printf ""; printf "  -MCFtoMOL- "&fsl(20)(EN); printf "";
    printf "  0  0  0  0  0  0  0  0  0  0  0 V3000"; 
    printf "M  V30 BEGIN CTAB";
    printf "M  V30 COUNTS "&decimal(cntA)&" "&decimal(cntB)&" 0 0 0";
    printf "M  V30 BEGIN ATOM";
    for i=1 upto cntA:
      printf "M  V30 "&decimal(i)&" "&erase_char(str_tbl[strA[i]])&" "&
             decimal(xpart(posA[i])/blen)&" "&decimal(ypart(posA[i])/blen)&" 0 0"
             if chargeA[i]<>0: &" CHG="&decimal(chargeA[i]) fi;
    endfor
    printf "M  V30 END ATOM"; printf "M  V30 BEGIN BOND";
    for i=1 upto cntB:
      if lineB[i]<>0:
        printf "M  V30 "&decimal(i)&" "&decimal(bond_type(lineB[i]))&
               " "&decimal(sB[i])&" "&decimal(eB[i])
               if bond_stereo(lineB[i])<>0: &" CFG="&decimal(bond_config(lineB[i])) fi;
      fi
    endfor
    printf "M  V30 END BOND"; printf "M  V30 END CTAB"; printf "M  END"; fi
enddef;
%=================================================================================================
def proc_mc_out=
  file_output:="temp-mc.aux";
  if mc_length<100:
    nN:=split_str(mc,",")(arg_s); nA:=0; temps:="";
    for i=1 upto nN:
      if i=nN: temps:=temps&arg_s[i]; printf temps;
      ef at_char[i+1]-nA>mc_length: nA:=at_char[i]; printf temps&arg_s[i]&","; temps:="";
      else: temps:=temps&arg_s[i]&",";
      fi
    endfor
  else: for i=1 upto mc_row: printf (substring(0,mc_indent[i]) of blanks)&mc[i]; endfor
  fi
  printf EOF;
enddef;
%=================================================================================================
vardef fit_zero(expr n)= if n<=9: "00" ef n<=99: "0" else: "" fi &decimal(n) enddef;
vardef bond_type(expr n)=
  if (n>=dl)and(n<=dm_):2 ef n=tm:3 ef (n=0)or(n=vf)or(n=vb): 0 else: 1 fi enddef;
vardef bond_charge(expr n)= if n=2: 1 ef n=1: 3 ef n=-1: 5 ef n=-2: 6 else: 0 fi enddef;
vardef bond_stereo(expr n)=
 if (n=wf)or(n=zb)or(n=bd): 1 ef (n=zf)or(n=wb)or(n=dt): 6 ef n=wv: 4 else: 0 fi enddef;
vardef bond_config(expr n)=
 if (n=wf)or(n=zb)or(n=bd): 1 ef (n=zf)or(n=wb)or(n=dt): 3 ef n=wv: 2 else: 0 fi enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef define_atom(expr s,WT,MI)=
  str_cnt:=str_cnt+1; tbl_cnt:=tbl_cnt+1; pcode_num:=pcode_num+1;
  pcode_com[pcode_num][1]:=_set_atom; pcode_par[pcode_num][1]:=str_cnt; pcode_cnt[pcode_num]:=1;
  str_tbl[str_cnt]:=tbl_atom_str[tbl_cnt]:=s; tbl_atom[tbl_cnt]:=0;
  tbl_atom_wt[tbl_cnt]:=WT; tbl_atom_mi[tbl_cnt]:=MI; pcode_num
enddef;
%-------------------------------------------------------------------------------------------------
vardef define_group_string(expr s)(text t)=
  str_cnt:=str_cnt+1; tbl_cnt:=tbl_cnt+1; pcode_num:=pcode_num+1;
  pcode_com[pcode_num][1]:=_set_atom; pcode_par[pcode_num][1]:=str_cnt; pcode_cnt[pcode_num]:=1;
  str_tbl[str_cnt]:=tbl_atom_str[tbl_cnt]:=s; tbl_atom[tbl_cnt]:=0;
  for list=t: tbl_group[tbl_cnt][incr tbl_atom[tbl_cnt]]:=list-pcode_emb_start; endfor
  pcode_num
enddef;
%=================================================================================================
def define_atom_group_parts=
  save `,``,';
  def `=define_atom enddef; def ``=define_group_string enddef; def '= define_parts enddef;
  pcode_int:=pcode_emi_start; pcode_num:=pcode_emb_start;
  ?3:=?20:=Ph:=Ph1:=Ph2:=hz:=0; vt:=1;
  %-----------------------------------------------------------------------------------------------
  C:= `("C"   ,12.0107,   12.0000000);       H:= `("H"  , 1.00794,    1.00782503223);
  D:= `("D"   ,2.012,      2.01410177812);   Ag:=`("{Ag}",107.868,  106.905095);
  Al:=`("{Al}",26.9815,   26.98153853);      As:=`("{As}",74.9216,   74.92159457);
  B:= `("B"   ,10.811,    11.00930536);      Ba:=`("{Ba}",137.33,   136.905816);
  Be:=`("{Be}",9.01218,   0);
  Bi:=`("{Bi}",208.9804,  208.980338);       Br:=`("{Br}",79.904,    78.9183376);
  Ca:=`("{Ca}",40.078,    39.962590863);     Cd:=`("{Cd}",112.41,     110.904182);
  Cl:=`("{Cl}",35.453,    34.968852);        Co:=`("{Co}",58.933194, 58.93319429);
  Cr:=`("{Cr}",51.9961,   51.94050623);      Cs:=`("{Cs}",132.905,   132.90543);
  Cu:=`("{Cu}",63.546,    62.92959772);     
  F:= `("F"   ,18.9984,   18.99840316273);   Fe:=`("{Fe}",55.845,    55.93493633);
  Hg:=`("{Hg}",200.59,    201.97064340);     I:= `("I"   ,126.90447,126.9044719);
  K:= `("K"   ,39.0983,   38.9637064864);    Li:=`("{Li}",6.941,      7.0160034366);
  Mg:=`("{Mg}",24.305,    23.985041697);     Mn:=`("{Mn}",54.938044, 54.93804391);
  Mo:=`("{Mo}",95.95,     0);
  N:= `("N"   ,14.0067,   14.00307400443);   Na:=`("{Na}",22.98977,  22.9897692820);
  Ni:=`("{Ni}",58.693,    57.93534241);      O:= `("O"   ,15.9994,   15.99491461957);
  P:= `("P"   ,30.973762, 30.97376199842);   Pb:=`("{Pb}",207.2,    205.974455);
  Pd:=`("{Pd}",106.4,    107.905075);
  S:= `("S"   ,32.065,    31.9720711744);    Sb:=`("{Sb}",121.75,   120.90381);
  Se:=`("{Se}",78.971,    79.9165218);       Si:=`("{Si}",28.0855,   27.97692653465);
  Sn:=`("{Sn}",118.71,   119.90220163);      Ta:=`("{Ta}",180.948,   0);
  Te:=`("{Te}",127.60,    129.90623);        Ti:=`("{Ti}",47.867,    47.94794198);
  U:= `("U",   238.0289, 238.05079);         V:= `("V",   50.9415,   50.943957);
  W:= `("W",   183.85,   181.948225);        Zn:=`("{Zn}",65.409,    63.92914201);
  NO_ATOM:=`("",0,0);
  tbl_atom_end:=tbl_cnt;
  %-----------------------------------------------------------------------------------------------
  if sw_expand=0:
    CH3:=``("C{H_3_}")(C,H,H,H); CH2:=``("C{H_3_}")(C,H,H); CN:=``("CN")(C,N); OH:=``("OH")(O,H);
    COOH:=``("COOH")(C,O,O,H); COONa:=``("COO{Na}")(C,O,O,Na); CHO:=``("CHO")(C,H,O);
    NO:=``("NO")(N,O); NO2:=``("N{O_2_}")(N,O,O); NH2:=``("N{H_2_}")(N,H,H);
    SH:= ``("SH")(S,H); SO2H:=``("S{O_2_}H")(S,O,O,H); SO3H:=``("S{O_3_}H")(S,O,O,O,H);
    ONa:=``("O{Na}")(O,Na); SO3Na:=``("S{O_3_}{Na}")(S,O,O,O,Na);
  fi
  %-----------------------------------------------------------------------------------------------
  tbl_group_end:=tbl_cnt; pcode_atm_end:=pcode_num;
  ?:='((_group_si,NO_ATOM)); ?wf:=?w:='((_group_wf,NO_ATOM)); ?zf:=?z:='((_group_zf,NO_ATOM));
  ?O:='((_group_dm,O)); NH:='(N,/H~nl); ?NH:='((_group_dm,NH));
  %-----------------------------------------------------------------------------------------------
  ?H:='(/H); ?F:='(/F); ?Cl:='(/Cl); ?OH:='(/OH); ?OH:='(/COOH); ?NH2:='(/NH2);
  for i=3 upto 20: ?[i]:='((_com,_len_ss),(_get_len,_ring_len),<((-180 DIV i)-90)
    for j==2 upto i:: ,(360 DIV i) endfor,(_cyc_sB,1-i),(_com,_len_ee));
  endfor
  Ph:=Ph1:='(?6,-2=dl,-4=dl,-6=dl); Ph2:='(?6,-1=dl,-3=dl,-5=dl);
  for i=5,6,7,8: for j=11 upto 15:  ?[i][j]:='((i,j)); endfor endfor
  %-----------------------------------------------------------------------------------------------
  !:=!1:='((_mk_bond,_arrange_ang)); !db:=!d:='(!~db); !tm:=!t:='(!~tm); !wf:=!w:='(!~wf);
  !zf:=!z:='(!~zf); !wb:='(!~wb); !zb:='(!~zb); !dl:='(!~dl); !dr:='(!~dr); !dm:='(!~dm);
  for i==2  upto 20:
    ![i]:='((_com,_len_ss),(_get_len,_tmp_len),! for j==2 upto i::,! endfor ,(_com,_len_ee));
  endfor
  ?!:='(/_,!); ?!d:='(/_,!d); ?!2:='(/_,!2); ??!:='(/_,/_^60,60); ??:='(/_^35,/_^-35);
  !?:='(!,/_); !?!:='(!?,!); !??!:='(!,??,!); ?2:='(/!); !?2:='(!,?2); ?2!:='(?2,!);
  n_:='((_set_add,MIS)); p_:='((_set_add,PLS));
  zero_wf:='(0~wf); zero_zf:='(0~zf); zero_dm:='(0~dm); zero_wv:='(0~wv);
  mark_adress:='((_com,_mark)); reset_adress:='((_com,_moff)); reset_length:='((_com,_len_e));
  %-----------------------------------------------------------------------------------------------
  if sw_expand=1:
    CH3:='(/H,/H^60,/H^-60); NH:='(N,/H); NH2:='(N,/H^60,/H^-60); NO2:='(N,//O^60,//O^-60);
    OH:='(O,!,H); NO:='(N,//O); CONH2:='(//O,!,NH2); SH:='(S,!,H); SO2H:='(S,//O^60,/OH^-60);
    SO3H:='(S,/OH,//O^60,//O^-60); CHO:='(//O^-60,/H^60); COOH:='(//O^-60,/OH^60); CN:='(!~tm,N);
    ONa:='(O,!,Na); SO3Na:='(S,/ONa,//O^60,//O^-60);
  fi
  %-----------------------------------------------------------------------------------------------
  ?F!F:='(/F,60,F); ?Cl!Cl:='(/Cl,60,Cl); ?Br!Br:='(/Br,60,Br); ?F?F!F:='(/F,/F^60,60,F);
  ?Cl?Cl!Cl:='(/Cl,/Cl^60,60,Cl);
  %-----------------------------------------------------------------------------------------------
  N!:='(N,!); N?:='(N,/_); N!2:='(N,!3); N!2:='(N,!3); !N:='(!,N);
  N?!:='(N,?!); N?2:='(N,?2); N?2!:='(N?2,!); N?!2:='(N,?!2);
  S?O:='(S,?O); S?O!:='(S?O,!); ?O?O:='(?O^-35,?O^35); S?O?O:='(S,?O?O); S?O?O!:='(S?O?O,!);
  O!:='(O,!); O!2:='(O,!2); O!3:='(O,!3); S!:='(S,!); S!2:='(S,!2); S!3:='(S,!3);
  %-----------------------------------------------------------------------------------------------
  ?O!:='(?O,!); ?O!2:='(?O,!2); ?O!3:='(?O,!3); !?O:='(!,?O); !?O!:='(!,?O!);
  NH!:='(NH,!); NH!2:='(NH,!2); !NH:='(!,NH); !NH!:='(!,NH!);
  %-----------------------------------------------------------------------------------------------
  !OH:='(!,OH); !SH:='(!,SH); !NH2:='(!,NH2); !S?O:='(!,S?O); !O:='(!,O); !dO:='(!d,O);
  !O!:='(!,O!); !O!2:='(!,O!2); !O!3:='(!,O!3); !S!:='(!,S!); !S!2:='(!,S!2); !S!3:='(!,S!3);
  !COOH:='(!,COOH); ?COOH:='(/COOH); !CH3:='(!,CH3); !CN:='(!,CN); !CHO:='(!,CHO); !NO2:='(!,NO2);
  !Cl:='(!,Cl); !Br:='(!,Br); !F:='(!,F); !?F!F:='(!,?F!F); !?Cl!Cl:='(!,?Cl!Cl);
  !?F?F!F:='(!,?F?F!F); !?Cl?Cl!Cl:='(!,?Cl?Cl!Cl);
  !?3:='(!,?3); !?4:='(!,?4); !?5:='(!,?5); !?6:='(!,?6); !?7:='(!,?7); !?8:='(!,?8);
  !Ph:='(!,Ph); !?OH:='(!,?OH); ?OH!:='(?OH,!);
  %-----------------------------------------------------------------------------------------------
  lr:='(60 for i==1 upto 10:: ,-60,60 endfor); rl:='(-60 for i==1 upto 10:: ,60,-60 endfor);
  %-----------------------------------------------------------------------------------------------
  hexose_hp:='(#1.4,-30~wf_r,30~bd_r`1,30~wb_r,120,O,30,&1,##);
  Pyranose_hp:='(#1.4,-35~wf_r,35~bd_r`1,30~wb_r,130`1.66,O,&1,##);
enddef;
%-------------------------------------------------------------------------------------------------
define_atom_group_parts;
%=================================================================================================
init_par(parameter_list);
%-------------------------------------------------------------------------------------------------
for i=pcode_emb_start+1 upto pcode_num: pcode_all:=pcode_all+pcode_cnt[i]; endfor
message "pcode_emb  =" & decimal(pcode_emb_start) &" => " & decimal(pcode_num) & 
                       " [ " & decimal(pcode_all) & " ]";
message "pcode_emi  =" & decimal(pcode_emi_start) &" => " & decimal(pcode_int);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vardef checkm(expr s)=
  save mc_char,mc_adr,mc_asc,char_cnt,lens,f_depth;
  string err_type[];
  numeric mc_char[],mc_asc[],mc_adr[];
  err_cnt:=char_cnt:=block_cnt:=f_depth:=0; nA:=1; lens:=length(s);
  err_type[0]:="no mc-row    "; err_type[1]:="mismatch ()  "; err_type[2]:="mismatch {}  ";
  err_type[3]:="mismatch []  "; err_type[4]:="missing arg  "; err_type[5]:="extra arg    ";
 %---------------------------------------------------------------------------------------------
  if mc_row>=1:
    for i=1 upto 128: tbl_asc[i]:=0; endfor
    for i=1 upto lens: mc_char[i]:=ASCII(subc(i,s)); endfor
    forever:
      temps:=substring (nA-1,nA) of s;
      if (temps<>",")and(temps<>" "): nF:=0;
        for j=1 upto rw_cnt: nC:=lenw[j]-1;
          if substring (nA-1,nA+nC) of s=rw[j]:
            for k=1 upto nC: mc_char[nA]:=j; mc_char[nA+k]:=BLK; endfor
            nF:=1; nA:=nA+nC;
          fi
          exitif nF=1;
        endfor
      fi
      nA:=nA+1; exitif nA>=lens;
    endfor
    for i=1 upto lens:
      if mc_char[i]<>BLK: mc_asc[incr char_cnt]:=mc_char[i]; mc_adr[char_cnt]:=i; fi
    endfor
    mc_asc[0]:=mc_asc[char_cnt+1]:=CMA;
    %-- argument check -------------------------------------------------------------------------
    for i=1 upto char_cnt:
      nA:=mc_asc[i-1]; nB:=mc_asc[i]; nC:=mc_asc[i+1]; tbl_asc[nB]:=tbl_asc[nB]+1;
      if nB=CMA: if f_depth=0: block_cnt:=block_cnt+1; fi
      ef (nB=EQU)or(nB=CLN)or(nB=HAT)or(nB=BQT)or(nB=TLD)or(nB=LTN):      % =,:,^,`,~,>
        if (nA=CMA)or(nC=CMA): proc_err(4,i) fi
      ef (nB=AMK)or(nB=AMP)or(nB=GTN)or(nB=HSH):                          % @,&,<,#
        if nA<>CMA: proc_err(5,nB) fi if nC=CMA: proc_err(4,i) fi
      ef (nB=SLS)or((nB>=7)and(nB<=11)):                                  % /,*/*,//,/*,*/,**
        if (nA<>CMA)and(nA<>CLN)and(nA<>PRS): proc_err(5,i) fi
        if nC=CMA: proc_err(4,i) fi
      fi
      if (nB=PRS)or(nB=BRS): f_depth:=f_depth+1; ef (nB=PRE)or(nB=BRE): f_depth:=f_depth-1; fi
    endfor
    %-- brackets balance check -----------------------------------------------------------------
    if tbl_asc[PRS]<>tbl_asc[PRE]: proc_err(1,0) fi           %  mismatch ()
    if tbl_asc[BRS]<>tbl_asc[BRE]: proc_err(2,0) fi           %  mismatch {}
    if tbl_asc[BKS]<>tbl_asc[BKE]: proc_err(3,0) fi           %  mismatch []
  else: proc_err(0,0) fi
  %---------------------------------------------------------------------------------------------
%%%%%%%  err_cnt>0: readstring;
  err_cnt
enddef;
%-------------------------------------------------------------------------------------------------
def proc_err(expr e,n)= 
  err_cnt:=err_cnt+1;
  message "["&decimal(fig_num)&"]:"&err_type[e]
    if n>=1: &"("&fdr(3)(n)&") "&substring(mc_adr[n]-2,mc_adr[n]+3) of mc fi ;
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
def savem(expr s)=
  file_output:=s;
  for i=1 upto ucount: for j=1 upto unit_lines[i]: printf row[i][j]; endfor endfor
  closefrom file_output;
enddef;
%-------------------------------------------------------------------------------------------------
def loadm(text s)=
  begingroup
  save f_mcf,f_line,lines,unit_cnt,row_s,row_cnt,semic_cnt,info_cnt,order,min_n,max_n,firstc,
       sign_at,sign_n,filter_n,filter_tag,filter_var,filter_sign,filter_cnt,filter_p,lib_unit_cnt,
       at_colon,at_equal,at_less,at_greater,at_n,sort_tbl,key_s,sort_s,sign_s,sV,sS,sT,sort_oder,
       tag_s,val_s;
  string row_s[][],sort_s,sort_tbl[],key_s,filter_tag[],filter_var[],sign_s[],sV,sS,sT,firstc,
         tag_s[][],val_s[][];
  numeric row_cnt[],order[],order_tbl[],filter_sign[],filter_p[];
  lines:=f_mcf:=mc_row:=info_cnt:=filter_cnt:=lib_unit_cnt:=0; unit_cnt:=1;
  file_input:=default_library;
  sign_s1:="="; sign_s2:="<>"; sign_s3:="<"; sign_s4:=">"; sign_s5:="<="; sign_s6:=">=";
  %-----------------------------------------------------------------------------------------------
  for list=s:
    at_colon:=scan_c(":",list); at_equal:=scan_c("=",list); at_less:=scan_c("<",list);
    at_greater:=scan_c(">",list); key_s:="";
    %---------------------------------------------------------------------------------------------
    if at_colon>=2:                               sign_at:=at_colon;   sign_n:=0; at_n:=1;
    ef at_equal>=2:   if (at_equal-1)=at_less:    sign_at:=at_equal;   sign_n:=5; at_n:=2;
                      ef (at_equal-1)=at_greater: sign_at:=at_equal;   sign_n:=6; at_n:=2;
                      else:                       sign_at:=at_equal;   sign_n:=1; at_n:=1; fi
    ef at_greater>=2: if (at_greater-1)=at_less:  sign_at:=at_greater; sign_n:=2; at_n:=2;
                      else:                       sign_at:=at_greater; sign_n:=4; at_n:=1; fi
    ef at_less>=2:                                sign_at:=at_less;    sign_n:=3; at_n:=1; fi
    sT:=substring(0,sign_at-at_n) of list; sV:=substring(sign_at,length(list)) of list;
    %---------------------------------------------------------------------------------------------
    if sign_n=0:
      if sT="f": if scan_c(".",sV)=0: file_input:=sV&".mcf";  else: file_input:=sV; fi
      ef sT="a": key_s:=sV; sort_oder:=0;
      ef sT="d": key_s:=sV; sort_oder:=1; fi
    else:
      filter_tag[incr filter_cnt]:=sT; filter_sign[filter_cnt]:=sign_n;
      if (sign_n>=3)and(is_num(sV)=1): filter_var[filter_cnt]:=fix_num(sV);
      else: filter_var[filter_cnt]:=sV; fi
    fi
  endfor
  %-----------------------------------------------------------------------------------------------
  forever:
    temps:=readfrom file_input; exitif temps=EOF; firstc:=subc(1,temps);
    if (firstc<>"%")or(sw_comment=1):
      row_s[unit_cnt][incr lines]:=temps;
      if firstc=";":
        row_cnt[unit_cnt]:=lines; f_mcf:=lines:=0; filter_n:=1;
        for i=1 upto filter_cnt: filter_p[i]:=0; endfor
        sort_s:="";
        for i=1 upto info_cnt:
          get_tag_var(arg_s[i])(sT,sV);
          tag_s[unit_cnt][i]:=sT; val_s[unit_cnt][i]:=sV;
          if sT=key_s: if is_num(sV)=1: sort_s:=fix_num(sV); else: sort_s:=sV; fi fi
          for j=1 upto filter_cnt:
            if filter_tag[j]=sT:
              filter_p[j]:=1;
              if (filter_sign[j]>=3)and(is_num(sV)=1): temps:=fix_num(sV); else: temps:=sV; fi
              if filter_sign[j]=1: if not(temps= filter_var[j]): filter_n:=0; fi
              ef filter_sign[j]=2: if not(temps<>filter_var[j]): filter_n:=0; fi
              ef filter_sign[j]=3: if not(temps< filter_var[j]): filter_n:=0; fi
              ef filter_sign[j]=4: if not(temps> filter_var[j]): filter_n:=0; fi
              ef filter_sign[j]=5: if not(temps<=filter_var[j]): filter_n:=0; fi
              ef filter_sign[j]=6: if not(temps>=filter_var[j]): filter_n:=0; fi
              fi
            fi
          endfor
        endfor
        for i=1 upto filter_cnt: if filter_p[i]=0: filter_n:=0; fi endfor
        info_cnt:=0; lib_unit_cnt:=lib_unit_cnt+1;
        if filter_n=1: if key_s<>"": sort_tbl[unit_cnt]:=sort_s; fi unit_cnt:=unit_cnt+1; fi
      ef (firstc=":")or(firstc="="): f_mcf:=1; mc_row:=1;
      ef (firstc<>"%")or(sw_comment=1):
        if f_mcf=1: mc_row:=mc_row+1; else: info[unit_cnt]:=info_cnt:=split_str(temps,";")(arg_s);
        fi
      fi
    fi
  endfor
  ucount:=unit_cnt:=unit_cnt-1;
  %=============================================================================================
  message "* Input  : "&file_input&" ["&decimal(lib_unit_cnt)&"]";
  message "* Output : ucount ["&decimal(ucount)&"]";
  if filter_cnt>=1:
    for i=1 upto filter_cnt:
      message "* Filter("&decimal(i)&"): "&filter_tag[i]&" "&sign_s[filter_sign[i]]&filter_var[i];
    endfor
    if key_s<>"": message "* Sort key : "&key_s&iif(sort_oder=0," (ascending)"," (descending)");
    fi
  fi
  %-----------------------------------------------------------------------------------------
  if key_s<>"":
    for i=1 upto unit_cnt: order[i]:=0; endfor
    for i=1 upto unit_cnt:
      if sort_oder=0: temps:="~";
        for j=1 upto unit_cnt:
          if order[j]=0: if sort_tbl[j]<temps: temps:=sort_tbl[j]; min_n:=j; fi fi
        endfor
        order[min_n]:=i; order_tbl[i]:=min_n;
      ef sort_oder=1: temps:=" ";
        for j=1 upto unit_cnt:
          if order[j]=0: if sort_tbl[j]>temps: temps:=sort_tbl[j]; max_n:=j; fi fi
        endfor
        order[max_n]:=i; order_tbl[i]:=max_n;
      fi
    endfor
    %---------------------------------------------------------------------------
    for i=1 upto unit_cnt:
      for j=1 upto info[order_tbl[i]]:
        lib_tag[i][j]:=tag_s[order_tbl[i]][j]; lib_val[i][j]:=val_s[order_tbl[i]][j];
      endfor
      unit_lines[i]:=row_cnt[order_tbl[i]];
      for j=1 upto row_cnt[order_tbl[i]]: row[i][j]:=row_s[order_tbl[i]][j]; endfor
    endfor
    %-------------------------------------------------------------------------
  else:
    for i=1 upto unit_cnt:
      for j=1 upto info[i]: lib_tag[i][j]:=tag_s[i][j]; lib_val[i][j]:=val_s[i][j]; endfor
      unit_lines[i]:=row_cnt[i];
      for j=1 upto row_cnt[i]: row[i][j]:=row_s[i][j]; endfor
    endfor
  fi
  closefrom file_input;
  endgroup;
enddef;
%=============================================================================================
vardef fix_num(expr s)=
  sS:=s; nN:=scan_c(".",sS);
  if nN=0: sS:=fsr(4)(sS); ef nN=1: sS:="   0"&sS;
  ef nN=2: sS:="   "&sS; ef nN=3: sS:="  "&sS; ef nN=4: sS:=" "&sS;
  fi
  sS
enddef;
%-------------------------------------------------------------------------------------------------
vardef is_num(expr s)=
  for i=1 upto length(s):
    if ((subc(i,s)>="0")and(subc(i,s)<="9"))or(subc(i,s)="."): nN:=1; else: nN:=0; fi
  endfor
  nN
enddef;
%-------------------------------------------------------------------------------------------------
vardef scan_bit(expr n,b)= if b>=1: odd(floor(n/b)) else: odd(floor((frac n)/b)) fi enddef;
%-------------------------------------------------------------------------------------------------
vardef scan_char(expr c,s,d,n)=
  nN:=0;
  if d=0:  for i=n upto length(s):   if subc(i,s)=c:  nN:=i; fi exitif nN>0; endfor
  ef d=1:  for i=n upto length(s):   if subc(i,s)<>c: nN:=i; fi exitif nN>0; endfor
  ef d=-1: for i=length(s) downto n: if subc(i,s)<>c: nN:=i; fi exitif nN>0; endfor
  fi
  nN
enddef;
%-------------------------------------------------------------------------------------------------
def scan_c(expr c,s)= scan_char(c,s,0,1) enddef;
%-------------------------------------------------------------------------------------------------
vardef split_str(expr s,c)(suffix v)=
  at_char[0]:=nN:=0; for i=1 upto length(s): if subc(i,s)=c: at_char[incr nN]:=i; fi endfor
  nN:=nN+1; at_char[nN]:=length(s)+1;
  for i=1 upto nN: v[i]:=substring (at_char[i-1],at_char[i]-1) of s; endfor
  nN
enddef;
%-------------------------------------------------------------------------------------------------
vardef get_tag_var(expr s)(suffix t,v)=
  nN:=scan_c(":",s); t:=substring(0,nN-1) of s; v:=substring(nN,length(s)) of s;
enddef;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
