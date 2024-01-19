/* REXX */                                                              00010000
Say 'Sysplex Name...........' Mvsvar("SYSPLEX")                         00020000
Say 'System Name............' Mvsvar("SYSNAME")                         00030000
Say 'OS Version.............' Mvsvar("SYSOPSYS")                        00040000
Say 'MVS Version............' Mvsvar("SYSMVS")                          00050000
Say 'DFP Level..............' Mvsvar("SYSDFP")                          00060000
Say 'SMS?...................' Mvsvar("SYSSMS")                          00070000
Say 'SMF Name...............' Mvsvar("SYSSMFID")                        00080000
Say 'System Clone-ID........' Mvsvar("SYSCLONE")                        00090000
Say 'JES Version............' Sysvar("SYSJES")                          00100000
Say 'JES Nodename...........' Sysvar("SYSNODE")                         00110000
Say 'HSM Version............' Sysvar("SYSHSM")                          00120000
Say 'RACF Version...........' Sysvar("SYSLRACF")                        00130000
Say 'TSO/E Version..........' Sysvar("SYSTSOE")                         00140000
Say ' '                                                                 00150000
Say '-For TSO User' Sysvar("SYSUID") ' prefix set to' Sysvar("SYSPREF") 00160000
Say '  Executing in.........' Sysvar("SYSENV")                          00170000
Say '  Using LOGON Proc.....' Sysvar("SYSPROC")                         00180000
Say '  Terminal-ID..........' Strip(Sysvar("SYSTERMID"),'L')            00190000
Say '  Terminal Lines.......' Strip(Sysvar("SYSLTERM"),'L')             00200000
Say '  Screen Width.........' Strip(Sysvar("SYSWTERM"),'L')             00210000
Say '  ISPF?................' Sysvar("SYSISPF")                         00220000
Say '  CPU Time Used........' Strip(Sysvar("SYSCPU"),'L')               00230000
Say '  SRM Time Used........' Strip(Sysvar("SYSSRV"),'L')               00240000
