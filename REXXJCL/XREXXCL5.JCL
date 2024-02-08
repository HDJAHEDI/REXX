//*------------------------------------------------------------------*//00001509
//* purpose                                                             00001609
//*  Execute a compiled rexx load module program                        00001709
//*  use STEPLIB                                                        00001804
//*  Execute a rexx program complied and linked (cataloged) SAYHELLO    00001804
//*   with IKJEFT01 + STEPLIB + SYSTSIN                                 00001804
//*------------------------------------------------------------------*//00002301
//ZT000        EXEC PGM=IKJEFT01,DYNAMNBR=20                            00002608
//STEPLIB      DD DISP=SHR,DSN=TSOCH££.REXXMOD                          00002708
//SYSTSPRT     DD SYSOUT=*                                              00002808
//SYSPRINT     DD SYSOUT=*                                              00002908
//SYSTSIN      DD *                                                     00003108
 SAYHELO1                                                               00003211
//*------------------------------------------------------------------*//00004002
//                                                                      00005009
 SAYHELLO                                                               00006011
