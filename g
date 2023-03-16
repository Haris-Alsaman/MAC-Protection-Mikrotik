:do {
:foreach e in=[/ip firewall address-list find comment="Hacker_Frequent"] do={
:local t [/ip firewall address-list get $e list];
:if ([:len [/ip dhcp-server lease find host-name="$t"]]=1) do={
:local yf [/ip dhcp-server lease get [find host-name="$t"] mac-address];
:foreach nb in=[/interface bridge filter find comment="BadHost:$t"] do={/interface bridge filter remove $nb};
:local by [/ip dhcp-server lease get [find host-name="$t"] address];
/interface bridge filter add chain=input src-address="$by/32"\
 mac-protocol=ip action=drop comment="BadHost:$t"
/interface bridge filter add chain=output src-address="$by/32"\
 mac-protocol=ip action=drop comment="BadHost:$t"
/interface bridge filter add chain=forward src-address="$by/32"\
 mac-protocol=ip action=drop comment="BadHost:$t"
/ip dhcp-server lease remove [find host-name="$t"];
:foreach hac5 in=[/ip hotspot active find mac-address="$yf"] do={/ip hotspot active remove $hac5};
} else={/ip dhcp-server lease remove [find host-name="$t"];
}
}
}