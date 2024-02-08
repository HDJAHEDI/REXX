//REXXCEX2 JOB (TSOXA13),'TSOXA13',CLASS=A,MSGCLASS=Q,
//         NOTIFY=TSOXA13,REGION=0M,MSGLEVEL=1
//*------------------------------------------------------------------*//
//*
//*       -DOC- TSOXA13     12 JAN 2024     10:39:00
//*       -LIB- TSOXA13.ES52.REXXJCL(REXXCEX2)
//*
//*       -PURPOSE -_____________________________________
//*             _________________________________________
//*             _________________________________________
//*
//*------------------------------------------------------------------*//
//*
//*
//*  EXECUTE IN BATCH A COMPILED REXX (CEXEC)  SAYHELO1
//*
//*------------------------------------------------------------------*//
//STEP02  EXEC PGM=IKJEFT01
//SYSPROC   DD DSN=TSOXA13.ES52.REXXLIB,DISP=SHR
//SYSTSPRT  DD SYSOUT=*
//SYSTSIN   DD *
EX 'TSOXA13.ES52.REXCEXEC(SAYHELO1)'
/*
