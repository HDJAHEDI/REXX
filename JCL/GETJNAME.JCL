//GETJNAME JOB (00000001),MSGCLASS=T,NOTIFY=&SYSUID
//*  Output class Q is the HELD output class                            00020000
//*  Need help - sample JCL is in the REXX User's Guide                 00030000
//REXXLAB EXEC PGM=IKJEFT01,                                            00040000
//             PARM='GETJNAME'                                          00051000
//SYSTSPRT  DD SYSOUT=*                                                 00050000
//SYSEXEC   DD DISP=SHR,DSN=Z00958.PROJ0000.REXX                        00060000
//SYSTSIN   DD DUMMY                                                    00080000
/*
