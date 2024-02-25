/* REXX */
/* -------------------------------------------------------------------*/
SIGNAL  ON  ERROR   NAME SIGNAL_ERROR  ;
SIGNAL  ON  SYNTAX  NAME SIGNAL_SYNTAX ;
SIGNAL  ON  NOVALUE NAME SIGNAL_NOVALUE;
SIGNAL  ON  FAILURE NAME SIGNAL_FAILURE;
SIGNAL  ON  HALT    NAME SIGNAL_HALT   ;
PARSE   SOURCE     #OS  #CALL #NAME #SYSID #DSN #REST;
ADDRESS TSO "CALL 'Z00958.HLASM.LOAD(CLRSCR00)'";
SAY '++> [' || #NAME || '] MODULE STARTED.';
/* -------------------------------------------------------------------*/
/* ADD YOUR CODE HERE */
ADR_CVT  = STORAGE(                   10 ,4)
ADR_NOP  = STORAGE(D2X(C2D(ADR_CVT )    ),4)
ADR_ASCB = STORAGE(D2X(C2D(ADR_NOP )+  4),4)
ADR_JOBN = STORAGE(D2X(C2D(ADR_ASCB)+ 12),4)
JOBNAME  = STORAGE(D2X(C2D(ADR_JOBN)    ),8)
SAY '++> The CVT address is:             <' || C2X(ADR_CVT ) || '>';
SAY '++> The NEW/OLD Pointer address is: <' || C2X(ADR_NOP ) || '>';
SAY '++> The ASCB    Pointer address is: <' || C2X(ADR_ASCB) || '>';
SAY '++> The JOBN            address is: <' || C2X(ADR_JOBN) || '>';
SAY '++> The JOBNAME                 is: <' ||     JOBNAME   || '>';
CALL EXIT_0;
/* -------------------------------------------------------------------*/
EXIT_0:
/*
*/
SAY '++> [' || #NAME || '] MODULE NORMAL END.';
EXIT 0;
/* -------------------------------------------------------------------*/
SIGNAL_SYNTAX:
S_SG = SIGL;
S_RC = RC;
S_CI = CONDITION('I');
S_CC = CONDITION('C');
S_CD = CONDITION('D');
S_CS = CONDITION('S');
SIGNAL OFF SYNTAX;
SAY '!!> Syntax  Exception trapped. ';
CALL EXIT_X 100,S_SG,S_RC,S_CI,S_CC,S_CD,S_CS
/* -------------------------------------------------------------------*/
SIGNAL_ERROR:
S_SG = SIGL;
S_RC = RC;
S_CI = CONDITION('I');
S_CC = CONDITION('C');
S_CD = CONDITION('D');
S_CS = CONDITION('S');
SIGNAL OFF ERROR;
SAY '!!> Error   Exception trapped. ';
CALL EXIT_X 200,S_SG,S_RC,S_CI,S_CC,S_CD,S_CS
/* -------------------------------------------------------------------*/
SIGNAL_NOVALUE:
S_SG = SIGL;
S_RC = RC;
S_CI = CONDITION('I');
S_CC = CONDITION('C');
S_CD = CONDITION('D');
S_CS = CONDITION('S');
SIGNAL OFF NOVALUE;
SAY '!!> Novalue Exception trapped. ';
CALL EXIT_X 300,S_SG,S_RC,S_CI,S_CC,S_CD,S_CS
/* -------------------------------------------------------------------*/
SIGNAL_FAILURE
S_SG = SIGL;
S_RC = RC;
S_CI = CONDITION('I');
S_CC = CONDITION('C');
S_CD = CONDITION('D');
S_CS = CONDITION('S');
SIGNAL OFF FAILURE;
SAY '!!> Failure Exception trapped. ';
CALL EXIT_X 400,S_SG,S_RC,S_CI,S_CC,S_CD,S_CS
/* -------------------------------------------------------------------*/
SIGNAL_HALT:
S_SG = SIGL;
S_RC = RC;
S_CI = CONDITION('I');
S_CC = CONDITION('C');
S_CD = CONDITION('D');
S_CS = CONDITION('S');
SIGNAL OFF HALT;
SAY '!!> Halt    Exception trapped. ';
CALL EXIT_X 500,S_SG,S_RC,S_CI,S_CC,S_CD,S_CS
/* -------------------------------------------------------------------*/
EXIT_X:
PARSE ARG #USER_RC,#SIGL,#RC,#CI,#CC,#CD,#CS;
SAY '!!> CONDITIO(''I''): ' || #CI;
SAY '!!> CONDITIO(''C''): ' || #CC;
SAY '!!> CONDITIO(''D''): ' || #CD;
SAY '!!> CONDITIO(''S''): ' || #CS;
SAY '!!> SIGL           : ' || #SIGL;
SAY '!!> SOURCE CODE    : ' || STRIP(SOURCELINE(#SIGL));
SAY '!!> RC             : ' || #RC;
SAY '!!> ERRORTEXT      : ' || ERRORTEXT(#RC);
SAY '**> #OS            : ' || #OS   ;
SAY '**> #CALL          : ' || #CALL ;
SAY '**> #NAME          : ' || #NAME ;
SAY '**> #SYSID         : ' || #SYSID;
SAY '**> #DSN           : ' || #DSN  ;
SAY '**> #REST          : ' || #REST ;
SAY '!!> [' || #NAME || '] MODULE ABNORMAL TERMINATION. USER_RC: ',
            || #USER_RC;
EXIT #USER_RC;
/* -------------------------------------------------------------------*/
