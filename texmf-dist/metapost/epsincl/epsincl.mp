%%% addto closefrom readfrom
% made in BOP s.c., bop@bop.com.pl; public domain software
% history: 20.08.1999: ver. 0.1, pre-release
%          05.01.2000: ver. 0.2, first release

def verify_operator primary x = x if not x: expandafter gobble fi enddef;

if not verify_operator known closefrom "????????": % tricky, isn't it
% |closefrom| primitive is available in MP since ver. 0.64
 def closefrom expr eps_name =
  forever: exitif (readfrom eps_name)=EOF; endfor
 enddef;
fi

% The structure |eps_data| is presumed to be local for a given figure.
% If the same outer picture is to be included in several figures, its
% header must be examined each time anew. This is necassary if we want
% to include EPS files generated by METAPOST; otherwise we would have
% to store the information about the fonts used in EPS files being
% included. Note that the possibility of multiple reading necessitates
% using the |closefrom| operator.

def ini_eps =
% The common construction |save eps_data| must not be used,
% because of implicit reference to |ini_eps| in |use_eps|.
 numeric eps_data.used[\\];
 string eps_data.name[\\];
 pair eps_data.ll[\\], eps_data.ur[\\];
 color eps_data.col[\\];
 eps_data.num:=0; eps_data.col[eps_data.num]=(0, 1, .5);
enddef;

vardef fix_eps(expr eps_name) =
 save i_, j_, k_, l_, n_;
 i_:=0;
 forever:
  i_:=i_+1; exitif i_>eps_data.num; exitif eps_data.name[i_]=eps_name;
 endfor
 if i_<=eps_data.num: errmessage "EPS " & eps_name & " already fixed";
 else:
  forever:
   string l_; % this improves string memory handling (why?)
   l_:=readfrom eps_name; exitif l_=EOF;
   if substring (0,14) of l_="%%BoundingBox:":
     j_:=14;
     for k_=1,2,3,4:
       i_:=j_;
       forever: % scan spaces
         exitif (substring (i_,i_+1) of l_) <> " "; i_:=i_+1;
       endfor
       j_:=i_;
       forever: % scan digits
         exitif ((substring (j_,j_+1) of l_) = " ")
          or ((substring (j_,j_+1) of l_) = "");
         j_:=j_+1;
       endfor
       n_[k_]:=scantokens substring (i_,j_) of l_;
     endfor;
   elseif substring (0,7) of l_="%*Font:": special l_;
   elseif substring (0,1) of l_<>"%":
     expandafter exitif expandafter true expandafter; % avoid ``dangling'' fi
   fi
  endfor
  eps_data.num:=eps_data.num+1;
  eps_data.name[eps_data.num]:=eps_name;
  if l_=EOF:
   eps_data.used[eps_data.num]:=-1;
   message "EPS file " & eps_name & " malformed or not found.";
  else:
   eps_data.used[eps_data.num]:=0;
   eps_data.ll[eps_data.num]:=(n_1, n_2);
   eps_data.ur[eps_data.num]:=(n_3, n_4);
   eps_data.col[eps_data.num]:=eps_data.col0+1/1000eps_data.num*(1, -1,0);
  fi
  closefrom eps_name;
 fi
enddef;

vardef use_eps(expr eps_name) =
 if unknown eps_data.num: ini_eps; fi
 save currentpicture; picture currentpicture; currentpicture:=nullpicture;
 save i_; i_:=0;
 forever:
  i_:=i_+1;
  exitif i_>eps_data.num;
  exitif eps_data.name[i_]=eps_name;
 endfor
 if i_>eps_data.num: fix_eps(eps_name); fi
 % invariant: |(eps_data.name[i_]=eps_name) && known eps_data.used[i_]|
 if eps_data.used[i_]>=0: % fixing was successful
  fill unitsquare
   xscaled xpart(eps_data.ur[i_]-eps_data.ll[i_])
   yscaled ypart(eps_data.ur[i_]-eps_data.ll[i_])
   withcolor eps_data.col[i_];
  if eps_data.used[i_]=0:
   special "%EPS " 
    & decimal(redpart(eps_data.col[i_])) & " "
    & decimal(greenpart(eps_data.col[i_])) & " "
    & decimal(bluepart(eps_data.col[i_])) & " "
    & eps_name & " "
    & decimal(xpart(eps_data.ll[i_])) & " "
    & decimal(ypart(eps_data.ll[i_])) & " "
    & decimal(xpart(eps_data.ur[i_])) & " "
    & decimal(ypart(eps_data.ur[i_]));
   eps_data.used[i_]:=1;
  fi
  currentpicture
 else: % fixing failed (either missing file or bounding box not found)
  nullpicture
 fi
enddef;

extra_beginfig:=extra_beginfig & ";ini_eps;";

endinput;
%%\end
