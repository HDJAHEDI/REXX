/* rexx */
arg ddreq
if ddreq = '$' then do
  say 'Enter the ddname'
  pull ddreq
end
x = outtrap('line.')
'LISTALC STATUS'
x = outtrap('off')
say 'DDNAME    DATASET'
say '*****************'
do n = 2 to line.0
  parse var line.n dataset ddname
  if ddname = ''  then
    do
      n = n + 1
      parse var line.n 3 ddname 12
    end
  if ddname <> '' then currdd = ddname
  if ddreq = currdd | ddreq = '' then
     say justify(ddname,9)  dataset
end
