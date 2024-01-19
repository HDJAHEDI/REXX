//JCL2     JOB (00000001),MSGCLASS=Q,NOTIFY=TSOXA13
//*  Output class Q is the HELD output class                            00020000
//*  Need help - sample JCL is in the REXX User's Guide                 00030000
//REXXLAB EXEC PGM=IRXJCL,PARM='REXXTRY'                                00040000
//SYSEXEC   DD DISP=SHR,DSN=TSOXA13.ES52.EXEC                           00060000
//          DD DISP=SHR,DSN=D80WW.ES52V5.RESOURCE.EXEC                  00060000
//SYSTSPRT  DD SYSOUT=*                                                 00050000
//SYSPRINT  DD SYSOUT=*                                                 00050000
//INPUTDD   DD DATA,DLM=$$                                              00080000
INPUTDD LINE_1
INPUTDD LINE_2
INPUTDD LINE_3
INPUTDD LINE_4
$$
//SYSTSIN   DD DATA,DLM=$$                                              00080000
MATH3
39 84
297 643
EXIT
ADDRESS MVS "EXECIO * DISKR INPUTDD (STEM REC. FINIS)";
DO  I = 1 TO REC.0; SAY REC.I; END I;
EXIT;
$$
/*
