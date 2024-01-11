/* REXX */
/* -------------------------------------------------------------------*/
PARSE SOURCE  #OS #CALL #NAME #SYSID #DSN #REST
IF #CALL = 'COMMAND' THEN
 DO
   ADDRESS TSO "CLRSCRN";
   SAY '** <' || #NAME || '> MODULE STARTED.';
END
/* -------------------------------------------------------------------*/
PARSE ARG PARMS;
COUNT = WORDS(PARMS)
SUM   = 0
DO  I = 1 TO COUNT
    IF DATATYPE(WORD(PARMS, I), 'NUM') = 1 THEN
     DO
       SUM = SUM + WORD(PARMS, I)
    END
END
SAY '>> The sum of ' || PARMS || ' is ' || SUM || '.'
IF #CALL = 'COMMAND' THEN
 DO
/*
   SAY '>> #OS   : ' #OS
   SAY '>> #CALL : ' #CALL
   SAY '>> #NAME : ' #NAME
   SAY '>> #SYSID: ' #SYSID
   SAY '>> #DSN  : ' #DSN
   SAY '>> #REST : ' #REST
*/
   SAY '** <' || #NAME || '> MODULE NORMAL END.';
   EXIT 0
END
ELSE
   RETURN SUM;

/* -------------------------------------------------------------------*/
EXIT_0:
  IF #CALL = 'COMMAND' THEN
   DO
/*
     SAY '>> #OS   : ' #OS
     SAY '>> #CALL : ' #CALL
     SAY '>> #NAME : ' #NAME
     SAY '>> #SYSID: ' #SYSID
     SAY '>> #DSN  : ' #DSN
     SAY '>> #REST : ' #REST
*/
     SAY '** <' || #NAME || '> MODULE NORMAL END.';
  END
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