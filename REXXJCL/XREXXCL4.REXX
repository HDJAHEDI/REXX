//XREXXCL4 JOB (TSOXA13),'TSOXA13',CLASS=A,MSGCLASS=Q,                  00000103
//         NOTIFY=TSOXA13,REGION=0M,MSGLEVEL=1                          00000203
//*------------------------------------------------------------------*//00000303
//*                                                                     00000403
//*       -DOC- TSOXA13     12 Jan 2024     13:21:51                    00000503
//*       -LIB- TSOXA13.ES52.REXXJCL(XREXXCL4)                          00000603
//*------------------------------------------------------------------*//00002003
//*------------------------------------------------------------------*  00003000
//* PURPOSE                                                          *  00007000
//*  Execute a rexx program complied and linked (cataloged) SAYHELO1 *  00008000
//*   with IKJEFT01 + STEPLIB                                        *  00020000
//*------------------------------------------------------------------*  00030000
//*------------------------------------------------------------------*  00060000
//ZT000   EXEC PGM=IKJEFT01,PARM=SAYHELO1                               00070003
//STEPLIB   DD DISP=SHR,DSN=TSOXA13.ES52.REXXMOD                        00071003
//          DD DISP=SHR,DSN=REXX.SEAGLPA                                00072003
//SYSTSPRT  DD SYSOUT=*                                                 00080103
//SYSPRINT  DD SYSOUT=*                                                 00080203
//SYSTERM   DD SYSOUT=*                                                 00080303
//SYSTSIN   DD DUMMY                                                    00081003
//*------------------------------------------------------------------*  00090000
