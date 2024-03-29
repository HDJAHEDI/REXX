/* REXX */
/* -------------------------------------------------------------------*/
SIGNAL ON SYNTAX  NAME SIGNAL_SYNTAX ;
SIGNAL ON ERROR   NAME SIGNAL_ERROR  ;
SIGNAL ON NOVALUE NAME SIGNAL_NOVALUE;
SIGNAL ON FAILURE NAME SIGNAL_FAILURE;
SIGNAL ON HALT    NAME SIGNAL_HALT   ;
PARSE SOURCE  #OS #CALL #NAME #SYSID #DSN #REST
ADDRESS TSO "CLRSCRN";
SAY '++> {' || #NAME || '} MODULE STARTED.';
/* -------------------------------------------------------------------*/
PARSE ARG A B;
IF  A = '' | B = '' THEN
 DO
   SAY '++ >> Please enter two numbers (a,b):';
   PARSE EXTERNAL A B;
END

IF DATATYPE(A,'NUM') = 0 THEN
 DO
   SAY '!! a: <' || A || '> is not a number. ';
   USER_RC = 1
   CALL EXIT_?
END;

IF DATATYPE(B,'NUM') = 0 THEN
 DO
   SAY '!! b: <' || B || '> is not a number. ';
   USER_RC = 2
   CALL EXIT_?
END;

SAY '++ >> You entered ' || A  || ' and ' || B || '.';
SAY '++ >> ' || A || ' + ' || B ' = ' A + B;
SAY '++ >> ' || A || ' - ' || B ' = ' A - B;
SAY '++ >> ' || A || ' * ' || B ' = ' A * B;
IF B �= 0 THEN
 DO
  SAY '++ >> ' || A || ' / ' || B ' = ' A / B;
  D = A % B;
  R = A // B;
  SAY '++ >> ' || A || ' divided by ' || B || ' is ' || D,
      ' with a remainder of ' || R;
END
CALL EXIT_0;

/* -------------------------------------------------------------------*/
EXIT_0:
SAY '++> {' || #NAME || '} MODULE NORMAL END.';
EXIT 0;
/* -------------------------------------------------------------------*/
EXIT_?:
SAY '!!> {' || #NAME || '} MODULE ABNORMAL TERMINATION. USER_RC: ',
  || USER_RC;
EXIT USER_RC;
/* -------------------------------------------------------------------*/
SIGNAL_SYNTAX:
SIGNAL OFF SYNTAX;
SAY '!!> Syntax  Exception trapped. ';
CALL EXIT_X 100,SIGL
/* -------------------------------------------------------------------*/
SIGNAL_ERROR:
SIGNAL OFF ERROR;
SAY '!!> Error   Exception trapped. ';
CALL EXIT_X 200,SIGL
/* -------------------------------------------------------------------*/
SIGNAL_NOVALUE:
SIGNAL OFF NOVALUE;
SAY '!!> Novalue Exception trapped. ';
CALL EXIT_X 300,SIGL
/* -------------------------------------------------------------------*/
SIGNAL_FAILURE:
SIGNAL OFF FAILURE;
SAY '!!> Failure Exception trapped. ';
CALL EXIT_X 400,SIGL
/* -------------------------------------------------------------------*/
SIGNAL_HALT:
SIGNAL OFF HALT;
SAY '!!> Halt    Exception trapped. ';
CALL EXIT_X 500,SIGL
/* -------------------------------------------------------------------*/
EXIT_X:
PARSE ARG #USER_RC,#SIGL
SAY '!!> CONDITIO(''I''): ' || CONDITION('I');
SAY '!!> CONDITIO(''C''): ' || CONDITION('C');
SAY '!!> CONDITIO(''D''): ' || CONDITION('D');
SAY '!!> CONDITIO(''S''): ' || CONDITION('S');
SAY '!!> SIGL           : ' || #SIGL;
SAY '!!> SOURCE CODE    : ' || STRIP(SOURCELINE(#SIGL));
SAY '!!> RC             : ' || RC;
SAY '!!> ERRORTEXT      : ' || ERRORTEXT(RC);
SAY '**> #OS            : ' || #OS   ;
SAY '**> #CALL          : ' || #CALL ;
SAY '**> #NAME          : ' || #NAME ;
SAY '**> #SYSID         : ' || #SYSID;
SAY '**> #DSN           : ' || #DSN  ;
SAY '**> #REST          : ' || #REST ;
SAY '!!> {' || #NAME || '} MODULE ABNORMAL TERMINATION. USER_RC: ',
            || #USER_RC;
EXIT #USER_RC;
/* -------------------------------------------------------------------*/
