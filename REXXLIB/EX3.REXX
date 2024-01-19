/* ---------------------REXX-------------------------------- *
* Exercise 3 Solution *
* --------------------------------------------------------- */
parse arg command options
Say "Command:" command
Say "Options:" options
call outtrap 'trap.'
command options
call outtrap 'off'
do i = 1 to trap.0
say trap.i
end
