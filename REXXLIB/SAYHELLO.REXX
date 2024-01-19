/* REXX */                                                              00010000
   Trace Off                                                            00020000
   /*%COPYRIGHT IBM Corp. 2016 */                                       00021006
   parse VERSION v ; say v                                              00022006
    Address 'TSO'                                                       00030000
    Say " "                                                             00040000
    Say "+------------------------+"                                    00050000
    Say '| hello' userid() '!        |'                                 00060003
 /* Say '| hello' SYSVAR(SYSUID) '!        |' */                        00061005
    Say "+------------------------+"                                    00070000
    Say " "                                                             00080000
   Exit                                                                 00090000
