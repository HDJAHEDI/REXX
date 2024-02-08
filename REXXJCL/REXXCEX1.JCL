//REXXCEX1 JOB (TSOXA13),'TSOXA13',CLASS=A,MSGCLASS=Q,
//         NOTIFY=TSOXA13,REGION=0M,MSGLEVEL=1
//*------------------------------------------------------------------*//
//*
//*       -DOC- TSOXA13     12 JAN 2024     10:33:28
//*       -LIB- TSOXA13.ES52.REXXJCL(REXXCEX1)
//*
//*       -PURPOSE -_____________________________________
//*             _________________________________________
//*             _________________________________________
//*
//*------------------------------------------------------------------*//
//*
//*
//*  EXECUTE IN BATCH A COMPILED REXX (CEXEC)  SAYHELLO
//*
//*------------------------------------------------------------------*//
//STEP02 EXEC PGM=IKJEFT01
//SYSPROC  DD DSN=TSOXA13.ES52.REXXLIB,DISP=SHR
//SYSTSPRT DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSTSIN  DD *
EX 'TSOXA13.ES52.REXCEXEC(SAYHELLO)'
/*
