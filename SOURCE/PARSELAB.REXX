/* REXX */
/*

  Fill in the answers. You may run this exec at any time to see
  your answers.

  When you wish to compare answers, run %PARSCHK.

*/

/* -------------------------------------------------------------------*/
SIGNAL ON ERROR   NAME SIGNAL_ERROR  ;
SIGNAL ON SYNTAX  NAME SIGNAL_SYNTAX ;
SIGNAL ON NOVALUE NAME SIGNAL_NOVALUE;
SIGNAL ON FAILURE NAME SIGNAL_FAILURE;
SIGNAL ON HALT    NAME SIGNAL_HALT   ;
PARSE  SOURCE     #OS  #CALL #NAME #SYSID #DSN #REST;
ADDRESS TSO "CLRSCRN";
SAY '++> [' || #NAME || '] MODULE STARTED.';
/* -------------------------------------------------------------------*/
/* ADD YOUR CODE HERE */
s1 = 'Themholepispinqonepwallmonly'
s2 = 'When in doubt, quote it'
s3 = 'An exec in time saves nine'
s4 = 'All that glitters is not REXX'
s5 = Time() Date()

Say "1. From the following expression, put the second word into A,"
Say "   the fourth word into B and the fifth word into C."

                                             /* code a template */
    Parse Value Translate(s1,,'mpq')  With . A . B C .;
  SAY Translate(s1,,'mpq');
  Say a b c;

Say "2. From the variable S2 put all data before the comma into D"
Say "   and all data after the comma into E."
                                            /* code a template   */
    Parse Var s2 D ',' E
  SAY S2
  Say d
  Say e

Say "3. From the variable S2, put columns 18 and 19 into F."

                                            /* code a template   */
    Parse Var s2 =18 F +2
  SAY S2
  Say f

Say "4. Parse the variable S4 based on the current content of the"
Say "   variable F. Put everything after that match point into G."

                                            /* code a template   */
    Parse Var s4 . (F) G
  SAY S4;
  SAY 'F: ' || F;
  Say g;

Say "5. From the variable s5, put the hours into H, minutes into M,"
Say "   and seconds into S."

                                            /* code a template   */
    Parse Var s5 H ':' M ':' S .
  SAY  S5
  Say 'hours='h', minutes='m', seconds='s

Say "6. From S3, put the first 21 columns into I, and"
Say "   columns 14 and 15 into J."

                                            /* code a template   */
    Parse Var s3 1 I +21 =14 J +2
  SAY 'S3: <'   || S3 || '>';
  Say 'i j : <' ||  i || ' ' || j || '>'

Say "7. From S5, put the third word into K and the second word into L."

                                            /* code a template   */
    Parse Var s5 . .  K . =1 . L .
  SAY 'S5: <' || S5 || '>';
  Say k l

  SAY ''
  SAY 'END OF PAGE'
Say "8. From variable S4, put the 6 columns preceding the 's' into N."
                                            /* code a template   */
    Parse Var s4 =6 N 's';
  SAY 'S4: <' || S4 || '>';
  Say n

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