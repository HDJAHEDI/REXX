/* System REXX  */                                                      00001000
Parse Upper Arg hlq .                                                   00002000
                                                                        00002100
If hlq = "" Then hlq = USERID() || '.PROJ0000'                          00003000
Call OutTrap "TsoOutputLine.","*","NOCONCAT"                            00003100
"FREE FI(LIB,JCL,OBJ,OUT,MOD,CEXEC)"                                    00004000
Call OutTrap "OFF"                                                      00005000
/*--------------------------------------------------------------------*/00006000
                                                                        00007000
Do                                                                      00010000
  jcl = "'"||hlq||".JCL'"                                               00020000
  If SYSDSN(jcl) = "OK" Then Nop                                        00030000
  Else                                                                  00070000
    Do                                                                  00080000
      "ALLOC  FI(JCL) DA("||jcl||") SP(15,15) dir(15) TRACKS " ,        00090000
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00100000
      "UNIT(SYSALLDA)"                                                  00110000
    say 'rc for ' jcl 'allocation is ' rc                               00111000
    End                                                                 00120000
End                                                                     00130000
/*--------------------------------------------------------------------*/00130100
                                                                        00130200
Do                                                                      00131000
  rexxjcl = "'"||hlq||".REXXJCL'"                                       00132000
  If SYSDSN(rexxjcl) = "OK" Then Nop                                    00133000
  Else                                                                  00134000
    Do                                                                  00135000
      "ALLOC  FI(JCL) DA("||rexxjcl||") SP(15,15) dir(15) TRACKS " ,    00136000
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00137000
      "UNIT(SYSALLDA)"                                                  00138000
    say 'rc for ' rexxjcl 'allocation is ' rc                           00139000
    End                                                                 00139100
End                                                                     00139200
/*--------------------------------------------------------------------*/00139300
                                                                        00140000
Do                                                                      00141000
  rexxlib = "'"||hlq||".REXXLIB'"                                       00142000
  If SYSDSN(rexxlib) = "OK" Then Nop                                    00143000
  Else                                                                  00144000
    Do                                                                  00145000
      "ALLOC  FI(LIB) DA("||rexxlib||") SP(15,15) dir(15) TRACKS " ,    00146000
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00147000
      "UNIT(SYSALLDA)"                                                  00148000
    say 'rc for ' rexxlib 'allocation is ' rc                           00149000
    End                                                                 00149100
End                                                                     00149200
/*--------------------------------------------------------------------*/00149300
                                                                        00149400
Do                                                                      00150000
  rexcexec = "'"||hlq||".REXCEXEC'"                                     00160000
  If SYSDSN(rexcexec) = "OK" Then Nop                                   00170000
  Else                                                                  00180000
    Do                                                                  00190000
      "ALLOC  FI(CEXEC) DA("||rexcexec||") SP(15,15) dir(15) TRACKS " , 00200000
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00210000
      "UNIT(SYSALLDA)"                                                  00220000
    say 'rc for ' rexcexec 'allocation is ' rc                          00221000
    End                                                                 00230000
End                                                                     00240000
/*--------------------------------------------------------------------*/00241000
                                                                        00250000
Do                                                                      00260000
  rexxobj = "'"||hlq||".REXXOBJ'"                                       00270000
  If SYSDSN(rexxobj) = "OK" Then Nop                                    00280000
  Else                                                                  00290000
    Do                                                                  00300000
      "ALLOC  FI(OBJ) DA("||rexxobj||") SP(15,15) dir(15) TRACKS " ,    00310000
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00320000
      "UNIT(SYSALLDA)"                                                  00330000
    say 'rc for ' rexxobj 'allocation is ' rc                           00331000
    End                                                                 00340000
End                                                                     00350000
/*--------------------------------------------------------------------*/00351000
                                                                        00360000
Do                                                                      00370000
  rexxout = "'"||hlq||".REXXOUT'"                                       00380000
  If SYSDSN(rexxout) = "OK" Then Nop                                    00390000
  Else                                                                  00400000
    Do                                                                  00410000
      "ALLOC  FI(OUT) DA("||rexxout||") SP(15,15) dir(15) TRACKS " ,    00420000
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00430000
      "UNIT(SYSALLDA)"                                                  00440000
    say 'rc for ' rexxout 'allocation is ' rc                           00441000
    End                                                                 00450000
End                                                                     00460000
/*--------------------------------------------------------------------*/00461000
                                                                        00470000
Do                                                                      00480000
  rexxmod = "'"||hlq||".REXXMOD'"                                       00490000
  If SYSDSN(rexxmod) = "OK" Then Nop                                    00500000
  Else                                                                  00510000
    Do                                                                  00520000
      "ALLOC  FI(MOD) DA("||rexxmod||") SP(30,30) dir(15) TRACKS " ,    00530000
      "DSORG(PO) RECFM(U) LRECL(0) BLKSIZE(0) NEW CATALOG" ,            00540000
      "UNIT(SYSALLDA)"                                                  00550000
    say 'rc for ' rexxmod 'allocation is ' rc                           00551000
    End                                                                 00560000
End                                                                     00570000
/*--------------------------------------------------------------------*/00570100
                                                                        00570200
 "LISTC ENT('"hlq".*')"                                                 00571000
Call OutTrap "TsoOutputLine.","*","NOCONCAT"                            00572000
"FREE FI(LIB,JCL,OBJ,OUT,MOD,CEXEC)"                                    00573000
Call OutTrap "OFF"                                                      00574000
exit                                                                    00580000
