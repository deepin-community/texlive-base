.PS
# AutoLogixMan.m4
log_init

  F: Autologix(Or(And(a,b,c,d),And(Not(b),a),c,And(d,Not(a))))
  Loopover_(`v',`"$v$" at F.In`'v above',a,b,c,d)
  "$f$" at F.Out ljust

.PE
