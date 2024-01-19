//*------------------------------------------------------------------*//
//* PROCEDURE TO COMPLILE/LINK AND CATALOG A REXX PROGRAM            *//
//*                                                                  *//
//*------------------------------------------------------------------*//
//ZREXXCL PROC OPTIONS='XREF OBJECT NOCEXEC TESTHALT',
//             COMPDSN='REXX.SFANLMD',
//             LIB0DSN='REXX.SEAGLMD',
//             LIBXDSN='REXX.SEAGCMD',PGR=,STUB=MVS
//*------------------------------------------------------------------*//
//* STEP TO COMPILE A REXX PROGRAM
//*------------------------------------------------------------------*//
//REXX    EXEC PGM=REXXCOMP,PARM='&OPTIONS'
//STEPLIB   DD DISP=SHR,DSN=&COMPDSN
//SYSPRINT  DD SYSOUT=*
//SYSTERM   DD SYSOUT=*
//SYSIN     DD DSN=TSOXA13.ES52.REXXLIB(&PGR),DISP=SHR
//SYSPUNCH  DD DSN=TSOXA13.ES52.REXXOBJ(&PGR),DISP=SHR
//*------------------------------------------------------------------*//
//* PREPARE SYSLIN FOR THE CATALOG STEP
//*------------------------------------------------------------------*//
//PLKED   EXEC PGM=IRXJCL,PARM='REXXL &STUB',
//             COND=(9,LT,REXX)
//SYSEXEC   DD DSN=&LIBXDSN,DISP=SHR
//SYSIN     DD DSN=TSOXA13.ES52.REXXOBJ(&PGR),DISP=SHR
//SYSTSPRT  DD SYSOUT=*
//SYSOUT    DD DSN=TSOXA13.ES52.REXXOUT(&PGR),DISP=SHR
//*------------------------------------------------------------------*//
//* STEP TO CATALOG THE REXX PROGRAM
//*------------------------------------------------------------------*//
//LKED    EXEC PGM=HEWL,PARM='LIST,AMODE=31,RMODE=ANY,RENT,MAP',
//             COND=((9,LT,REXX),(0,NE,PLKED))
//SYSLIN    DD DSN=TSOXA13.ES52.REXXOUT(&PGR),DISP=SHR
//SYSLIB    DD DISP=SHR,DSN=&LIB0DSN
//SYSUT1    DD UNIT=SYSALLDA,SPACE=(1024,(200,20))
//SYSPRINT  DD SYSOUT=*
//SYSLMOD   DD DSNAME=TSOXA13.ES52.REXXMOD(&PGR),DISP=SHR
//*------------------------------------------------------------------*//
//        PEND
