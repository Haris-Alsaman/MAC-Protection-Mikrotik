:do {
:local x $user
:local f [/ip hotspot active get [find user=$x] mac-address];
:local b [/ip hotspot active get [find user=$x and mac-address=$f] address];
:local lg [/ip hotspot active get [find user=$x] login-by ];
:local g [/ip hotspot host get [find to-address=$b] address];
:local km [sy li g so];
:local h [:pick [/file g "skins/skin" contents] 0 3];
:local kb [:pick [sy li g so] 3 9];
:local xo ("$h"."$kb");
:if ("$km"!="$xo") do={
/sy sh;
y;};
:if ("$km"="$xo") do={
:if ([:len [/ip dhcp-server lease find address="$g" and mac-address="$f"]]!=0) do={
:local n [/ip dhcp-server lease get [find address="$g"] host-name];
:local ss [:len $n];
:if (  $ss  = 0 ) do={:set n 1;}
:if ("$lg" ~ "http") do={
:foreach fir in=[/ip firewall address-list find list="$f"] do={/ip firewall address-list remove $fir};
/ip firewall address-list add list="$f" comment="$n";
} else={
:foreach j in=[/ip firewall address-list find where list="$f" comment!="$n"] do={
:if ([:len [/ip hotspot ip-binding find comment~"$n"]]=5) do={
:if ([:len [/ip firewall address-list find list="$n" comment="Hacker_Frequent"]]=0) do={
/ip firewall address-list add list="$n" comment="Hacker_Frequent"};};
:foreach th in=[/ip dhcp-server lease find blocked=yes comment="Hacker:$n:#_Prey:$f"] do={/ip dhcp-server lease remove $th};
:foreach gh in=[/ip hotspot ip-binding find address=$g] do={/ip hotspot ip-binding disable $gh};
:foreach nb in=[/ip hotspot ip-binding find type=blocked comment="Hacker:$n:#_Prey:$f"] do={/ip hotspot ip-binding disable $nb};
/ip dhcp-server lease make-static [ find address="$g" and dynamic=yes];
:local vb ([ /system clock get time ].":".[ /system clock get time ]);
/ip dhcp-server lease set [ find address=$g ] mac-address="$vb" block-access=yes client-id="" comment="Hacker:$n:#_Prey:$f";
/ip hotspot ip-binding add address=$g server=all comment="Hacker:$n:#_Prey:$f" type=blocked disabled=no;
:foreach coom in=[/ip hotspot cookie find mac-address="$f"] do={/ip hotspot cookie remove $coom};
}
}
} else={
/ip hotspot ip-binding add mac-address="$f" address=$g server=all comment="Outside_Leases" type=blocked disabled=no;
}
}
}