/* REXX */
parse arg jobname
say 'viewing output of job with ISFBROWSE' jobname
rc=isfcalls("on")

     /*************************/
     /* Access the ST display */
     /*************************/
Address SDSF "ISFEXEC ST"
lrc=rc
call msgrtn
if lrc<>0 then
  exit 20
     /****************************/
     /* Loop for all RJONES jobs */
     /****************************/
do ix=1 to JNAME.0
  if JNAME.ix = jobname  then
    do
        Address SDSF "ISFBROWSE ST TOKEN('"token.ix"')"
        call msgrtn
        if rc>4 then
            exit 20
            /****************************/
            /* Loop through the lines   */
            /****************************/
        do jx=1 to isfline.0
         say isfline.jx
        end
    end
end

rc=isfcalls("off")

exit

     /*************************************/
     /* Subroutine to list error messages */
     /*************************************/
msgrtn: procedure expose isfmsg isfmsg2.
     /************************************************/
     /* The isfmsg variable contains a short message */
     /************************************************/
if isfmsg<>"" then
  Say "isfmsg is:" isfmsg
     /****************************************************/
     /* The isfmsg2 stem contains additional descriptive */
     /* error messages                                   */
     /****************************************************/
do ix=1 to isfmsg2.0
  Say "isfmsg2."ix "is:" isfmsg2.ix
end

return
