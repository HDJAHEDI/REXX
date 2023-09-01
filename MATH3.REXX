/* REXX */
/* -------------------------------------------------------------------*/
PARSE SOURCE  #OS #CALL #NAME #SYSID #DSN #REST
ADDRESS TSO "CLRSCRN";
SAY '** <' || #NAME || '> MODULE STARTED.';
/* -------------------------------------------------------------------*/
PARSE ARG A B;
DO WHILE A ¬= 'EXIT'
   IF DATATYPE(A,'NUM') = 1,
    & DATATYPE(B,'NUM') = 1 THEN
    DO
      SAY '>> You entered ' || A  || ' and ' || B || '.';
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
   SAY '>> Please enter two numbers (a, b):';
   PARSE EXTERNAL A B;
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
