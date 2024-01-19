/* Rexx */
tcb     = C2x(Storage(21C,4))
tcbsenv = D2x(X2d(tcb) + X2d(154))
acee    = C2x(Bitand(Storage(tcbsenv,4),'7fffffff'x))
If acee = '00000000' Then Do
  ascb     = C2x(Storage(224,4))
  ascbasxb = D2x(X2d(ascb) + X2d(6c))
  asxb     = C2x(Storage(ascbasxb,4))
  asxbsenv = D2x(X2d(asxb) + X2d(c8))
  acee     = C2x(Bitand(Storage(asxbsenv,4), '7fffffff'x))
  End
If Storage(acee,4) <> 'ACEE' Then Do
  Say 'Error locating ACEE|'
  Return
  End
  aceeunam  = D2x(X2d(acee) + X2d(64))
  unam      = C2x(Storage(aceeunam,4))
  namelen   = C2d(Storage(unam,1))
  name      = Substr(Storage(unam,namelen+1),2)
  Say 'Name' name
  Return
