//*                                                                     00001300
//*------------------------------------------------------------------*//00001400
//* purpose                                                             00001503
//*  Execute a source rexx program (not compiled) : SAYHELLO            00001603
//* with IRXJCL                                                         00001800
//*------------------------------------------------------------------*//00002300
//ZT000        EXEC PGM=IRXJCL,PARM='SAYHELLO'                          00002408
//SYSEXEC      DD DISP=SHR,DSN=TSOCH££.REXXLIB                          00002605
//SYSTSPRT     DD SYSOUT=*                                              00002700
//SYSPRINT     DD SYSOUT=*                                              00002800
//SYSTSIN      DD DUMMY                                                 00002901
//*  end of job                                                         00003006
//****************************************************                  00003103
//                                                                      00003206
  or use //SYSTSIN as shown below                                       00003303
//SYSTSIN      DD *                                                     00003400
 SAYHELLO                                                               00003500
//*------------------------------------------------------------------*//00004000
