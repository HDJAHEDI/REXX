/* rexx */
trace o
call bpxwdyn "free fi(input)"
call bpxwdyn "free fi(output)"
call bpxwdyn "free fi(sysprint)"
call bpxwdyn "alloc fi(input)",
   "lrecl(80) blksize(3280) space(1,1) recfm(f,b) tracks"
call bpxwdyn "alloc fi(output)",
   "lrecl(160) space(1,1) recfm(f,b) tracks"
call bpxwdyn "alloc fi(sysprint)",
   "lrecl(160) space(1,1) recfm(f,b) tracks"
address tso     'lista'
address mvs 'execio * diskw output (fini stem out.'
call bpxwdyn "free fi(input)"
call bpxwdyn "free fi(output)"
call bpxwdyn "free fi(sysprint)"
exit
