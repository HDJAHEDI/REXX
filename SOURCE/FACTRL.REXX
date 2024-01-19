/* Rexx exec factrl will calculate factorials and display them          00010000
   over the specified range.                                            00020000
   This is an exercise in Rexx programming, not mathematics.  The       00030000
   factorials are done in the obvious way. */                           00040000
Signal On Novalue                                                       00050000
ADDRESS TSO "CLRSCRN";                                                  00051002
/* Trace N >> rc=4 from compiler "Unsupported TRACE options" */         00060000
Parse Upper Arg first last width digits                                 00070000
If first = '' Then first = 1                                            00080000
If last = '' Then last = 10                                             00090000
If width = '' Then width = 79                                           00100000
If digits = '' Then digits = 10000                                      00110000
If ¬Datatype(first,'N') Then Call parm_error 'first'                    00120000
If ¬Datatype(last,'N') Then Call parm_error 'last'                      00130000
If ¬Datatype(width,'N') Then Call parm_error 'width'                    00140000
If ¬Datatype(digits,'N') Then Call parm_error 'digits'                  00150000
If first < 0 Then first = last + first                                  00160000
Say "Program FACTRL will calculate calculate factorials, starting",     00170000
    "at" first                                                          00180000
Say "                      continuing to" last                          00190000
Say "               for a print width of" width                         00200000
Say "      numeric digits will be set to" digits                        00210000
Parse Version parseversion /* Use Parse Version to see if compiled  */  00220000
If Left(parseversion,5)='REXXC' Then                                    00230000
    Say "This exec compiled"                                            00240000
Else                                                                    00250000
    Say "This exec interpreted"                                         00260000
Say "Parse Version gives:" parseversion                                 00270000
Parse Source parsesource                                                00280000
Say "Parse Source gives:" parsesource                                   00290000
Numeric Digits digits                                                   00300000
Parse Numeric parsenumeric                                              00310000
Say "Parse Numeric gives:" parsenumeric                                 00320000
width_plus_1 = width + 1                                                00330000
factorial = 1                                                           00340000
syscpu_start = SYSVAR('SYSCPU')                                         00350000
syssrv_start = SYSVAR('SYSSRV')                                         00360000
Do i = 1 To last                                                        00370000
   factorial = factorial + i   /* not factorial !! */                   00380000
   If i >= first Then                                                   00390000
      Do /* print it out */                                             00400000
         Say "Factorial" i "is" Length(factorial) "digits long"         00410000
         rest = factorial                                               00420000
         Do over_lines = 1 Until rest = ""                              00430000
            Parse Var rest line =(width_plus_1) rest                    00440000
            Say line                                                    00450000
         End over_lines                                                 00460000
      End                                                               00470000
End i                                                                   00480000
syscpu_finish = SYSVAR('SYSCPU')                                        00490000
syssrv_finish = SYSVAR('SYSSRV')                                        00500000
Say Left('',14) "Start      Finish    Difference"                       00510000
Say "SYSCPU:" Right(syscpu_start,12) Right(syscpu_finish,12),           00520000
    Right(syscpu_finish-syscpu_start,12)                                00521000
Say "SYSSRV:" Right(syssrv_start,12) Right(syssrv_finish,12),           00530000
    Right(syssrv_finish-syssrv_start,12)                                00531000
Exit 0                                                                  00540000
                                                                        00550000
/*----------------------------------------------------------------------00560000
 subroutine parm_error follows here:                                    00570000
 ---------------------------------------------------------------------*/00580000
parm_error:                                                             00590000
Arg parm_with_problem                                                   00600000
Say "This parameter ("parm_with_problem") is supposed to be a number",  00610000
    "but is not.  You entered:" Value(parm_with_problem)                00620000
If Left(Value(parm_with_problem),7) = "NOVALUE" Then                    00630000
   Say deliberatenovalue error requested here                           00640000
Exit 8                                                                  00650000
/*----------------------------------------------------------------------00660000
 novalue error cleanup code follows here:                               00670000
 ---------------------------------------------------------------------*/00680000
novalue:                                                                00690000
Signal Off Error                                                        00700000
Signal Off Novalue                                                      00710000
Address TSO "DELSTACK" /* must clear the stack */                       00720000
Say 'uninitialized variable used, at source line=',                     00730000
    sigl                                                                00740000
If Sourceline() = 0 Then                                                00750000
    Say "Sorry: source not available under compiler"                    00760000
Else                                                                    00770000
    Say Sourceline(sigl)                                                00780000
Say "The variable name was:" Condition('D')                             00790000
Exit 30                                                                 00800000
