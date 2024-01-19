/* REXX ***************************************************************/
/*    Procedure: REXX                                                 */
/*  Description: Run REXX commands interactively...                   */
/*               Property of IBM  (C) Copyright IBM Corp. 1998        */
/*    Format is: rexx < only_one_cmd >                                */
/**********************************************************************/

Trace o
Parse Arg first_cmd, sec_parm, thr_parm
Parse Source . . name . . . . omvs .
omvs = (omvs="OMVS")
not_omvs = (omvs=0)
not_sysc = 0
If not_omvs Then Do
  If Syscalls("ON")>4 Then not_sysc = 1
End
only_once = (first_cmd<>"")
Call Run_Loop
Exit 998

Run_Loop:
  Signal On Syntax
  Do Forever
    If only_once Then cmdline = first_cmd
    Else Do
      Say "REXX - Enter SH, Syscall, TSO, rexx commands or EXIT:"
      Parse External cmdline 1 endtest .
    End
    rc = 0
    If Translate(endtest)="EXIT" Then Call Final_Exit
    Parse Var cmdline env env_cmd
    Upper env
    Select
      When Abbrev("SYSCALL",env,1) & not_sysc Then
        Say "Environment ""SYSCALL"" is not available."
      When Abbrev("SYSCALL",env,1) & env_cmd="" Then Nop
      When Abbrev("SYSCALL",env,1) Then Do
        Interpret "Address SYSCALL" env_cmd
        Select
          When rc>=0 Then Do
            Say "OMVS Return Value (retval) =" retval
            If errno<>0 | errnojr<>0 Then Do
              Say "OMVS Return Code (errno )  =" errno
              Say "OMVS Reason Code (errnojr) =" errnojr
            End
          End
          When rc=-20 Then Say "Command not recognized or improper",
            "number of parameters specified..."
          When rc<-20 Then Say "Parameter number" (-20-rc) "of the",
            "SYSCALL command is in error."
          When rc<0 Then Say "The command did not finish successfully."
          Otherwise Nop
        End
      End
      When env="SH" & not_omvs Then
        Say "Environment ""SH"" is not supported from TSO/ISPF."
   /* When env="SH" Then Interpret "address sh" env_cmd  */
      When env="SH" Then address sh env_cmd
      When env="TSO" & omvs Then Do
        Say "Environment ""TSO"" is not supported from the Shell."
        Say "Please use: sh ""tso ...""."
      End
      When env="TSO" Then Interpret "Address TSO" env_cmd
      When env="MVS" Then Interpret "Address MVS" env_cmd
      When Abbrev("REXX",env) Then Interpret cmdline
  /*  Otherwise   Interpret cmdline    */
  /*      Otherwise   address sh cmdline  */
          Otherwise    cmdline
      end
    End
    If rc<>0 Then Say "Rc("||rc||")"
    Else Say ""
    If only_once Then Call Final_Exit rc
  End
Return

Syntax:
  Say Errortext(rc)
  Say "Rc("||rc||")"
  If only_once Then Call Final_Exit
  Else Call Run_Loop
Exit 999

Final_Exit:
Parse Arg final_rc
If final_rc="" Then final_rc = 0
Exit final_rc
