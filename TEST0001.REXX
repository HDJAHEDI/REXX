/* REXX */
PARSE SOURCE  #OS #CALL #NAME #SYSID #DSN #REST
ADDRESS TSO 'CLRSCRN';
SAY ' ** <' || #NAME || '> MODULE STARTED.';

TEST0000 =  "'" || #DSN || "(TEST0000)'"
ADDRESS TSO "EXEC " TEST0000 " 'aaaa' "

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