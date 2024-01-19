/*REXX*****************************************************************/00010001
/*** P.R                                                              */00020001
/*** ISPF/PDF EDIT MACRO: PERMET D'AJOUTER UNE CARTE DE TYPE JOB      */00030001
/***      SUR LE MEMBRE EN EDIT .                                     */00040001
/***                                                                  */00050001
/**********************************************************************/00060001
    TRACE OFF                                                           00070000
  ADDRESS ISPEXEC                                                       00080000
 'ISREDIT MACRO (PARAM)'                                                00090000
 'CONTROL ERRORS RETURN'                                                00100000
 "ISREDIT (MBR) = MEMBER"                                               00110000
 "ISREDIT (DSN) = DATASET"                                              00120000
  LETTRES = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"                      00130000
    TOTAL = LENGTH(LETTRES)                                             00140000
     ALEA = RANDOM(1,TOTAL)                                             00150000
   LETTRE = SUBSTR(LETTRES,ALEA,1)                                      00160000
   MYSELF = USERID()                                                    00170000
     NAME = MYSELF||LETTRE                                              00180000
     NAME = MYSELF||LETTRE||"        "                                  00190000
     NAME = SUBSTR(NAME,1,8)                                            00200000
     JOB1 = "//"||NAME                                                  00210000
     JOB1 = JOB1||" JOB ("MYSELF"),'"MYSELF"',CLASS=A,MSGCLASS=Q,"      00220003
     JOB2 = "//         NOTIFY="MYSELF",REGION=0M,MSGLEVEL=1"           00230000
     JOB3 = "//*"                                                       00240000
     JOB4 = "//*       -DOC- "USERID() "   " DATE() "   " TIME()        00250000
     JOB5 = "//*       -LIB- "DSN"("MBR")"                              00260000
     JOB6 = "//*       -PURPOSE -_____________________________________" 00270002
     JOB7 = "//*             _________________________________________" 00280000
     JOB8 = "//*" || COPIES('-', 66) || "*//";                          00281007
 "ISREDIT LINE_AFTER 0 = (JOB8)"                                        00291007
 "ISREDIT LINE_AFTER 0 = (JOB3)"                                        00300000
 "ISREDIT LINE_AFTER 0 = (JOB7)"                                        00310000
 "ISREDIT LINE_AFTER 0 = (JOB7)"                                        00320000
 "ISREDIT LINE_AFTER 0 = (JOB6)"                                        00330000
 "ISREDIT LINE_AFTER 0 = (JOB3)"                                        00340000
 "ISREDIT LINE_AFTER 0 = (JOB5)"                                        00350000
 "ISREDIT LINE_AFTER 0 = (JOB4)"                                        00360000
 "ISREDIT LINE_AFTER 0 = (JOB3)"                                        00370000
 "ISREDIT LINE_AFTER 0 = (JOB8)"                                        00380005
 "ISREDIT LINE_AFTER 0 = (JOB2)"                                        00390000
 "ISREDIT LINE_AFTER 0 = (JOB1)"                                        00400000
