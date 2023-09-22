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
SAY '++> Please enter an Arithmethic operation (+, -, *, /):';
PARSE EXTERNAL OPR;

SELECT
  WHEN OPR = '+' THEN CALL ADD;
  WHEN OPR = '-' THEN CALL SUB;
  WHEN OPR = '*' THEN CALL MUL;
  WHEN OPR = '/' THEN CALL DIV;
OTHERWISE             CALL UNDEFINED;
END; /* SELECT */
CALL EXIT_0;
/* -------------------------------------------------------------------*/
ADD:
  CALL GET_NUMBERS;
  SAY '++> ' || A || ' + ' || B ' = ' A + B;
  RETURN;
/* -------------------------------------------------------------------*/
SUB:
  CALL GET_NUMBERS;
  SAY '++> ' || A || ' - ' || B ' = ' A - B;
  RETURN;
/* -------------------------------------------------------------------*/
MUL:
  CALL GET_NUMBERS;
  SAY '++> ' || A || ' * ' || B ' = ' A * B;
  RETURN;
/* -------------------------------------------------------------------*/
DIV:
  CALL GET_NUMBERS;
  IF B ¬= 0 THEN
   DO
    SAY '++> ' || A || ' / ' || B ' = ' A / B;
    D = A % B;
    R = A // B;
    SAY '++> ' || A || ' divided by ' || B || ' is ' || D,
        ' with a remainder of ' || R;
  END
  ELSE
   DO
    SAY '!!> Division is not applicable, because B = 0';
  END;
  RETURN;
/* -------------------------------------------------------------------*/
UNDEFINED:
  SAY '!!> Entered Operation is not defined: ' OPR;
  RETURN;
/* -------------------------------------------------------------------*/
GET_NUMBERS:
  SAY '++> Please enter two numbers (a,b):';
  PARSE EXTERNAL A B;

  IF DATATYPE(A,'NUM') = 0 THEN
   DO
     SAY '!!> a: <' || A || '> is not a number. ';
     USER_RC = 1
     CALL EXIT_?
  END;

  IF DATATYPE(B,'NUM') = 0 THEN
   DO
     SAY '!!> b: <' || B || '> is not a number. ';
     USER_RC = 2
     CALL EXIT_?
  END;
  RETURN;
/* -------------------------------------------------------------------*/
EXIT_0:
SAY '++> {' || #NAME || '} MODULE NORMAL END.';
EXIT 0;
/* -------------------------------------------------------------------*/
EXIT_?:
SAY '++> {' || #NAME || '} MODULE ABNORMAL TERMINATION. USER_RC: ',
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
SIGNAL_FAILURE
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