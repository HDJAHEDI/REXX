//XREXXCL2 JOB (TSOXA13),'TSOXA13',CLASS=A,MSGCLASS=Q,                  00000104
//         NOTIFY=TSOXA13,REGION=0M,MSGLEVEL=1                          00000204
//JOBLIB    DD DISP=SHR,DSN=TSOXA13.ES52.REXXMOD                        00000304
//          DD DISP=SHR,DSN=REXX.SEAGLPA                                00000404
//*------------------------------------------------------------------*//00000504
//*                                                                     00000604
//*       -DOC- TSOXA13     12 Jan 2024     13:18:29                    00000704
//*       -LIB- TSOXA13.ES52.REXXJCL(XREXXCL2)                          00000804
//*------------------------------------------------------------------*//00002004
//*                                                                  *  00004000
//*                                                                  *  00006000
//* purpose                                                          *  00007000
//*  . Execute a rexx program compiled/linked (cataloged): SAYHELO1  *  00008000
//*                                                                  *  00020000
//*------------------------------------------------------------------*//00021004
//ZT000   EXEC PGM=SAYHELO1                                             00070004
//SYSTSPRT  DD SYSOUT=*                                                 00080004
//SYSPRINT  DD SYSOUT=*                                                 00081004
//SYSTERM   DD SYSOUT=*                                                 00082004
//*------------------------------------------------------------------*  00090000
