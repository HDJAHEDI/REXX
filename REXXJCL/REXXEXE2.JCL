//*                                                                     00001300
//*------------------------------------------------------------------*//00001400
//* purpose                                                             00001500
//*  Execute a source rexx program (not compiled): SAYHELO1             00001600
//*  with IRXJCL                                                        00001800
//*------------------------------------------------------------------*//00002300
//ZT000        EXEC PGM=IRXJCL,PARM='SAYHELO1'                          00002400
//SYSEXEC      DD DISP=SHR,DSN=TSOCH££.REXXLIB                          00002600
//SYSTSPRT     DD SYSOUT=*                                              00002700
//SYSPRINT     DD SYSOUT=*                                              00002800
//SYSTSIN      DD DUMMY                                                 00002900
//*  end of job                                                         00003000
//****************************************************                  00003100
//                                                                      00003200
  or use //SYSTSIN as shown below                                       00003300
//SYSTSIN      DD *                                                     00003400
 SAYHELO1                                                               00003501
//*------------------------------------------------------------------*//00004000
