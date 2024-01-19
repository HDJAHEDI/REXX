/* REXX */
parse arg jobname
rc=isfcalls('ON')
     /* Access the ST panel.  A TOKEN variable is  */
     /* created for each row which is subsequently */
     /* needed to perform actions                  */
 Address SDSF "ISFEXEC ST"
 lrc=rc
 call msgrtn  /* List any error messages */
 if lrc<>0 then
   exit 20
     /* Find a job starting with RJONES and list data sets */
 numrows=isfrows
 do ix=1 to numrows    /* Loop for all rows returned */
  if pos(jobname,JNAME.ix) = 1 then  /* If this is desired row */
    do
    say 'for job' JNAME.ix '...'
      /* Issue the ? action character for the job    */
      /* identified by the token variable.  Note     */
      /* the token must be enclosed in single quotes */
      /* Use the prefix option to ensure unique      */
      /* variables are created, beginning with JDS_  */
      Address  SDSF "ISFACT ST TOKEN('"TOKEN.ix"') PARM(NP ?)",
"("prefix JDS_
      lrc=rc
      call msgrtn
      if lrc<>0 then
        exit 20
      do jx=1 to JDS_DDNAME.0   /* loop for all rows returned */
        say "DDNAME is " JDS_DDNAME.jx
      end
      lrc=rc
      call msgrtn
       if lrc<>0 then
         exit 20
    end
 end
  rc=isfcalls('OFF')
  Exit
      /* Subroutine to list error messages */
msgrtn: procedure expose isfmsg isfmsg2.
      /* The isfmsg variable contains a short message */
if isfmsg<>"" then
  Say "isfmsg is:" isfmsg
     /* The isfmsg2 stem contains additional descriptive */
     /* error messages                                   */
do ix=1 to isfmsg2.0
  Say "isfmsg2."ix "is:" isfmsg2.ix
end
return
