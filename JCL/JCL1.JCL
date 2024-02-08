//JCL1     JOB (00000001),MSGCLASS=Q,NOTIFY=TSOXA13
//*  Output class Q is the HELD output class                            00020000
//*  Need help - sample JCL is in the REXX User's Guide                 00030000
//REXXLAB EXEC PGM=IKJEFT01,                                            00040000
//             PARM='REXXTRY'                                           00051000
//SYSTSPRT  DD SYSOUT=*                                                 00050000
//SYSEXEC   DD DISP=SHR,DSN=TSOXA13.ES52.EXEC                           00060000
//          DD DISP=SHR,DSN=D80WW.ES52V5.RESOURCE.EXEC                  00060000
//SYSTSIN   DD DATA,DLM=$$                                              00080000
SAY "HELLO WORLD!"
SAY  HELLO WORLD
MATH3 25 14
12 73
EXIT
LISTALC STATUS
QSTACK
SAY RC
$$
/*
