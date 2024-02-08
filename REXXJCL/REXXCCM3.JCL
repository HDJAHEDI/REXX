//*                                                                     00001200
//*       -PURPOSE -compile rexx exec                                   00001300
//*             output is in a CEXEC library_____________               00001500
//*                                                                     00002000
//*****************************************************************     00010000
//***            COMPILE REXX                                           00020000
//*****************************************************************     00030000
//   JCLLIB ORDER=TSOCH££.REXXJCL                                       00031000
//S1 EXEC REXXC,COMPDSN=REXX.SFANLMD,                                   00040000
//   OPTIONS='XREF OBJECT SLINE ALT COND'                               00041000
//REXX.SYSCEXEC DD DSN=TSOCH££.REXCEXEC(TEST3),DISP=SHR                 00050002
//REXX.SYSPUNCH DD DSN=TSOCH££.REXXOBJ(TEST3),DISP=SHR                  00060002
//REXX.SYSIN    DD DSN=TSOCH££.REXXLIB(TEST3),DISP=SHR                  00070002
