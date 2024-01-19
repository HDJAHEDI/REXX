/* REXX ***************************************************************/
/*    Procedure: TSOFULL                                              */
/*  Description: Catch and Display TSO Line output with BROWSE        */
/*               Property of IBM  (C) Copyright IBM Corp. 1998        */
/*    Format is: tsofull tso_cmd                                      */
/**********************************************************************/

Trace O
Parse Arg tso_cmd
dsn_name = "'"||Userid()||".TEMPDATA'"
Call Msg "OFF"
"ALLOC DD(FULLDATA) DSN("dsn_name") OLD REUSE"
Call Msg "ON"
If rc<>0 Then Do
  "ALLOC DD(FULLDATA) DSN("dsn_name") LRECL(255) RECFM(V B) CYLINDERS",
  "SPACE(2,2) RELEASE CATALOG DSORG(PS) NEW REUSE UNIT(SYSALLDA)"
  If rc<>0 Then Exit
End

tso.0 = 0
Call OUTTRAP "TSO."
tso_cmd
retc = rc
Call OUTTRAP "OFF"
If retc<>0 Then Do
  tso00 = tso.0 + 1
  tso.tso00 = ""
  tso00 = tso00 + 1
  tso.tso00 = "*** Returncode given was:" retc
  tso.0 = tso00
End
"EXECIO" tso.0 "DISKW FULLDATA (STEM TSO. FINIS"
"FREE DD(FULLDATA)"
If tso.0>0 Then Address ISPEXEC "BROWSE DATASET("||dsn_name||")"
Exit
