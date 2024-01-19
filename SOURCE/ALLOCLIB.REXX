/* System REXX  */                                                      00001000
Parse Upper Arg hlq .                                                   00002000
If hlq = "" Then hlq = USERID() || '.ES52'                              00003001
Call OutTrap "TsoOutputLine.","*","NOCONCAT"                            00003101
"FREE FI(LIB,JCL,OBJ,OUT,MOD,CEXEC)"                                    00004001
Call OutTrap "OFF"                                                      00005001
Do                                                                      00010000
  rexxjcl = "'"||hlq||".REXXJCL'"                                       00020001
  If SYSDSN(rexxjcl) = "OK" Then Nop                                    00030001
  Else                                                                  00070000
    Do                                                                  00080000
      "ALLOC  FI(JCL) DA("||rexxjcl||") SP(15,15) dir(15) TRACKS " ,    00090001
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00100000
      "UNIT(SYSALLDA)"                                                  00110000
    say 'rc for ' rexxjcl 'allocation is ' rc                           00111001
    End                                                                 00120000
End                                                                     00130000
                                                                        00140000
Do                                                                      00141001
  rexxlib = "'"||hlq||".REXXLIB'"                                       00142001
  If SYSDSN(rexxlib) = "OK" Then Nop                                    00143001
  Else                                                                  00144001
    Do                                                                  00145001
      "ALLOC  FI(LIB) DA("||rexxlib||") SP(15,15) dir(15) TRACKS " ,    00146001
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00147001
      "UNIT(SYSALLDA)"                                                  00148001
    say 'rc for ' rexxlib 'allocation is ' rc                           00149001
    End                                                                 00149101
End                                                                     00149201
                                                                        00149301
Do                                                                      00150000
  rexcexec = "'"||hlq||".REXCEXEC'"                                     00160001
  If SYSDSN(rexcexec) = "OK" Then Nop                                   00170001
  Else                                                                  00180000
    Do                                                                  00190000
      "ALLOC  FI(CEXEC) DA("||rexcexec||") SP(15,15) dir(15) TRACKS " , 00200001
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00210000
      "UNIT(SYSALLDA)"                                                  00220000
    say 'rc for ' rexcexec 'allocation is ' rc                          00221001
    End                                                                 00230000
End                                                                     00240000
                                                                        00250000
Do                                                                      00260000
  rexxobj = "'"||hlq||".REXXOBJ'"                                       00270000
  If SYSDSN(rexxobj) = "OK" Then Nop                                    00280000
  Else                                                                  00290000
    Do                                                                  00300000
      "ALLOC  FI(OBJ) DA("||rexxobj||") SP(15,15) dir(15) TRACKS " ,    00310000
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00320000
      "UNIT(SYSALLDA)"                                                  00330000
    say 'rc for ' rexxobj 'allocation is ' rc                           00331001
    End                                                                 00340000
End                                                                     00350000
                                                                        00360000
Do                                                                      00370000
  rexxout = "'"||hlq||".REXXOUT'"                                       00380000
  If SYSDSN(rexxout) = "OK" Then Nop                                    00390000
  Else                                                                  00400000
    Do                                                                  00410000
      "ALLOC  FI(OUT) DA("||rexxout||") SP(15,15) dir(15) TRACKS " ,    00420000
      "DSORG(PO) RECFM(F,B) LRECL(80) BLKSIZE(3120) NEW CATALOG" ,      00430000
      "UNIT(SYSALLDA)"                                                  00440000
    say 'rc for ' rexxout 'allocation is ' rc                           00441001
    End                                                                 00450000
End                                                                     00460000
                                                                        00470000
Do                                                                      00480000
  rexxmod = "'"||hlq||".REXXMOD'"                                       00490000
  If SYSDSN(rexxmod) = "OK" Then Nop                                    00500000
  Else                                                                  00510000
    Do                                                                  00520000
      "ALLOC  FI(MOD) DA("||rexxmod||") SP(30,30) dir(15) TRACKS " ,    00530000
      "DSORG(PO) RECFM(U) LRECL(0) BLKSIZE(0) NEW CATALOG" ,            00540000
      "UNIT(SYSALLDA)"                                                  00550000
    say 'rc for ' rexxmod 'allocation is ' rc                           00551001
    End                                                                 00560000
End                                                                     00570000
 "LISTC ENT('"hlq".*')"                                                 00571001
Call OutTrap "TsoOutputLine.","*","NOCONCAT"                            00572001
"FREE FI(LIB,JCL,OBJ,OUT,MOD,CEXEC)"                                    00573001
Call OutTrap "OFF"                                                      00574001
exit                                                                    00580000
