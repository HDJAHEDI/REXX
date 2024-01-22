/* REXX */
/* -------------------------------------------------------------------*/
SIGNAL  ON  ERROR   NAME SIGNAL_ERROR  ;
SIGNAL  ON  SYNTAX  NAME SIGNAL_SYNTAX ;
SIGNAL  ON  NOVALUE NAME SIGNAL_NOVALUE;
SIGNAL  ON  FAILURE NAME SIGNAL_FAILURE;
SIGNAL  ON  HALT    NAME SIGNAL_HALT   ;
PARSE   SOURCE     #OS  #CALL #NAME #SYSID #DSN #REST;
ADDRESS TSO "CLRSCRN";
SAY '++> [' || #NAME || '] MODULE STARTED.';
/* -------------------------------------------------------------------*/
INPUT_DSN    = '';
INPUT_DDNAME = '';
PARSE ARG INPUT_ARG;
IF  INPUT_ARG = '#' THEN DO
 SAY '??> ENTER DATASET NAME: '
 PARSE EXTERNAL INPUT_DSN;
END
IF  INPUT_ARG = '$' THEN DO
 SAY '??> ENTER DDNAME: '
 PARSE EXTERNAL INPUT_DDNAME;
END
/* -------------------------------------------------------------------*/
DSN_DATE = 'D' || SUBSTR(DATE('S'),1,4) || SUBSTR(DATE('J'),3,3);
PARSE VALUE TIME() WITH HH ':' MM ':' SS .
DSN_TIME = 'T' || HH ||  MM ||  SS;
DSN = USERID() || '.ES52.LISTDD01.OUTPUT.' || DSN_DATE || '.',
               || DSN_TIME;
SAY '##> OUTPUT DSN: ' || DSN;
/*ADDRESS TSO "FREE   DDNAME(OUTDD)";*/
ADDRESS TSO "ALLOC  DDNAME(OUTDD) DA('" || DSN || "') MOD SPACE(5,5)",
         || "TRACKS RELEASE LRECL(80) RECFM(F) DSORG(PS) REUSE";
/* -------------------------------------------------------------------*/
INREC.='';
CMD_RC = OUTTRAP('INREC.','*','CONCAT','1');
/* SIGNAL OFF ERROR; */
ADDRESS TSO "LISTALC STATUS SYSNAMES";
SAY '++> TSO/E CMD RC: ' || RC;
SIGNAL ON  ERROR   NAME SIGNAL_ERROR  ;
CMD_RC = OUTTRAP('OFF');
/* -------------------------------------------------------------------*/
IF INPUT_DSN \= '' THEN DO
 SAY '++> SEARCH FOR DSN: <' || INPUT_DSN || '>';
END
IF INPUT_DDNAME \= '' THEN DO
 SAY '++> SEARCH FOR DDNAME: <' || INPUT_DDNAME || '>';
END
/* -------------------------------------------------------------------*/
TEMPREC   = '';
TEMPREC.0 =  0;
J = 0;
DO  I = 1 TO INREC.0
/* SAY '**>' RIGHT(I,4,'0') ': <' || INREC.I || '>'; */
 IF    SUBSTR(INREC.I,1,2) = '  '  THEN DO
  IF   SUBSTR(INREC.I,3,1) = ' '   THEN DO
   TEMPREC.J.DISP   = SPACE(INREC.I);
   TEMPREC.J.DDNAME = COPIES('-',8) ;
  END
  ELSE DO
   PARSE VALUE SPACE(INREC.I) WITH TEMPREC.J.DDNAME TEMPREC.J.DISP;
  END
 END
 ELSE  DO
  J = J + 1;
  TEMPREC.0 = J
  TEMPREC.J.DDNAME = COPIES('-', 8);
  TEMPREC.J.DISP   = COPIES('-',13);
  PARSE VALUE SPACE(INREC.I) WITH TEMPREC.J.DSN TEMPREC.J.DDNAME;
 END
END I
/* -------------------------------------------------------------------*/
OUTREC.   = '';
OUTREC.1  = 'DDNAME  ' || ' ' || 'DISP         ' || ' ' || 'DSN';
OUTREC.2  = COPIES('-',08) || ' ' || COPIES('-',13) || ' ' ||,
            COPIES('-',57);
K         = 2;
OUTREC.0  = K;
DO I = 1 TO  TEMPREC.0
 IF  INPUT_DSN \= '' THEN DO
  IF INPUT_DSN \= TEMPREC.I.DSN THEN DO
   NOP;
  END
  ELSE DO
   K = K + 1 ;
   OUTREC.K =,
   TEMPREC.I.DDNAME || COPIES(' ', 8 - LENGTH(TEMPREC.I.DDNAME)),
   TEMPREC.I.DISP   || COPIES(' ',13 - LENGTH(TEMPREC.I.DISP  )),
   TEMPREC.I.DSN;
  END
 END
 ELSE  DO
  IF  INPUT_DDNAME \= '' THEN DO
   IF INPUT_DDNAME \= TEMPREC.I.DDNAME THEN DO
    NOP;
   END
   ELSE DO
    K = K + 1 ;
    OUTREC.K =,
    TEMPREC.I.DDNAME || COPIES(' ', 8 - LENGTH(TEMPREC.I.DDNAME)),
    TEMPREC.I.DISP   || COPIES(' ',13 - LENGTH(TEMPREC.I.DISP  )),
    TEMPREC.I.DSN;
   END
  END
  ELSE DO
   K = K + 1 ;
   OUTREC.K =,
   TEMPREC.I.DDNAME || COPIES(' ', 8 - LENGTH(TEMPREC.I.DDNAME)),
   TEMPREC.I.DISP   || COPIES(' ',13 - LENGTH(TEMPREC.I.DISP  )),
   TEMPREC.I.DSN;
  END
 END
/* SAY '**>' RIGHT(I,4,'0') ':' OUTREC.I;*/
END I
/* -------------------------------------------------------------------*/
ADDRESS MVS "EXECIO * DISKW OUTDD ( STEM OUTREC. OPEN FINIS )";
ADDRESS TSO "FREE   DDNAME(OUTDD)";
SAY '##> PRESS ENTER TO CONTINUE ... ';
ADDRESS ISPEXEC "BROWSE DATASET('" || DSN || "';";
CALL EXIT_0;
/* -------------------------------------------------------------------*/
EXIT_0:
/*
*/
SAY '++> [' || #NAME || '] MODULE NORMAL END.';
EXIT 0;
/* -------------------------------------------------------------------*/
PARSE_DISP:
PARSE  ARG STR_0;
RETURN TRIM(STR_0);
/* -------------------------------------------------------------------*/
PARSE_DDNAME:
PARSE  ARG STR_0;
PARSE  VALUE TRIM(STR_0) WITH STR_1 STR_2;
RETURN STR_1 STR_2;
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