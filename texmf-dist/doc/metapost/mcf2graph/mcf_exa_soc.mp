%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MCF metapost souce file example                 by Akira Yamaji  2024.01.21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if unknown mcftograph: input mcf2graph; fi  %%% it must be version 5.11
message "* mcf_template 2024.01.21";
message "";
%------------------------------------------------------------------------------
fsize:=(30mm,20mm);
max_blength:=4mm;
%%%%sw_output:=Fig+Info;
%%%%sw_output:=Fig+Calc;
%%%%ext(defaultscale:=.3; label.rt(EN,(0,0));)
%------------------------------------------------------------------------------
%%%%ext(defaultfont:=mpfont; defaultscale:=.3;
%%%%label.rt(EN&" / "&mw&" / "&fdr(7)(MW_n-scantokens(MW)),(0,0));)
%------------------------------------------------------------------------------
%%%%loadm("CAT=biological","MW<200","a:MW");
%%%%loadm("CAT=biological","MW<50.0","a:EN");
%%%%loadm("CAT=biological","MW>=285","MW<=288","a:EN");
%%%%sw_comment:=1; loadm("CAT=biological","MW>=100","MW<=250","a:MW");
%%%%savem("temp.mcf");                    % save to temp.mcf
%%%%loadm("EN<>*");                       % select all
loadm("EXA=1");                           % select EXA=1
%------------------------------------------------------------------------------
for i=1 upto ucount:  beginfigm $(i) \\ endfigm  endfor
%******************************************************************************
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bye
