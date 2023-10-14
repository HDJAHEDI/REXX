[Profile]
ID=WS
Version=9
[Telnet3270]
HostName=essmvs1.ilsvpn.ibm.com
Backup1HostName=10.31.188.178
Security=N
CertSelection=AUTOSELECT
AutoReconnect=Y
LastConfigHostDoesNotTimeout=N
Backup2HostName=
[Communication]
Link=telnet3270
[LT]
IgnoreWCCStartPrint=Yes
[3270]
ScreenSize=32x80
HostGraphics=Y
QueryReplyMode=Auto
HostCodePage=037-U
[Keyboard]
CuaKeyboard=1
Language=United-States
DefaultKeyboard=C:\Users\IBM\REXX\Keymap.kmp
IBMDefaultKeyboard=N
[LastExitView]
A=4 78 78 896 506 7 13 26 400 0 IBM3270— 37
[Window]
ViewFlags=CF00
CaptionFormat=2E -
UserTitle=ESSMVS1 / TSOE
RuleLinePos=0 1
[File]
PromptOnExit=Y
[Transfer]
DefaultDirectory=C:\Users\IBM\Documents
PacketSize=8000
PCCodePage=1252
XferTypesMVS1=text~( ASCII CRLF  )
XferTypesMVS2=binary~( RECFM(V)  )
XferTypesMVS3=append~( ASCII CRLF APPEND  )
[Colors]
OtherRuleLine=FFFF00
[Edit]
TrimRectSizingHandles=N
TrimRectJumpToChar=N
TrimRectAsSolid=Y
ClipWhenTrimRectOnly=Y
[Macro]
DIR=C:\Users\IBM\REXX
