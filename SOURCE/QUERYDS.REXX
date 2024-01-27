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
/* ADD YOUR CODE HERE */
PARSE ARG ARG0 .;
SAY '++> Argument: ' || ARG0;
/* -------------------------------------------------------------------*/
SYSDSN_MSG = SYSDSN('''' || ARG0 || '''');
SAY '++> RC        : ' || RC     ;
SAY '++> SYSDSN_MSG: ' || SYSDSN_MSG;
IF SYSDSN_MSG = 'OK' THEN DO
   LISTDSI_RC = LISTDSI('''' || ARG0 || '''' 'directory' 'multivol',
                        'racf' 'recall' 'smsinfo');
   IF LISTDSI_RC = 0 THEN DO
      SAY '++> RECFM           : ' || SYSRECFM;
      SAY '++> LRECL           : ' || SYSLRECL;
      SAY '++> LAST REFERENCE  : ' || SYSREFDATE;
      SAY '++> SAPCE & UNIT    : ' || 'SAPCE(' || SYSPRIMARY || ',',
            || SYSSECONDS || ') '  || SYSUNITS;
      SAY '++> USED SPACE      : ' || SYSUSED;
      SAY '++> DATA       CALSS: ' || SYSDATACLASS;
      SAY '++> STORAGE    CLASS: ' || SYSSTORCLASS;
      SAY '++> MANAGEMENT CALSS: ' || SYSMGMTCLASS;
      SAY '++> DSORG           : ' || SYSDSORG;
      SAY '++> DATASET TYPE    : ' || SYSDSSMS;
      IF   SYSDSSMS = 'SEQ' THEN DO
       ADDRESS TSO "ALLOC DDNAME(INDD) DA('" || ARG0 || "') SHR REUSE";
       REC. = '';
       ADDRESS MVS "EXECIO 1 DISKR INDD (STEM REC. OPEN FINIS)"
       ADDRESS TSO "FREE  DDNAME(INDD)";
       SAY '--> FIRST REC:';
       SAY REC.1;
      END
      ELSE DO
       NOP;
      END
 /*
      SAY '++> SYSDSNAME     : ' || SYSDSNAME;
      SAY '++> SYSVOLUME     : ' || SYSVOLUME;
      SAY '++> SYSUNIT       : ' || SYSUNIT;
      SAY '++> SYSDSORG      : ' || SYSDSORG;
      SAY '++> SYSBLKSIZE    : ' || SYSBLKSIZE;
      SAY '++> SYSKEYLEN     : ' || SYSKEYLEN ;
      SAY '++> SYSUSED       : ' || SYSUSED   ;
      SAY '++> SYSUSEDPAGES  : ' || SYSUSEDPAGES;
      SAY '++> SYSPRIMARY    : ' || SYSPRIMARY;
      SAY '++> SYSSECONDS    : ' || SYSSECONDS;
      SAY '++> SYSUNITS      : ' || SYSUNITS;
      SAY '++> SYSEXTENTS    : ' || SYSEXTENTS;
      SAY '++> SYSUSEDEXTENTS: ' || SYSUSEDEXTENTS;
      SAY '++> SYSREFDATE    : ' || SYSREFDATE;
      SAY '++> SYSEXDATE     : ' || SYSEXDATE;
      SAY '++> SYSPASSWORD   : ' || SYSPASSWORD;
      SAY '++> SYSRACFA      : ' || SYSRACFA;
      SAY '++> SYSUPDATED    : ' || SYSUPDATED;
      SAY '++> SYSTRKSCYL    : ' || SYSTRKSCYL;
      SAY '++> SYSBLKSTRK    : ' || SYSBLKSTRK;
      SAY '++> SYSADIRBLK    : ' || SYSADIRBLK;
      SAY '++> SYSUDIRBLK    : ' || SYSUDIRBLK;
      SAY '++> SYSMEMBERS    : ' || SYSMEMBERS;
      SAY '++> SYSDSSMS      : ' || SYSDSSMS;
      SAY '++> SYSDATACLASS  : ' || SYSDATACLASS;
      SAY '++> SYSSTORCLASS  : ' || SYSSTORCLASS;
      SAY '++> SYSMGMTCLASS  : ' || SYSMGMTCLASS;
      SAY '++> SYSSEQDSNTYPE : ' || SYSSEQDSNTYPE;
      SAY '++> SYSEATTR      : ' || SYSEATTR;
      SAY '++> SYSEADSCB     : ' || SYSEADSCB;
      SAY '++> SYSALLOCPAGES : ' || SYSALLOCPAGES;
      SAY '++> SYSUSEDPERCENT: ' || SYSUSEDPERCENT;
      SAY '++> SYSNUMVOLS    : ' || SYSNUMVOLS;
      SAY '++> SYSCREATETIME : ' || SYSCREATETIME;
      SAY '++> SYSCREATEJOB  : ' || SYSCREATEJOB;
      SAY '++> SYSCREATESTEP : ' || SYSCREATESTEP;
      SAY '++> SYSDSVERSION  : ' || SYSDSVERSION;
      SAY '++> SYSENCRYPT    : ' || SYSENCRYPT;
      SAY '++> SYSKEYLABEL   : ' || SYSKEYLABEL;
      SAY '++> SYSMAXGENS    : ' || SYSMAXGENS;
      */
   END
   ELSE DO
      SAY '++> SYSREASON     : ' || SYSREASON;
      SAY '++> SYSMSGLVL1    : ' || SYSMSGLVL1;
      SAY '++> SYSMSGLVL2    : ' || SYSMSGLVL2;
   END
END
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