/* REXX */
/* -------------------------------------------------------------------*/
PARSE SOURCE  #OS #CALL #NAME #SYSID #DSN #REST
ADDRESS TSO "CLRSCRN";
SAY '** <' || #NAME || '> MODULE STARTED.';
/* -------------------------------------------------------------------*/
PARSE ARG PARMS;
CALL CHECK_PARMS;

DO WHILE ¬(A = 'EXIT' & B = '')
   IF DATATYPE(A,'NUM') = 1,
    & DATATYPE(B,'NUM') = 1 THEN
    DO
      SAY '>> At ' || TIME('N') || ' on ' || DATE('O'),
           || ' You entered ' || A  || ' and ' || B || '.';
      SAY '>> ' || A || ' + ' || B ' = ' A + B;
      SAY '>> ' || A || ' - ' || B ' = ' A - B;
      SAY '>> ' || A || ' * ' || B ' = ' A * B;
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
        SAY '!! Second number is 0: division cannot be done.';
      END
   END
   SAY COPIES('-',79)
   SAY '>> Please enter two numbers (a b) or EXIT to end:';
   PARSE EXTERNAL PARMS;
   CALL CHECK_PARMS;
END /* DO WHILE */
SAY '>> Goodbye!'

CALL EXIT_0;

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
CHECK_PARMS:
  IF      WORDS(PARMS) = 1 THEN
   DO
     A = PARMS;
     B = '';
  END
  ELSE IF WORDS(PARMS) = 2 THEN
   DO
     A = WORD(PARMS, 01);
     B = WORD(PARMS, 02);
  END
  ELSE
   DO
     A = '';
     B = '';
  END
  RETURN;
/* -------------------------------------------------------------------*/
