/* REXX */
PARSE SOURCE  #OS #CALL #NAME #SYSID #DSN #REST
SAY ' ** <' || #NAME || '> MODULE STARTED.';

PARSE ARG PARMS;
SAY ' >> PARMS: ' || PARMS;

EXIT_0:
/*
SAY ' >> #OS   : ' #OS
SAY ' >> #CALL : ' #CALL
SAY ' >> #NAME : ' #NAME
SAY ' >> #SYSID: ' #D
SAY ' >> #DSN  : ' #DSN
SAY ' >> #REST : ' #REST
*/
SAY ' ** <' || #NAME || '> MODULE NORMAL END.';
EXIT 0;
