/* rexx  */                                                             00010000
 if syscalls('ON') <> 0  then                                           00020000
   say 'Error dubbing'  mvsvar('SYMDEF',JOBNAME)                        00030000
  address SYSCALL 'getmntent'  'm.'                                     00040000
  do i=1 to  m.0                                                        00050000
     if m.MNTE_FSTYPE.i = 'HFS' |   m.MNTE_FSTYPE.i = 'ZFS' then        00060001
        say m.MNTE_FSTYPE.i m.MNTE_FSNAME.i m.MNTE_PATH.i               00070000
  end                                                                   00080000
                                                                        00090000
