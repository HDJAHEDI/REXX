//******************************************************************
//*
//* REXXC   Compile a REXX program.
//*
//*    Licensed Materials - Property of IBM
//*    5695-013 IBM REXX Compiler
//*    (C) Copyright IBM Corp. 1989, 2003
//*
//* Change Activity:
//*   03-05-28       Release 4.0
//*
//******************************************************************
//*
//* Parameters:
//*
//*   OPTIONS     Compilation options.
//*               Default: XREF OBJECT
//*
//*   COMPDSN     DSN of IBM REXX Compiler load library.
//*
//* Required:
//*
//*   REXX.SYSIN  DDNAME, REXX program to be compiled.
//*
//* Example:
//*
//*   To compile MYREXX.EXEC(MYPROG) and to keep the resulting
//*   CEXEC output and OBJECT output in MYREXX.CEXEC(MYPROG) and
//*   MYREXX.OBJ(MYPROG), respectively, use the following
//*   invocation:
//*
//*   //S1 EXEC REXXC
//*   //REXX.SYSCEXEC DD DSN=MYREXX.CEXEC(MYPROG),DISP=SHR
//*   //REXX.SYSPUNCH DD DSN=MYREXX.OBJ(MYPROG),DISP=SHR
//*   //REXX.SYSIN    DD DSN=MYREXX.EXEC(MYPROG),DISP=SHR
//*
//* Modifications:
//*   Change #HLQREXX to the appropriate high-level qualifier of
//*   your installation.
//*
//******************************************************************
//*
//REXXC   PROC OPTIONS='XREF OBJECT',         REXX Compiler options
//             COMPDSN='#HLQREXX.SFANLMD'     REXX Compiler load lib
//*
//*-----------------------------------------------------------------
//* Compile REXX program.
//*-----------------------------------------------------------------
//*
//REXX    EXEC PGM=REXXCOMP,PARM='&OPTIONS'
//STEPLIB   DD DSN=&COMPDSN,DISP=SHR
//SYSPRINT  DD SYSOUT=*
//SYSTERM   DD SYSOUT=*
//*SYSIEXEC DD DUMMY
//*SYSDUMP  DD DUMMY
//SYSCEXEC  DD DSN=&&CEXEC(GO),DISP=(MOD,PASS),UNIT=SYSALLDA,
//             SPACE=(800,(800,100,1))
//SYSPUNCH  DD DSN=&&OBJECT,DISP=(MOD,PASS),UNIT=SYSALLDA,
//             SPACE=(800,(800,100))
