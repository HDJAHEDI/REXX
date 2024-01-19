/* rexx LMDLISTX  */                                                    00010000
arg  level                                                              00020000
if level = '' then level =  userid()                                    00030000
say  'DSN                                         VOL    SIZE  EXT'     00040000
address  ISPEXEC                                                        00050000
"LMDINIT LISTID(LIST)  LEVEL("level")"                                  00060000
do  forever                                                             00070000
"LMDLIST LISTID("list") OPTION(LIST) DATASET(DSN)  STATS(YES)"          00080000
if RC = 8 then  leave                                                   00090000
say left(dsn,40) zdlvol zdlsize  zdlext                                 00100000
end                                                                     00110000
"LMDLIST LISTID("list")  OPTION(FREE)"                                  00120000
"LMDFREE  LISTID("list")"                                               00130000
