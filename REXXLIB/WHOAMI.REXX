/* REXX *** */
/* find our ASCB */
aold = C2X(STORAGE(224,4))
aeye = STORAGE(aold,4)
If aeye \= 'ASCB' then DO
    SAY 'ASCB at 'aold' - Eyecatcher not ASCB'
    EXIT 8
    END
else aoldx = X2D(aold)
/* started task, mount or TSO jobs */
jbns = C2D(STORAGE(D2X(aoldx+176),4))
/* initiated jobs */
jbni = C2D(STORAGE(D2X(aoldx+172),4))
/* try to determine our execution environment */
/* has been used at MVS 4.3 and OS/390 R2     */
IF jbni = 0 then DO
    tsb  = C2D(STORAGE(D2X(aoldx+60),4))
    IF tsb = 0 then ,
        SAY 'Started task 'STORAGE(D2X(jbns),8)
    else ,
        SAY 'TSO user 'STORAGE(D2X(jbns),8)
    END
else DO
    init = STORAGE(D2X(jbns),8)
    SELECT
      WHEN init = 'INIT' then ,
          SAY 'Batch job 'STORAGE(D2X(jbni),8)
      WHEN init = 'ASCHINT' then ,
          SAY 'APPC job 'STORAGE(D2X(jbni),8)
      WHEN init = 'BPXAS' then ,
          SAY 'OMVS job 'STORAGE(D2X(jbni),8)
      OTHERWISE ,
          SAY 'Unknown job 'STORAGE(D2X(jbni),8) ,
             ' initiated by 'init
      END
    END
asxb = C2X(STORAGE(D2X(aoldx+108),4))
aeye = STORAGE(asxb,4)
If aeye \= 'ASXB' then DO
    SAY 'ASXB at 'asxb' - Eyecatcher not ASXB'
    EXIT 8
    END
else asxbx = X2D(asxb)
/* get security environment info */
senv = C2X(STORAGE(D2X(asxbx+200),4))
seye = STORAGE(senv,4)
If seye \= 'ACEE' then DO
    SAY 'ACEE at 'senv' - Eyecatcher not ACEE'
    EXIT 8
    END
else senvx = X2D(senv)
lid  = STORAGE(D2X(senvx+21),8)
SAY 'Userid is 'lid
EXIT 0
