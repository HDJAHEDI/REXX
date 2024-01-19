/*  Rexx */
Parse Source . how . . . . . omvs .
If Omvs<>"OMVS" Then
   Call Syscalls 'ON'
Address syscall
"getmntent m."
Do I = 1 to m.0
  say m.mnte_path.i,
      m.mnte_dev.i,
      m.mnte_fsname.i,
      m.mnte_fstype.i
End
