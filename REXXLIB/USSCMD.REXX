/******************************* REXX ********************************/
/* Purpose: Execute USS commands from TSO and browse results         */
/*                                                                   */
/* Syntax: USSCMD cmd                                                */
/*                                                                   */
/* Parms: cmd      - Any UNIX Systems Services Command               */
/*                                                                   */
/* Notes: Will execute USS commands, shell scripts and REXX EXECs    */
/*                                                                   */
/*                                                                   */
/*********************************************************************/
/* Test for a valid ISPF environment                                 */
/*********************************************************************/
"ISPQRY"
if RC <> 0 then
    do
     say 'A valid ISPF environment does not exist'
     exit(99)
    end
/*********************************************************************/
/* Accept USS Command (retain lower case)                            */
/*********************************************************************/
parse arg cmd
if cmd = '' then
    do
     zedlmsg = 'A valid Unix System Services command must be entered'
     address ISPEXEC
    "SETMSG MSG(ISRZ000)"
     exit(98)
    end
/*********************************************************************/
/* Allocate the BPX EXEC PDS                                         */
/*********************************************************************/
"ALLOC F(SYSUEXEC) DA('SYS1.SBPXEXEC') SHR REU"
"ALTLIB ACTIVATE USER(EXEC)"
address ISPEXEC "LIBDEF ISPPLIB DATASET ID('SYS1.SBPXPENU') STACK"
/*********************************************************************/
/* Command prefix                                                    */
/*********************************************************************/
cmdpfx = 'BPXBATCH SH'
/*********************************************************************/
/* Set STDOUT and STDERR file names                                  */
/*********************************************************************/
stdout = '/tmp/'||userid()||'-bpxbatch-stdout-'||time('s')
stderr = '/tmp/'||userid()||'-bpxbatch-stderr-'||time('s')
/*********************************************************************/
/* Allocate STDOUT and STDERR for messages and errors                */
/*********************************************************************/
if ussalloc("STDOUT" stdout) <> 0 then exit(97)
if ussalloc("STDERR" stderr) <> 0 then exit(96)
/*********************************************************************/
/* Use BPXBATCH to execute the requested UNIX System Services CMD    */
/*********************************************************************/
cmdpfx cmd
EXITRC = RC / 256
/*********************************************************************/
/* If RC <> 0 BROWSE STDERR to determine the error (if not empty)    */
/*********************************************************************/
if EXITRC <> 0 then
    do
/*********************************************************************/
/* If STDERR is not empty, set the OBROWSE file to STDERR            */
/*********************************************************************/
     if filectr("TESTERR" stderr) > 0 then
        do
         zedlmsg = 'Error during execution of command:' cmd 'RC='EXITRC
         viewfile = stderr
        end
     else
/*********************************************************************/
/* If STDERR is empty and RC>0 use STDOUT (could be a REXX EXEC)     */
/*********************************************************************/
        do
         zedlmsg = 'USS REXX EXEC or an error with:' cmd 'RC='EXITRC
         viewfile = stdout
        end
    end
else
/*********************************************************************/
/* If RC=0 browse STDOUT to review the output                        */
/*********************************************************************/
    do
     zedlmsg = 'Successful execution of command:' cmdpfx cmd
     viewfile = stdout
    end
/*********************************************************************/
/* Display message and OBROWSE the correct output file               */
/*********************************************************************/
address ISPEXEC
"SETMSG MSG(ISRZ000)"
address TSO
"OBROWSE" viewfile
/*********************************************************************/
/* Shutdown                                                          */
/*********************************************************************/
Shutdown: nop
/*********************************************************************/
/*********************************************************************/
/* Free and remove STDOUT and STDERR files                           */
/*********************************************************************/
           call ussfree "STDOUT" stdout
           call ussfree "STDERR" stderr
/*********************************************************************/
/* Free SYSUEXEC                                                     */
/*********************************************************************/
          "ALTLIB DEACTIVATE USER(EXEC)"
          "FREE F(SYSUEXEC)"
           address ISPEXEC "LIBDEF ISPPLIB"
           exit EXITRC
/*********************************************************************/
/* Allocate STDxxx files                                             */
/*********************************************************************/
ussalloc: parse arg dd file
          "ALLOCATE FILE("dd") PATH('"file"')",
          "PATHOPTS(OWRONLY,OCREAT,OTRUNC) PATHMODE(SIRWXU)"
           ALLOCRC = RC
           if ALLOCRC <> 0 then say dd 'ALLOC Error RC='ALLOCRC
           return ALLOCRC
/*********************************************************************/
/* Free and remove STDxxx files                                      */
/*********************************************************************/
ussfree: parse arg dd file
         "FREE F("dd")"
          FREERC = RC
          if FREERC <> 0 then say dd 'FREE Error RC='FREERC
         "BPXBATCH SH rm -f" file
          return RC
/*********************************************************************/
/* Count the records in a USS file                                   */
/*********************************************************************/
filectr: parse arg dd file
          if ussalloc(dd file) <> 0 then return 0
/*********************************************************************/
/* Read all the lines of STDERR                                      */
/*********************************************************************/
         "EXECIO * DISKR" dd "(STEM LINES. FINIS"
          EXECIORC = RC
          if EXECIORC <> 0 then
             do
              say dd 'EXECIO DISKR Error RC='EXECIORC
              return 0
             end
         "FREE F("dd")"
          return lines.0
