/* REXX */
/* -------------------------------------------------------------------*/
TRACE OFF;
/*SIGNAL ON ERROR   NAME SIGNAL_ERROR  ;*/
SIGNAL ON SYNTAX  NAME SIGNAL_SYNTAX ;
SIGNAL ON NOVALUE NAME SIGNAL_NOVALUE;
SIGNAL ON FAILURE NAME SIGNAL_FAILURE;
SIGNAL ON HALT    NAME SIGNAL_HALT   ;
PARSE  SOURCE     #OS  #CALL #NAME #SYSID #DSN #REST;
ADDRESS TSO "CLRSCRN";
SAY '++> [' || #NAME || '] MODULE STARTED.';
/* -------------------------------------------------------------------*/
/* ADD YOUR CODE HERE */
SAY '??> ENTER DATASET NAME:'
PARSE EXTERNAL DSNI;
SYSDSN_RC = SYSDSN(DSNI);
IF   SYSDSN_RC = 'OK'   THEN DO
     SAY '++> SYSDSN(' || DSNI || '): ' SYSDSN_RC;
END
ELSE DO
     SAY '!!> SYSDSN(' || DSNI || '): ' SYSDSN_RC;
     CALL EXIT_0
END

ADDRESS TSO "QSTACK";
QSTACK_RC = RC;
SAY "**> QSTACK_RC: " || QSTACK_RC;

ADDRESS TSO "QBUF";
QBUF_RC   = RC;
SAY "**> QBUF_RC  : " || QBUF_RC;

ADDRESS TSO "QELEM";
QELEM_RC = RC;
SAY "**> QELEM_RC : " || QELEM_RC;

ADDRESS TSO "ALLOC DSNAME(" DSNI ") DDNAME(SYSINDD) SHR REUSE";
ALLOC_RC  = RC;
IF   ALLOC_RC  = 0  THEN DO
     SAY '++> DSN(' || DSNI || ') ALLOCATION NORMAL: ' || ALLOC_RC;
END
ELSE DO
     SAY '!!> DSN(' || DSNI || ') ALLOCATION FAILED: ' || ALLOC_RC;
     CALL EXIT_0
END

ADDRESS TSO "ALLOC DSNAME(*) DDNAME(SYSOUDD) SHR REUSE";
ALLOC_RC  = RC;
IF   ALLOC_RC  = 0  THEN DO
     SAY '++> DSN(' || DSNI || ') ALLOCATION NORMAL: ' || ALLOC_RC;
END
ELSE DO
     SAY '!!> DSN(' || DSNI || ') ALLOCATION FAILED: ' || ALLOC_RC;
     CALL EXIT_0
END

ADDRESS TSO "NEWSTACK";
NEWSTK_RC = RC
IF   NEWSTK_RC = 0  THEN DO
     SAY '++> NEW DATASTACK  CREATION    NORMAL: ' || NEWSTK_RC;
END
ELSE DO
     SAY '!!> NEW DATASTACK  CREATION    FAILED: ' || NEWSTK_RC;
     CALL EXIT_0
END

ADDRESS TSO "MAKEBUF";
MAKBUF_RC = RC
IF   MAKBUF_RC >= 0  THEN DO
     SAY '++> NEW DATABUFFER CREATION    NORMAL: ' || MAKBUF_RC;
END
ELSE DO
     SAY '!!> NEW DATABUFFER CREATION    FAILED: ' || MAKBUF_RC;
 /*  CALL EXIT_0 */
END
/*
ADDRESS TSO "QSTACK";
QSTACK_RC = RC;
SAY "**> QSTACK_RC: " || QSTACK_RC;

ADDRESS TSO "QBUF";
QBUF_RC   = RC;
SAY "**> QBUF_RC  : " || QBUF_RC;

ADDRESS TSO "QELEM";
QELEM_RC = RC;
SAY "**> QELEM_RC : " || QELEM_RC;
*/
ADDRESS MVS "EXECIO * DISKR SYSINDD 1 (FIFO OPEN FINIS)";
EXECIO_RC = RC
IF   EXECIO_RC = 0  THEN DO
     SAY '++> DDNAME(SYSINDD) EXECIO DISKR NORMAL: ' || EXECIO_RC;
END
ELSE DO
     SAY '!!> DDNAME(SYSINDD) EXECIO DISKR FAILED: ' || EXECIO_RC;
     CALL EXIT_0
END
/*
ADDRESS TSO "QSTACK";
QSTACK_RC = RC;
SAY "**> QSTACK_RC: " || QSTACK_RC;

ADDRESS TSO "QBUF";
QBUF_RC   = RC;
SAY "**> QBUF_RC  : " || QBUF_RC;

ADDRESS TSO "QELEM";
QELEM_RC = RC;
SAY "**> QELEM_RC : " || QELEM_RC;
*/
ADDRESS MVS "EXECIO * DISKW SYSOUDD (OPEN FINIS)";
EXECIO_RC = RC
IF   EXECIO_RC = 0  THEN DO
     SAY '++> DDNAME(SYSINDD) EXECIO DISKW NORMAL: ' || EXECIO_RC;
END
ELSE DO
     SAY '!!> DDNAME(SYSINDD) EXECIO DISKW FAILED: ' || EXECIO_RC;
     CALL EXIT_0
END
/*
ADDRESS TSO "QSTACK";
QSTACK_RC = RC;
SAY "**> QSTACK_RC: " || QSTACK_RC;

ADDRESS TSO "QBUF";
QBUF_RC   = RC;
SAY "**> QBUF_RC  : " || QBUF_RC;

ADDRESS TSO "QELEM";
QELEM_RC = RC;
SAY "**> QELEM_RC : " || QELEM_RC;
*/
/*
SAY '';
SAY '++> </START>';
DO   WHILE QUEUED() > 0
     PARSE PULL REC;
     SAY '++> ' || SUBSTR(REC,1,75);
END
SAY '++> </END>';
SAY '';
*/
/*
ADDRESS TSO "QSTACK";
QSTACK_RC = RC;
SAY "**> QSTACK_RC: " || QSTACK_RC;

ADDRESS TSO "QBUF";
QBUF_RC   = RC;
SAY "**> QBUF_RC  : " || QBUF_RC;

ADDRESS TSO "QELEM";
QELEM_RC = RC;
SAY "**> QELEM_RC : " || QELEM_RC;
*/

ADDRESS TSO "DROPBUF";
DRPBUF_RC = RC
IF   DRPBUF_RC = 0  THEN DO
     SAY '++> NEW DATABUFFER DELETION    NORMAL: ' || DRPBUF_RC;
END
ELSE DO
     SAY '!!> NEW DATABUFFER DELETION    FAILED: ' || DRPBUF_RC;
  /* CALL EXIT_0 */
END

ADDRESS TSO "DELSTACK";
DELSTK_RC = RC
IF   DELSTK_RC = 0  THEN DO
     SAY '++> NEW DATASTACK  DELETION    NORMAL: ' || DELSTK_RC;
END
ELSE DO
     SAY '!!> NEW DATASTACK  DELETION    FAILED: ' || DELSTK_RC;
     CALL EXIT_0
END
/*
ADDRESS TSO "QSTACK";
QSTACK_RC = RC;
SAY "**> QSTACK_RC: " || QSTACK_RC;

ADDRESS TSO "QBUF";
QBUF_RC   = RC;
SAY "**> QBUF_RC  : " || QBUF_RC;

ADDRESS TSO "QELEM";
QELEM_RC = RC;
SAY "**> QELEM_RC : " || QELEM_RC;
*/
ADDRESS TSO "FREE DDNAME(SYSINDD)";
FREE_RC   = RC
IF   ALLOC_RC  = 0  THEN DO
     SAY '++> DDNAME(SYSINDD) UNALLOCATE NORMAL: ' || ALLOC_RC;
END
ELSE DO
     SAY '!!> DDNAME(SYSINDD) UNALLOCATE FAILED: ' || ALLOC_RC;
     CALL EXIT_0
END

SAY 'CHECK FOR REMIANING ELEMENTS IN THE STACK:';
SAY '++> </START>';
DO   WHILE QUEUED() > 0
     PARSE PULL REC;
     SAY '++> ' || SUBSTR(REC,1,75);
END
SAY '++> </END>';
SAY '';

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