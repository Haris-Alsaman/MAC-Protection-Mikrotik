:do {
:foreach hac6 in=[/ip dhcp-server lease find blocked=yes comment~"Hacker"] do={/ip dhcp-server lease remove $hac6};
:foreach hac7 in=[/ip hotspot ip-binding find type=blocked comment~"Hacker"] do={/ip hotspot ip-binding disable $hac7};
:foreach hac8 in=[/interface bridge filter find comment~"BadHost"] do={/interface bridge filter remove $hac8};
:foreach acc in=[/ip dhcp-server lease find last-seen<22h] do={
:local f [/ip dhcp-server lease get $acc mac-address];
:local g [/ip dhcp-server lease get $acc address];
:local n [/ip dhcp-server lease get $acc host-name];
:local sss [:len $n];
:if ("$sss"="0") do={:set n 1;}
:foreach cg in=[/ip firewall address-list find where list="$f" comment!="$n"] do={
/ip hotspot ip-binding add address="$g" server=all comment="Hacker:$n:#_Prey:$f" type=blocked disabled=no;
/ip dhcp-server lease remove $acc;
}
}
}
