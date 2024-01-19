/*     REXX                     */
/*    copy samples for system/rexx and comile rexx             */
/***************************************************************/
trace('o')
arg lbid .
uid = sysvar(sysuid)
say "Populating sysrexx lab datasets..."
say userid()".REXXLIB..."
say userid()".REXXJCL..."
uid = sysvar(sysuid)
/* */
adlib = userid()".REXXLIB(JC)"
if sysdsn("'"adlib"'") = "OK" then do
   if sysvar(sysispf) = "ACTIVE" then do
      say "ES52 sysrexx is already setup."
   end
   else queue "es52"
   exit
end
makebuf
queue "//"uid"C JOB 10000000,'SETUP JOB',CLASS=L,"
queue "// MSGCLASS=Q,REGION=0M,NOTIFY="uid""
queue "//*"
queue "//STEP1  EXEC PGM=IEBCOPY"
queue "//SYSPRINT DD  SYSOUT=*"
queue "//LIBIN    DD  DSN=D80WW.ES52V5.REXXLIB,DISP=SHR"
queue "//JCLIN    DD  DSN=D80WW.ES52V5.REXXJCL,DISP=SHR"
queue "//LIBOUT   DD  DSN="uid".REXXLIB,DISP=SHR"
queue "//JCLOUT   DD  DSN="uid".REXXJCL,DISP=SHR"
queue "//SYSIN    DD  *"
queue " COPY I=((LIBIN,R)),O=LIBOUT"
queue " COPY I=((JCLIN,R)),O=JCLOUT"
queue "//*"
queue "$$ "
queue ""
x = outtrap('lst.')
"SUB * END($$)"
x = outtrap('off')
if rc ¬= 0 then do
   say "Unable to populate dataset" adlib"."
   call mislib
end
      say "job submitted to populate REXXLIB and REXXJCL...."
      say "look with ISPF 3.4 if REXXLIB and REXXJCL are here..."
exit 0
mislib:
arg chds
"DROPBUF"
say copies('*',40)
say copies('=',40)
say "Dataset" chds "does not exist or is not available."
say "Please notify instructor."
say copies('=',40)
say copies('*',40)
exit 12
