/* -----------------------REXX------------------------------ *
* Exercise 5 Solution *
* --------------------------------------------------------- */
arg dataset
stat = sysdsn("'"dataset"'")
Say "Dataset: " dataset "status:" stat
if stat <> "OK" then Exit
call listdsi "'"dataset"'"
say "DSName: " sysdsname
say "Volume: " sysvolume
