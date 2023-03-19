# Mikrotik MAC Protection.


## Features:

 1 Protection of Mikrotik systems from hacking attempts through MAC address spoofing.
 
 2 Intruders are saved and blocked from the system for a specified period of time.
 
 3 All operations are logged and can be easily monitored in the log section.
 
 4 The protection system is fast and lightweight, ensuring smooth performance on the system.
 
 
 
 ## installation
 
 
 
  ### Add files to a file in the system
  
  
  
 --------------------------------------
  
 ### on login

```
/import v;
```



-----------------------------

### dhcp


/import d;



------------------------------

### terminal


/file remove ("skins/skin")


{
:local c [:pick [sy li g so] 0 1];
:local v [:pick [sy li g so] 8 9];
:local xo ("$c"."$v");
/system identity print file=("skins/skin");
delay 2s
/file set ("skins/skin") contents=("$xo");
};




--------------------------------


### terminal



/system scheduler
add interval=5m name=Hacker_Plas on-event=\
    "/import e;\r\
    \n:delay 2s\r\
    \n/import g;" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add interval=6d name=Hacker_Start on-event=":do {\r\
    \n:delay 1s\r\
    \n:foreach hac3 in=[ /ip dhcp-server lease find blocked=yes comment~\"Hack\
    er\" ] do={/ip dhcp-server lease remove \$hac3};\r\
    \n:foreach hac4 in=[ /ip hotspot ip-binding find type=blocked comment~\"Ha\
    cker\" ] do={/ip hotspot ip-binding remove \$hac4};\r\
    \n} on-error={}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup;



--------------------------------

### terminal

{
/ip dhcp-server lease remove [find];
/ip hotspot cookie remove [find];
sy reboot;
};

 
 --------------------------------
 
 
 ## Note: This protection was created in 2018.
