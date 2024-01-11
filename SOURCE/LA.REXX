/* REXX */
Parse Upper Arg reqdd reqdsn reqdir
If REQDD = '' Then
   Do
      Say 'ENTER THE DDNAME'
      Pull reqdd
      Say 'ENTER THE DATASET TO BE CONCATENATED or REMOVED'
      Parse Upper Pull reqdsn
      Say "ENTER THE DIRECTION OF 'FRONT', 'BACK' or 'REMOVE'"
      Parse Upper Pull reqdir
   End /* Then Do */
Select
  When Abbrev('FRONT',reqdir,1) Then
    reqdir = 'F'
  When Abbrev('BACK',reqdir,0) Then
    reqdir = 'B'
  When Abbrev('REMOVE',reqdir,1) Then
    reqdir = 'R'
  When Abbrev('DELETE',reqdir,1) Then
    reqdir = 'R'
  Otherwise
    Say 'DIRECTION SHOULD BE FRONT OR BACK'
    Exit 108
End /* Select */
If Left(reqdsn,1) = "'" Then
  Parse Var reqdsn "'" REQDSN "'"
Else
  reqdsn =  Userid() || "." || reqdsn
dslist = ''
x = Outtrap('LINE.')
'LISTALC STATUS'
x = Outtrap('OFF')
Do N = 2 To line.0
  Parse Var line.n dataset ddname
  If ddname = '' Then
    Do
      n = n + 1
      Parse Var line.n 3 ddname 12
    End
  If ddname <> '' Then  currdd = ddname
  If currdd = reqdd Then
    If reqdsn <> dataset  Then
      dslist = dslist "'"dataset"'"
End
Select
  When reqdir = 'F' Then
    dslist = "'"REQDSN"'" dslist
  When reqdir = 'B' Then
    dslist = dslist "'"reqdsn"'"
  Otherwise Nop
End
If dslist = '' Then
  "FREE DD("reqdd")"
Else
  DO
  SAY 'ALLOC DD('reqdd') DA('dslist') SHR REU';
      'ALLOC DD('reqdd') DA('dslist') SHR REU';
  END
