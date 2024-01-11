/* REXX */
/* -------------------------------------------------------------------*/
PARSE SOURCE  #OS #CALL #NAME #SYSID #DSN #REST
ADDRESS TSO "CLRSCRN";
SAY '** <' || #NAME || '> MODULE STARTED.';
/* -------------------------------------------------------------------*/
OPR = ''
DO UNTIL OPR  = 'EXIT'
   SAY COPIES('-', 79);
   SAY '>> Please enter an Arithmethic operation (+, -, *, /):';
   PARSE EXTERNAL OPR;

   IF OPR = 'EXIT' THEN
      ITERATE;

   SELECT
     WHEN OPR = '+' THEN CALL ADD;
     WHEN OPR = '-' THEN CALL SUB;
     WHEN OPR = '*' THEN CALL MUL;
     WHEN OPR = '/' THEN CALL DIV;
   OTHERWISE             CALL UNDEFINED;
   END; /* SELECT */

END /* DO WHILE */

SAY '>> Goodbye!'
CALL EXIT_0;
/* -------------------------------------------------------------------*/
ADD:
  CALL GET_NUMBERS;
  SAY '>> ' || A || ' + ' || B ' = ' A + B;
  RETURN;
/* -------------------------------------------------------------------*/
SUB:
  CALL GET_NUMBERS;
  SAY '>> ' || A || ' - ' || B ' = ' A - B;
  RETURN;
/* -------------------------------------------------------------------*/
MUL:
  CALL GET_NUMBERS;
  SAY '>> ' || A || ' * ' || B ' = ' A * B;
  RETURN;
/* -------------------------------------------------------------------*/
DIV:
  CALL GET_NUMBERS;
  IF B ¬= 0 THEN
   DO
    SAY '>> ' || A || ' / ' || B ' = ' A / B;
    D = A % B;
    R = A // B;
    SAY '>> ' || A || ' divided by ' || B || ' is ' || D,
        ' with a remainder of ' || R;
  END
  ELSE
   DO
    SAY '!! Division is not applicable, because B = 0';
  END;
  RETURN;
/* -------------------------------------------------------------------*/
UNDEFINED:
  SAY '!! Entered Operation is not defined: ' OPR;
  RETURN;
/* -------------------------------------------------------------------*/
GET_NUMBERS:
  A = '';
  B = '';
  DO UNTIL DATATYPE(A,'NUM') = 1,
         & DATATYPE(B,'NUM') = 1
     SAY '>> Please enter two numbers (a,b):';
     PARSE EXTERNAL A B;
  END

  RETURN;
/* -------------------------------------------------------------------*/
EXIT_0:
/*
  SAY '>> #OS   : ' #OS
  SAY '>> #CALL : ' #CALL
  SAY '>> #NAME : ' #NAME
  SAY '>> #SYSID: ' #D
  SAY '>> #DSN  : ' #DSN
  SAY '>> #REST : ' #REST
*/
  SAY '** <' || #NAME || '> MODULE NORMAL END.';
  EXIT 0;
/* -------------------------------------------------------------------*/
EXIT_?:
/*
  SAY '>> #OS   : ' #OS
  SAY '>> #CALL : ' #CALL
  SAY '>> #NAME : ' #NAME
  SAY '>> #SYSID: ' #D
  SAY '>> #DSN  : ' #DSN
  SAY '>> #REST : ' #REST
*/
  SAY '!! <' || #NAME || '> MODULE ABNORMAL TERMINATION. USER_RC: ',
    || USER_RC;
  EXIT USER_RC;
/* -------------------------------------------------------------------*/
