/* rexx exec to allocate REXX class data sets */
Parse Source  . . . . dsn .
concat = "'"dsn"(concat)'"
student_dsn = "'"Userid()".ES52.EXEC'"
compile_dsn = "'REXX.SFANCMD'"

/* Create the student dataset if necessary */
If SYSDSN(student_dsn) = "DATASET NOT FOUND" Then
   Do
      "ALLOC DA("student_dsn") TRACK SPACE(10,5) RECFM(F B)",
          "LRECL(80)  DIR(40)  DSORG(PO)  TRACK"
      If RC <> 0 Then Call Err1
   End /* Then Do */

/* Allocate the class and student datasets to SYSEXEC */
"EXECUTIL EXECDD(CLOSE)"
"EXEC" concat "'SYSEXEC '"student_dsn"''"
"EXEC" concat "'SYSEXEC ''"dsn"'''"
If SYSDSN(compile_dsn)='OK' Then
   "EXEC" concat "'SYSEXEC '"compile_dsn"''"
"EXECUTIL EXECDD(NOCLOSE)"
Exit

Err1:
  Say "Unable to create the class dataset:" student_ds
  Say "ALLOCATE terminates with a return code of" rc
  Exit rc
