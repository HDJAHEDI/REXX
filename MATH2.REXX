/* REXX */
/* -------------------------------------------------------------------*/
PARSE SOURCE  #OS #CALL #NAME #SYSID #DSN #REST
ADDRESS TSO "CLRSCRN";
SAY '** <' || #NAME || '> MODULE STARTED.';
/* -------------------------------------------------------------------*/
PARSE ARG A B;
IF  A = '' | B = '' THEN
 DO
   SAY '>> Please enter two numbers (a,b):';
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