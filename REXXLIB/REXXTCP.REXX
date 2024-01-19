/* REXX EZARXR07 */                                                     00010000
/*                                                                      00020000
 * This sample demonstrates the use of the GETDOMAINNAME                00030000
 * socket command.                                                      00040000
 */                                                                     00050000
src = socket("INITIALIZE","MYSET01",,"TCPIP");                          00060000
if perror(src,"INITIALIZE") = 0 then do                                 00070000
 src = socket("VERSION");                                               00080000
 say "Version = " src;                                                  00090000
  src = socket("GETCLIENTID");                                          00100000
  Say " client id is: " src;                                            00110000
   Say "Domain name is : " socket("GETDOMAINNAME");                     00120000
    Say socket("GETHOSTBYADDR","127.0.0.1");                            00130000
    Say socket("GETHOSTBYNAME", "localhost");                           00140000
      src = socket("GETHOSTID");                                        00150000
         hostip = word(src,2)                                           00160000
         Say "Host ip address is: " hostip  ;                           00170000
         src = socket("GETHOSTNAME");                                   00180000
         hostname = word(src,2)                                         00190000
         Say "Host name is: " hostname  ;                               00200000
    Say "Ip address of " hostname "is:",                                00210000
      socket("GETHOSTBYNAME", hostname);                                00220000
 src = socket("RESOLVE", hostname);                                     00230000
 if word(src,1) = 0 then do                                             00240000
    Say "The Resolved host name is "WORD(src,3)                         00250000
    Say "The Resolved IP Address is "WORD(src,2);                       00260000
 end;                                                                   00270000
end;                                                                    00280000
                                                                        00290000
src = socket("TERMINATE","MYSET01");                                    00300000
src = perror(src,"TERMINATE");                                          00310000
exit 0;                                                                 00320000
                                                                        00330000
/* This routine returns -1 if the first word if arg 1 is not zero */    00340000
perror: if word(arg(1),1) = 0 then return 0; else                       00350000
    Say arg(2) "Error : "arg(1);                                        00360000
    return -1;                                                          00370000
