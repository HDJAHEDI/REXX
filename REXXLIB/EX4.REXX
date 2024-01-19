/* ------------------------REXX----------------------------- *
* Exercise 4 Solution *
* --------------------------------------------------------- */
parse arg command options
call outtrap 'trap.'
command options
call outtrap 'off'
mydsn = userid()||.ex4.output
"Alloc f(ex4dd) ds('"mydsn"') new spa(30,30) tr",
"recfm(f b) lrecl(133) blksize(0)"
"Execio * diskw ex4dd (finis stem trap."
Address ISPExec "Browse Dataset('"mydsn"')"
"Free f(ex4dd) delete"
