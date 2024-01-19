/* REXX */                                                              00010000
   Trace Off                                                            00020000
   /*%COPYRIGHT IBM Corp. 2016 */                                       00030003
   parse VERSION v ; say v                                              00030103
    Address 'TSO'                                                       00031000
    Say " "                                                             00040000
    Say "+------------------------+"                                    00050000
    Say '| hello' userid() '!        |'                                 00060000
    Say '| hello' SYSVAR(SYSUID) '!        |'                           00061002
    Say "+------------------------+"                                    00070000
    Say " "                                                             00080000
   Exit                                                                 00090000
