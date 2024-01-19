/* rexx */
arg user .
 call syscalls 'ON'
address syscall
if datatype(user,'W')=1 then
   'getpwuid (user) pw.'    /* use getpwuid if UID specified     */
 else
   'getpwnam (user) pw.'    /* use getpwnam if user name speci   */
if retval<=0 then           /* check for error                   */
   do
   say 'No information available for user' user
   return 1
   end
say 'Information for user' strip(pw.pw_name)'('pw.pw_uid')'
say '  Home directory: ' strip(pw.pw_dir)
say '  Initial program:' strip(pw.pw_shell)
'getgrgid' pw.pw_gid 'gr.'
if retval<=0 then           /* check for error  */
   do
   say '  Group information not available'
   return 1
   end
say '  Primary group:  ' strip(gr.gr_name)'('gr.gr_gid')'
'getgroupsbyname' pw.pw_name 's.'
if retval<=0 then           /* check for error  */
   do
   say '  Supplemental group information not available'
   return 1
   end
say '  Supplemental GIDs:'
do i=1 to s.0
   buf=right(s.i,12)
   if i//5=0 | i=s.0 then
      buf=buf || esc_n      /* write newline every 5 groups or    */
   'write 1 buf'
end
return 0
