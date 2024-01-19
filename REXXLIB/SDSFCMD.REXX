/* REXX to execute system commands                   */                 00010000
/*===================================================*/                 00020000
 say;say;say /* Force the say text to the next page */                  00040000
 /* Load the SDSF environment and abort on failure */                   00050000
 IsfRC = isfcalls( "ON" )                                               00060000
 say 'isfcalls rc=>'isfRC                                               00070000
 if IsfRC <> 0 then                                                     00080000
 do                                                                     00090000
   say "RC" IsfRC "returned from isfcalls( ON )"                        00100000
   say "the return RC:" IsfRC "returned from isfcalls( ON )"            00110000
   exit IsfRC                                                           00120000
 end                                                                    00130000
 /*----------------------------------------------------*/               00140000
 /* Issue the command                                  */               00150000
 /* END-OF-STMT, ISFACT, ISFEXEC.                      */               00160000
 /*----------------------------------------------------*/               00170000
 /* address SDSF "ISFEXEC '"slash_cmd"' " options      */               00180000
 parse arg sys_cmd                                                      00190000
 cmd='/'sys_cmd                                                         00200000
 say 'executing=>'cmd                                                   00210000
  address SDSF "ISFEXEC '"cmd"'"                                        00220000
  if RC <> 0 then                                                       00230000
  do                                                                    00240000
   say "RC" RC "returned from ..."                                      00250000
   call DisplayMessages                                                 00260000
 end                                                                    00270000
 /*----------------------------------------------------*/               00280000
 /* Display the user log associated with the action    */               00290000
 /*----------------------------------------------------*/               00300000
 say isfulog.0 "user log lines"                                         00310000
 do i = 1 to isfulog.0                                                  00320000
 say " '"isfulog.i"'"                                                   00330000
 end                                                                    00340000
 /*----------------------------------------------------*/               00350000
 /* Display the responses associated with the action   */               00360000
 /*----------------------------------------------------*/               00370000
 say isfresp.0 "response lines"                                         00380000
 do i = 1 to isfresp.0                                                  00390000
 say " '"isfresp.i"'"                                                   00400000
 end                                                                    00410000
/*----------------------------------------------------*/                00420000
/* Unload the SDSF environment                        */                00430000
/*----------------------------------------------------*/                00440000
call isfcalls "OFF"                                                     00450000
exit 0                                                                  00460000
/*----------------------------------------------------*/                00470000
/* Display the messages associated with the action */                   00480000
/*----------------------------------------------------*/                00490000
DisplayMessages:                                                        00500000
say "isfmsg: '"isfmsg"'"                                                00510000
say isfmsg2.0 "long messages in the isfmsg2 stem:"                      00520000
do x = 1 to isfmsg2.0                                                   00530000
say " '"isfmsg2.x"'"                                                    00540000
end                                                                     00550000
