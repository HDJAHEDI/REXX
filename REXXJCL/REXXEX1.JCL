//TSOXA13Q JOB (TSOXA13),'TSOXA13',CLASS=A,MSGCLASS=Q,
//         NOTIFY=TSOXA13,REGION=0M,MSGLEVEL=1
//*------------------------------------------------------------------*//
//*
//*       -DOC- TSOXA13     12 Jan 2024     09:35:39
//*       -LIB- TSOXA13.ES52.REXXJCL(REXXEX1)
//*
//*       -PURPOSE -_____________________________________
//*             _________________________________________
//*             _________________________________________
//*
//*------------------------------------------------------------------*//
//* purpose                                                             00001600
//*  Execute a source rexx program (not compiled): SAYHELLO             00001700
//* with IKJEFT01                                                       00001800
//*------------------------------------------------------------------*//00002300
//ZT000   EXEC PGM=IKJEFT01,PARM='SAYHELLO'                             00002401
//SYSEXEC   DD DISP=SHR,DSN=TSOXA13.ES52.REXXLIB                        00002600
//SYSTSPRT  DD SYSOUT=*                                                 00002700
//SYSPRINT  DD SYSOUT=*                                                 00002800
//SYSTSIN   DD DUMMY                                                    00002900
//*  end of job                                                         00003000
//*------------------------------------------------------------------*//00002300
