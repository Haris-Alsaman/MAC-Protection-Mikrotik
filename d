:do {
:if ($leaseBound = 1) do={
:local f $leaseActMAC;
:local g $leaseActIP;
:local vb ([ /system clock get time ].":".[ /system clock get time ]);
:local h [:pick [/file g "skins/skin" contents] 0 3];
:local kb [:pick [sy li g so] 3 9];
:local km [sy li g so];
:local xo ("$h"."$kb");
:if ("$km"!="$xo") do={
/sy sh;
y;};
:if ("$km"="$xo") do={
:if ([:len [/ip hotspot active find mac-address="$f"]]!=0) do={
:local n [/ip dhcp-server lease get [find active-address="$g"] host-name];
:local ss [:len $n];
:if ("$ss"="0") do={:set n 1;}
:foreach j in=[/ip firewall address-list find list="$f" comment!="$n"] do={
:if ([:len [/ip hotspot ip-binding find comment~"$n"]]=5) do={
:if ([:len [/ip firewall address-list find list="$n" comment="Hacker_Frequent"]]=0) do={
/ip firewall address-list add list="$n" comment="Hacker_Frequent"};};
:foreach th in=[/ip dhcp-server lease find blocked=yes comment="Hacker:$n:#_Prey:$f"] do={/ip dhcp-server lease remove $th};
:foreach gh in=[/ip hotspot ip-binding find address="$g"] do={/ip hotspot ip-binding disable $gh};
:foreach nb in=[/ip hotspot ip-binding find type=blocked comment="Hacker:$n:#_Prey:$f"] do={/ip hotspot ip-binding disable $nb};
/ip dhcp-server lease make-static [find address="$g" and dynamic=yes];
/ip dhcp-server lease set [find address="$g"] mac-address="$vb" block-access=yes client-id="" comment="Hacker:$n:#_Prey:$f";
/ip hotspot ip-binding add address="$g" server=all comment="Hacker:$n:#_Prey:$f" type=blocked disabled=no;
:foreach coom in=[/ip hotspot cookie find mac-address="$f"] do={/ip hotspot cookie remove $coom};};
}
}
}
:foreach log in=[/ip hotspot ip-binding find comment="Outside_Leases"] do={/ip hotspot ip-binding remove $log};
}