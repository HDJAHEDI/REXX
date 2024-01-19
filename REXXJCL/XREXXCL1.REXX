//XREXXCL1 JOB (TSOXA13),'TSOXA13',CLASS=A,MSGCLASS=Q,                  00000114
//         NOTIFY=TSOXA13,REGION=0M,MSGLEVEL=1                          00000214
//JOBLIB    DD DISP=SHR,DSN=TSOXA13.ES52.REXXMOD                        00000314
//          DD DISP=SHR,DSN=REXX.SEAGLPA                                00000414
//*------------------------------------------------------------------*//00000514
//*                                                                     00000614
//*       -DOC- TSOXA13     12 Jan 2024     13:13:34                    00000714
//*       -LIB- TSOXA13.ES52.REXXJCL(XREXXCL1)                          00000814
//*------------------------------------------------------------------*//00002014
//* purpose                                                          *//00007014
//*  . Execute a rexx program compiled/linked (cataloged): SAYHELLO  *//00008014
//*                                                                  *//00020014
//*------------------------------------------------------------------*//00021014
//ZT000   EXEC PGM=SAYHELLO                                             00070013
//SYSTSPRT  DD SYSOUT=*                                                 00080013
//SYSPRINT  DD SYSOUT=*                                                 00081013
//*------------------------------------------------------------------*//00090014
