/* rexx exec to display the current data stack */
Address TSO 'CLRSCRN'
mark. = 0
ent.0 = Queued()
'QSTACK'
stknum = rc
'QBUF'
bufcnt = rc
Say '+---------------+'
Say '| Stack' stknum 'Image |'
Say '+---------------+'

/* Display and store stack items */
Do N = Ent.0 To 1 By -1
  bef = rc
  Parse Pull Ent.n
  'QBUF'
  aft = rc
  mark.n = bef - aft

  /* display marks found on the stack */
  Do m = bef To aft+1 By -1
    Say m || '>'
  End

  Say ' ' ent.n
End

/* display marks remaining on stack */
'QBUF'
Do N = rc To 1 By -1
  Say n || '>'
End

/* put the items and marks back on the stack */
Do n = 1 To ent.0
  Push ent.n
  Do mark.n
    'Makebuf'
  End
End
Say '0>'          /* display the end of the stack */
