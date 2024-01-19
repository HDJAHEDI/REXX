/* REXX */
/* -------------------------------------------------------------------*/
SIGNAL ON  ERROR   NAME SIGNAL_ERROR  ;
SIGNAL ON  SYNTAX  NAME SIGNAL_SYNTAX ;
SIGNAL ON  NOVALUE NAME SIGNAL_NOVALUE;
SIGNAL ON  FAILURE NAME SIGNAL_FAILURE;
SIGNAL ON  HALT    NAME SIGNAL_HALT   ;
PARSE      SOURCE  #OS  #CALL #NAME #SYSID #DSN #REST;
ADDRESS TSO "CLRSCRN";
SAY '++> [' || #NAME || '] MODULE STARTED.';
/* -------------------------------------------------------------------*/
/* ADD YOUR CODE HERE */
MSG0.  = '';
MSG1.  = '';
MSG2.  = '';

ADDRESS     TSO "CONSPROF SOLDISPLAY(NO) SOLNUM(9999)";
ADDRESS     TSO "CONSOLE  ACTIVATE";
ADDRESS CONSOLE "CART     APP000";
ADDRESS CONSOLE "DISPLAY  ASM";
ADDRESS CONSOLE "CART     APP001";
ADDRESS CONSOLE "DISPLAY  IPLINFO";
ADDRESS CONSOLE "CART     APP002";
ADDRESS CONSOLE "DISPLAY  TS," || USERID();
GET_RC        =  GETMSG('MSG0.','SOL','APP000',,30);
GET_RC        =  GETMSG('MSG1.','SOL','APP001',,30);
GET_RC        =  GETMSG('MSG2.','SOL','APP002',,30);
ADDRESS     TSO "CONSOLE  DEACTIVATE";
DSN = 'TSOXA13.ES52.REXX.OUTPUT';
ADDRESS TSO "ALLOC DDNAME(OUTDD) DA('" || DSN || "') MOD SPACE(5,5)",
         || "TRACKS RELEASE LRECL(80) RECFM(F) DSORG(PS) REUSE";
ADDRESS MVS "EXECIO * DISKW OUTDD (STEM MSG0. OPEN  )";
ADDRESS MVS "EXECIO * DISKW OUTDD (STEM MSG1.       )";
ADDRESS MVS "EXECIO * DISKW OUTDD (STEM MSG2. FINIS )";
ADDRESS TSO "FREE DDNAME(OUTDD)";
PARSE VALUE MSG0.1 WITH . VAR_TIME .
SAY 'It is now ' || TRANSLATE(VAR_TIME,':','.');
SAY  MSG1.2
PARSE VALUE MSG0.3 WITH . VAR_PERCENT . . VAR_DSN
SAY 'The PLPA data set, ' || VAR_DSN || ', is ',
  || VAR_PERCENT || ' full.'
PARSE VALUE MSG2.4 WITH VAR_USERID .
PARSE VALUE MSG2.9 WITH . '=' VAR_ASID .
SAY  VAR_USERID || ' is running in Address Space ID ' || VAR_ASID || ','
PARSE VALUE MSG2.5 WITH,
. 'CT=' VAR_CPU 'ET=' VAR_HH '.' VAR_MM '.' VAR_SS .
SAY  'and has been logged on for ' || VAR_HH ||' hours,  ',
 ||   VAR_MM  || ' minutes, and '  || VAR_SS ||' seconds,';
SAY  'using ' VAR_CPU || ' CPU seconds.';
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