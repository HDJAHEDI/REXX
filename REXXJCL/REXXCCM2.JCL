//REXXCCM2 JOB (TSOXA13),'TSOXA13',CLASS=A,MSGCLASS=Q,                  00001006
//         NOTIFY=TSOXA13,REGION=0M,MSGLEVEL=1                          00001106
//      JCLLIB ORDER=TSOXA13.ES52.REXXJCL                               00001206
//*------------------------------------------------------------------*//00001306
//*       -DOC- TSOXA13     12 Jan 2024     10:14:01                    00001406
//*       -LIB- TSOXA13.ES52.REXXJCL(REXXCCM1)                          00001506
//*------------------------------------------------------------------*//00001606
//*                                                                     00001706
//*       -PURPOSE -compile rexx exec SAYHELLO then execute with        00001806
//*             REXXCEX1_________________________________               00001906
//*             output is in a CEXEC library_____________               00002006
//*                                                                     00002106
//*------------------------------------------------------------------*//00002206
//*        COMPILE REXX                                                 00002306
//*------------------------------------------------------------------*//00002406
//COMPILE EXEC REXXC,COMPDSN=REXX.SFANLMD,                              00002506
//             OPTIONS='XREF OBJECT'                                    00002606
//SYSCEXEC  DD DISP=SHR,DSN=TSOXA13.ES52.REXCEXEC(SAYHELO1)             00002706
//SYSPUNCH  DD DISP=SHR,DSN=TSOXA13.ES52.REXXOBJ(SAYHELO1)              00002806
//SYSIN     DD DISP=SHR,DSN=TSOXA13.ES52.REXXLIB(SAYHELO1)              00002906
