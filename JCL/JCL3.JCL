//JCL3     JOB (00000001),MSGCLASS=Q,NOTIFY=TSOXA13
//*  Output class Q is the HELD output class                            00020000
//*  Need help - sample JCL is in the REXX User's Guide                 00030000
//REXXLAB EXEC PGM=IRXJCL,PARM=' '                                      00040000
//SYSTSPRT  DD SYSOUT=*                                                 00050000
//SYSPRINT  DD SYSOUT=*                                                 00050000
//SYSEXEC   DD DATA,DLM=$$                                              00080000
/* REXX */
SAY 'TEST INLINE IRXJCL';
EXIT;
$$
//SYSTSIN   DD DUMMY                                                    00080000
/*
