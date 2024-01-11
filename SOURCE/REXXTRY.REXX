/* Rexx
  Use this exec to interactively run Rexx instructions or to
  simply try out an instruction or function.

  The syntax is as follows:

      12345678 (for an interactive session)
            or
      12345678 ? or HELP   (displays this message)
  ...........................................................

  12345678 will be translated to the name of this exec */

Parse Source . . us .    /* get our name     */
Parse Arg _inst          /* get any input passed on the command line */
_batch=0
If Address() = 'TSO' Then     /* get our initial default environment */
  If Sysvar('SYSENV') = 'BACK' Then        /* if TSO check for batch */
    _batch = 1
  Else Nop
Else
  If Address()='MVS' Then                /* if MVS then we are batch */
    _batch = 1
If _INST = '?'| Abbrev('HELP',Translate(_INST),1) Then Call HELP
Else args = _inst
/*  go to interactive mode */

Address TSO 'CLRSCRN'   /* this is not a standard tso command */
Say 'You may now enter REXX instructions interactively'
Say 'by following each line with <ENTER>.'
Say
Say 'Enter "EXIT" to End'

_Restart:
  Signal On Syntax         /* trap user errors */

  Parse External _inst
  Do While Translate(_inst) ¬= 'EXIT'
    If _inst <> '' Then
      Do
        If _batch Then
          Say _inst
        Call Runit args
      End
    Else
      If _batch Then
        Leave
      Else
        Say 'Enter EXIT to End'
    Say Copies('.',60)
    Parse External _inst
  End
Exit

Runit:
  Interpret _inst
  Return

Help:
  Address TSO 'CLRSCRN'   /* this is not a standard tso command */
  Do n=2 While Pos('*/',Sourceline(n))=0
    Say Translate(Sourceline(n),us,12345678)
  End
  Exit 4

Syntax:
  Say 'A syntax error has occurred!'
  Say 'IRX' || Right(rc,4,0) || 'I:' Errortext(rc)
  Say
  Say 'Please re-enter'
  Return
