.PS
# https://tex.stackexchange.com/questions/593866/magnetic-field-with-2-coils
cct_init(SIdefaults)

  setdir_(R)
  W1: winding(,20,5,8,10)
  line dn_ 10 from W1.T1; dot(,,1)
  line dn_ 10 from W1.T2; dot(,,1)
  W2: winding(,20,5,8,10) with .w_ at W1.e_+vec_(10,0)
  line dn_ 10 from W2.T1; dot(,,1)
  line dn_ 10 from W2.T2; dot(,,1)
  for i=2 to -2 by -1 do {
    spline 0.55 \
         from W2.e_+vec_(30,10/4*i*3) \
           to W2.e_+vec_(25,10/4*i*2) \
      then to W2.e_+vec_(0,10/4*i) \
      then to W1.w_+vec_(0,10/4*i) \
      then to W1.w_+vec_(-25,10/4*i*2) \
      then to W1.w_+vec_(-30,10/4*i*3)
    arrow wid 2 ht 2 dn_ i*0.66 rt_ 2 at W1.w_+vec_(-25,10/4*i*2.35)
    arrow wid 2 ht 2 up__ i*0.66 rt_ 2 at W2.e_+vec_(25,10/4*i*2.35)
    }

.PE
