//REXXCCM1 JOB (TSOXA13),'TSOXA13',CLASS=A,MSGCLASS=Q,                  00000105
//         NOTIFY=TSOXA13,REGION=0M,MSGLEVEL=1                          00000205
//      JCLLIB ORDER=TSOXA13.ES52.REXXJCL                               00000305
//*------------------------------------------------------------------*//00000405
//*       -DOC- TSOXA13     12 Jan 2024     10:14:01                    00000605
//*       -LIB- TSOXA13.ES52.REXXJCL(REXXCCM1)                          00000705
//*------------------------------------------------------------------*//00001305
//*                                                                     00001400
//*       -PURPOSE -compile rexx exec SAYHELLO then execute with        00001500
//*             REXXCEX1_________________________________               00001600
//*             output is in a CEXEC library_____________               00001700
//*                                                                     00002000
//*------------------------------------------------------------------*//00003005
//*        COMPILE REXX                                                 00020005
//*------------------------------------------------------------------*//00021005
//COMPILE EXEC REXXC,COMPDSN=REXX.SFANLMD                               00040005
//SYSCEXEC  DD DISP=SHR,DSN=TSOXA13.ES52.REXCEXEC(SAYHELLO)             00050005
//SYSPUNCH  DD DISP=SHR,DSN=TSOXA13.ES52.REXXOBJ(SAYHELLO)              00060005
//SYSIN     DD DISP=SHR,DSN=TSOXA13.ES52.REXXLIB(SAYHELLO)              00070005
