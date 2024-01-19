/**** REXX *****************************************************/
/*     REXX                                                    */
/*    copy samples for system/rexx and compile rexx            */
/***************************************************************/
trace('o')
uid = sysvar(sysuid)
HLQ = USERID() || '.ES52';
say "Populating sysrexx lab datasets..."
say HLQ || ".REXXLIB..."
say HLQ || ".REXXJCL..."
uid = sysvar(sysuid)
/* */
adlib = HLQ || ".REXXLIB(JC)"
libd  = HLQ || ".REXXLIB"
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
queue "//LIBOUT   DD  DSN="uid".ES52.REXXLIB,DISP=SHR"
queue "//JCLOUT   DD  DSN="uid".ES52.REXXJCL,DISP=SHR"
queue "//SYSIN    DD  *"
queue " COPY I=((LIBIN,R)),O=LIBOUT"
queue " COPY I=((JCLIN,R)),O=JCLOUT"
queue "//*"
queue "$$ "
queue ""
x = outtrap('lst.')
"SUB * END($$)"
x = outtrap('off')
if rc /= 0 then do
   say "Unable to populate dataset" adlib"."
     "DROPBUF"
     say copies('*',40)
     say copies('=',40)
     say "Dataset" libd "does not exist or is not available."
     say "Please notify instructor."
     say copies('=',40)
     say copies('*',40)
     exit 12
     end
      say "job submitted to populate REXXLIB and REXXJCL...."
return 0
