/* Rexx macro get a member from the sample dataset

               RXGET
                            The member name used is the
                            same name as the receiving
                            member.

               RXGET mbr
                            The member  name 'mbr' is used.

               RXGET *
                            A member selection list is presented.

*/
Address ISREDIT
Sample_DSN=Strip(Sampds(),,"'")
'MACRO  (MBR)'
If mbr = '' Then
  '(mbr)=MEMBER'
Else
  If mbr='*' Then
    Do
      Address ISPEXEC
      "CONTROL ERRORS RETURN"
      "LMINIT DATASET('"Sample_DSN"') DATAID(ID)"
      "LMOPEN DATAID("id")"
      "LMMDISP DATAID("id")"
      mbr=Strip(zlmember)
      "LMCLOSE DATAID("id")"
    End /* Then Do */
Address TSO
If mbr='' Then
   Call Error2
dsn = "'" || sample_dsn || "(" || mbr || ")'"
status=SYSDSN(dsn)
If status <> 'OK' Then
   Call Error1
"ALLOC DD(RXGET) DA("dsn") SHR REUSE"
"EXECIO * DISKR RXGET 1 (STEM DATA. FINIS)"
Address ISREDIT
'CAPS OFF'
'NUM OFF'
Do n=1 To data.0
  line= data.n
  "LINE_AFTER" n-1 "=(LINE)"
End n
Address TSO
"FREE DD(RXGET)"
Exit 0

Error1:
  ZEDSMSG='Bad Member Name'
  ZEDLMSG="'"mbr"'" status
  Address ISPEXEC "SETMSG MSG(ISRZ001)"
  Exit 8

Error2:
  ZEDSMSG='No Member'
  ZEDLMSG="You must select at least one of the members to copy."
  Address ISPEXEC "SETMSG MSG(ISRZ001)"
  Exit 8
