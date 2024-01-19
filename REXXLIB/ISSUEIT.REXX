/* Rexx
 -----------------------------------------------------------------------
-------
 Program Name    : IssueIt - Issue command & trap its output
 Version         : 1.0
 Fixes           : None
 Parameters      : (2) = command to be issued
                 : (1) = command type
                 : (3) = output dd for trapped output
                 : ex: issueit TSO LU  / issueit MVS d grs,a
 Description     : This routine issue an MVS or TSO command, traps its
output
                 : and returns in the preallocated DD provided as
parameter.
 Notes           : Pre-allocated the output file in your main program
                 : before calling the routine.
 -----------------------------------------------------------------------
--------
 */
 Trace o
 parse arg type cmd
 /*-------------------------------------------------------------------*/
 /* Define constants                                                  */
 /*-------------------------------------------------------------------*/
 lc='abcdefghijklmnopqrstuvwxyz'
 uc='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
 transl_to  ="$$$$$$$$$$$$$$$$$$$$$$$$$"
 transl_from="&%/.;:,* -+=<>()}?{!\?'?~"
 cnsec=10    /* secs to wait for reply */
 cnmax=1000  /* number of wait retries */
 parse source . . exec_name . exec_data_set . . . . /* Get exec info  */
/*--------------------------------------------------------------------*/
  /* Main Program
 */
  /*--------------------------------------------------------------------
 */
   cmd=translate(cmd,lc,uc)
   x=msg('OFF')                                     /* No messages
 */

   select
    when type='TSO' then
      do
        x= outtrap('msg.')                          /* Trap cmd output
 */
        address TSO ""cmd""                         /* TSO command
 */
        x= outtrap('OFF')                           /* Reset outtrap
 */
      end
    when type='MVS' then x=console_MVS(cmd)
    otherwise nop
   end /* end_select */

   numRec=msg.0 + 0
   if numRec > 0 then
     if ddout='' then
       do i=1 to msg.0
         say msg.i
       end
     else
      do
      ddout = 'DD'||random(1,99999)   /* choose random ddname  */
        junk = msg(off)
        "ALLOC FILE("||ddout||") UNIT(SYSALLDA) NEW TRACKS SPACE(1,1)",
        " DELETE REUSE LRECL(80) RECFM(F B) BLKSIZE(3120)"
        junk = msg(on)

     /* "EXECIO"  Queued()  "DISKW" ddout "(FINIS" */
        "EXECIO "msg.0" DISKW "ddout"(STEM msg. FINIS"
        address ISPEXEC "LMINIT DATAID(TEMP) DDNAME("||ddout||")"
        address ISPEXEC "BROWSE DATAID("||temp")"
        address ISPEXEC "LMFREE DATAID("||temp")"
        junk = msg(off)
        "FREE FI("||ddnm||")"
      end
  Return 0000
 /*-------------------------------------------------------------------*/
   /* Open MVS console and issue MVS commands
  */
   /*-------------------------------------------------------------------
  */
   Console_MVS:
     conscmd=arg(1)
     secs=TIME('S')
     not_msg=1
     cons_id = 'CON'||secs

     d = msg("OFF")
     drop msg.
     "CONSPROF UNSOLDISPLAY(NO) SOLDISP(NO) UNSOLNUM(100)"
     if rc>0  then
       do
         say '-E- CONSPROF COMMAND ERROR RC:'rc
         select
           when rc=8  then say '-E- USER HAS NOT CONSOLE AUTHORITY'
           otherwise nop
         end /* end select */
         return 0000
       end /* end rc > 0 */
     address tso "CONSOLE ACTIVATE NAME("cons_id")"
     if rc>0  then
       do
         say '-E- CONSOLE ACTIVATE ERROR RC:'rc
         select
           when rc=36 then say '-E- USER HAS NOT CONSOLE AUTHORITY'
           when rc=40 then say '-E- CONSOLE INITIALIZATION ERROR'
           otherwise nop
         end /* end select */
         return 0000
    end /* end rc > 0 */
   address tso "CONSOLE SYSCMD("conscmd") CART(F1F1)"
   if rc>0  then
     do
       say '-E- CONSOLE SYSCMD ERROR RC:'rc
       return 0000
     end /* end rc > 0 */
   getcode = getmsg('msg.','EITHER','F1F1',,cnsec)
   Do times=1 to cnmax
     if getcode=0 then
       do
         msgid= word(msg.1,1)
         /* Skip messages that lead to other msgs */
         if msgid='IST097I' | msgid='IEC351I'
           then getcode = getmsg('msg.','EITHER','F1F1',,cnsec)
         else do
           not_msg=0
           leave
         end
       end /* end getcode_0 1st */
     else
       getcode = getmsg('msg.','EITHER','F1F1',,cnsec)
   end /* end times_retries */

   address tso "CONSPROF SOLDISPLAY(YES)"
   address tso "CONSOLE DEACTIVATE"

   if not_msg then
       say '-E- CONSOLE TIMEOUT. TRY AGAIN OR CHANGE TIMEOUT SETTINGS'

  Return  0000


