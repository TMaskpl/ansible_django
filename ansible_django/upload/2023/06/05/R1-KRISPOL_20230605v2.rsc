# jun/02/2023 04:27:22 by RouterOS 6.47.10
# software id = BKFN-GD5W
#
# model = RBD52G-5HacD2HnD
# serial number = D7160C960E8B
/interface bridge
add comment="Maszyny wirtualne" name=BR_10 pvid=10 vlan-filtering=yes
add comment=iDRAC name=BR_20
add comment="Proxmox HV" name=BR_100 pvid=100 vlan-filtering=yes
add name=LAN
/interface ethernet
set [ find default-name=ether1 ] name=WAN
set [ find default-name=ether3 ] name=ether3-KPPVE01
set [ find default-name=ether4 ] name=ether4-WIFI
set [ find default-name=ether5 ] name=ether5-KPPVE02
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik station-roaming=enabled
set [ find default-name=wlan2 ] ssid=MikroTik station-roaming=enabled
/interface ipip
add allow-fast-path=no ipsec-secret=Thc401! !keepalive local-address=\
    91.188.126.137 name=ipip-TMask remote-address=178.218.232.65
/interface vlan
add interface=ether3-KPPVE01 name=vlan10-ether3 vlan-id=10
add interface=ether5-KPPVE02 name=vlan10-ether5 vlan-id=10
add interface=ether5-KPPVE02 name=vlan20 vlan-id=20
add interface=ether3-KPPVE01 name=vlan100-ether3 vlan-id=100
add interface=ether5-KPPVE02 name=vlan100-ether5 vlan-id=100
/interface bonding
add mode=802.3ad name=bonding1 slaves=ether2
/interface vlan
add interface=bonding1 name=vlan10 vlan-id=10
add interface=bonding1 name=vlan100 vlan-id=100
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
/ip ipsec profile
add dh-group=modp1536 enc-algorithm=3des name=F001
/ip ipsec peer
add address=176.107.116.230/32 disabled=yes name=ipsec-F001 profile=F001
/ip ipsec proposal
add disabled=yes enc-algorithms=3des lifetime=1d name=proposal_F001 \
    pfs-group=modp1536
/ip pool
add name=dhcp_pool0 ranges=172.16.10.2-172.16.10.254
add name=dhcp_pool1 ranges=172.16.20.2-172.16.20.254
add name=dhcp_pool2 ranges=172.16.100.2-172.16.100.254
add name=OVPN ranges=172.16.30.2-172.16.30.50
add name=dhcp_pool4 ranges=192.168.87.100-192.168.87.200
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=BR_10 name=dhcp1
add address-pool=dhcp_pool1 disabled=no interface=BR_20 name=dhcp2
add address-pool=dhcp_pool2 disabled=no interface=BR_100 name=dhcp3
add address-pool=dhcp_pool4 disabled=no interface=LAN name=dhcp5
/ppp profile
add local-address=172.16.30.1 name=OVPN remote-address=OVPN
/snmp community
set [ find default=yes ] addresses=0.0.0.0/0 authentication-password=publicTM \
    encryption-password=publicTM name=publicTM
/system logging action
set 3 remote=10.30.222.202 remote-port=1514
add name=NifiSyslog remote=10.20.222.213 remote-port=2514 target=remote
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=BR_10 interface=vlan10 pvid=10
add bridge=BR_20 interface=vlan20 pvid=20
add bridge=BR_100 interface=vlan100 pvid=100
add bridge=BR_10 interface=vlan10-ether5 pvid=10
add bridge=LAN interface=ether4-WIFI
add bridge=BR_10 interface=vlan10-ether3 pvid=10
add bridge=BR_100 interface=vlan100-ether3 pvid=100
add bridge=BR_100 interface=vlan100-ether5 pvid=100
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/interface ovpn-server server
set auth=sha1 certificate=ca.crt_0 cipher=aes256 default-profile=OVPN \
    enabled=yes
/ip address
add address=172.16.10.1/24 comment=VM interface=BR_10 network=172.16.10.0
add address=172.16.20.1/24 comment="iDRAC - Dell T140" interface=BR_20 \
    network=172.16.20.0
add address=172.16.100.1/24 comment=HV interface=BR_100 network=172.16.100.0
add address=172.16.30.1/24 comment=OVPN interface=LAN network=172.16.30.0
add address=10.1.2.2/30 interface=ipip-TMask network=10.1.2.0
add address=192.168.1.20/24 disabled=yes interface=WAN network=192.168.1.0
add address=192.168.87.1/24 interface=LAN network=192.168.87.0
add address=10.2.1.1/30 interface=ether4-WIFI network=10.2.1.0
add address=192.168.86.5/24 disabled=yes interface=ether3-KPPVE01 network=\
    192.168.86.0
/ip dhcp-client
add disabled=no interface=WAN
/ip dhcp-server lease
add address=172.16.10.2 client-id=1:d6:69:cb:23:a9:95 comment=W2K19 \
    mac-address=D6:69:CB:23:A9:95 server=dhcp1
add address=192.168.87.3 client-id=1:48:8f:5a:c8:62:1e comment=Controler \
    mac-address=48:8F:5A:C8:62:1E
add address=172.16.10.3 client-id=1:9e:82:7f:14:6:33 mac-address=\
    9E:82:7F:14:06:33 server=dhcp1
add address=192.168.87.200 client-id=1:48:8f:5a:c8:62:1e disabled=yes \
    mac-address=48:8F:5A:C8:62:1E server=dhcp5
add address=192.168.87.198 client-id=1:2c:ea:7f:df:fb:2a comment=\
    "iDRAC - Dell T140" mac-address=2C:EA:7F:DF:FB:2A server=dhcp5
add address=192.168.87.99 client-id=1:38:c4:e8:2:60:c3 comment=Rejestrator \
    mac-address=38:C4:E8:02:60:C3 server=dhcp5
/ip dhcp-server network
add address=172.16.10.0/24 dns-server=172.16.10.1 gateway=172.16.10.1
add address=172.16.20.0/24 dns-server=172.16.20.1 gateway=172.16.20.1
add address=172.16.100.0/24 dns-server=172.16.100.1 gateway=172.16.100.1
add address=192.168.87.0/24 gateway=192.168.87.1
/ip dns
set allow-remote-requests=yes servers=1.1.1.1,8.8.4.4
/ip dns static
add address=172.16.10.2 name=fs
add address=172.16.10.3 name=rdp01
/ip firewall address-list
add address=192.168.1.2-192.168.1.254 list=KRISPOL
add address=172.16.30.1-172.16.30.254 list=KRISPOL
add address=192.168.1.20 list=Router
add address=172.16.10.0/24 list=KRISPOL
add address=1.1.1.1 list=DNS
add address=8.8.4.4 list=DNS
add address=192.168.88.2-192.168.88.254 list=KRISPOL
add address=92.119.228.26 list=BLOCK
add address=77.120.47.39 list=BLOCK
add address=172.16.10.2 list=Proxy
add address=172.16.10.3 list=Proxy
add address=172.16.100.100 list=Proxy
add address=10.2.1.2 list=KRISPOL
add address=192.168.86.0/24 list=KRISPOL
add address=178.218.232.65 comment="M: biuro@tmask.pl, T: 697 670 679" list=\
    TMaskPL
add address=195.117.36.53 comment="M: biuro@tmask.pl, T: 697 670 679" list=\
    TMaskPL
add address=178.219.136.133 comment="M: biuro@tmask.pl, T: 697 670 679" list=\
    TMaskPL
add address=195.117.36.101 comment="M: biuro@tmask.pl, T: 697 670 679" list=\
    TMaskPL
add address=195.117.36.9 comment="M: biuro@tmask.pl, T: 697 670 679" list=\
    TMaskPL
/ip firewall filter
add action=accept chain=input dst-port=1194 protocol=tcp
add action=accept chain=input connection-state=established,related
add action=fasttrack-connection chain=forward connection-state=\
    established,related
add action=accept chain=forward connection-state=established,related
add action=accept chain=input comment=\
    "support.tmask.pl - mailto: biuro@tmask.pl" src-address=195.117.36.53
add action=accept chain=input comment="TMask - tel. 697 670 679" src-address=\
    178.218.232.65
add chain=input src-address-list=TMaskPL
add action=drop chain=input dst-address=91.188.126.137
add action=accept chain=input dst-address=10.1.2.2 dst-port=161,162 protocol=\
    udp
add action=accept chain=input dst-port=6556 protocol=tcp src-address=\
    10.40.222.200
add action=accept chain=forward src-address=10.20.222.207
add action=accept chain=forward dst-address=172.16.100.0/24 src-address=\
    10.40.222.200
add action=accept chain=forward src-address=10.222.10.0/24
add action=accept chain=input disabled=yes dst-address=172.16.10.1 \
    src-address=10.1.50.0/24
add action=accept chain=input dst-address=172.16.10.3 src-address=\
    10.1.50.0/24
add action=accept chain=input in-interface=WAN src-address=178.218.232.65
add action=accept chain=input dst-port=1194 in-interface=WAN protocol=tcp
add action=accept chain=input dst-address=192.168.1.20 src-address=\
    178.218.232.65
add action=accept chain=input dst-address=192.168.1.20 dst-port=1194 \
    protocol=tcp
add action=accept chain=input comment=\
    "IPsec - F001 Adam Pietrzak tel. 721 337 711" src-address=176.107.116.230
add action=accept chain=forward dst-address=172.16.10.3 src-address=\
    10.1.50.0/24
add action=accept chain=forward dst-address=10.1.50.0/24 src-address=\
    172.16.10.0/24
add action=accept chain=forward disabled=yes dst-address=10.1.50.0/24 \
    src-address=10.222.0.0/24
add action=accept chain=input comment=Proxy dst-address=172.16.10.1 dst-port=\
    8080 protocol=tcp src-address-list=KRISPOL
add action=accept chain=forward comment="VPN -> FS,SQL" dst-address=\
    172.16.10.2 src-address=172.16.30.0/24
add action=accept chain=input dst-address=172.16.10.2 dst-port=\
    139,445,3389,2121,1433 protocol=tcp src-address=172.16.30.0/24
add action=accept chain=input dst-address=172.16.10.2 dst-port=137,138,1434 \
    protocol=udp src-address=172.16.30.0/24
add action=accept chain=input comment="VPN -> RDP zdalny pulpit" dst-address=\
    172.16.10.3 dst-port=3389 protocol=tcp src-address=172.16.30.0/24
add action=accept chain=forward dst-address=172.16.10.3 src-address=\
    172.16.30.0/24
add action=accept chain=forward dst-address-list=KRISPOL src-address-list=\
    KRISPOL
add action=drop chain=input comment="BLOCK EXT IP" src-address-list=BLOCK
add action=drop chain=forward dst-address-list=BLOCK
add action=drop chain=forward connection-state=invalid,new,untracked \
    src-address=10.1.50.0/24
add action=drop chain=input icmp-options=8:0-255 in-interface=WAN protocol=\
    icmp
add action=accept chain=input src-address=10.222.0.0/24
add action=accept chain=input src-address=10.1.2.1
add action=accept chain=input src-address=10.222.10.0/24
add action=accept chain=input src-address=10.40.222.0/24
add action=accept chain=input protocol=icmp src-address=10.40.222.200
add action=accept chain=input protocol=icmp src-address=10.222.10.0/24
add action=accept chain=input dst-address=192.168.1.20 port=53 protocol=tcp \
    src-address-list=DNS
add action=accept chain=input dst-address=192.168.1.20 port=53 protocol=udp \
    src-address-list=DNS
add action=accept chain=input dst-address=192.168.1.20 port=\
    8006,22022,139,445,3389,2121,1433 protocol=tcp src-address=192.168.1.0/24
add action=accept chain=input dst-address=192.168.1.20 port=\
    8006,22022,139,445,3389,2121,1433 protocol=tcp src-address=\
    192.168.88.0/24
add action=accept chain=input dst-address=192.168.1.20 dst-address-list=\
    Router port=8006,22022,139,445,3389,2121,1433 protocol=tcp src-address=\
    172.16.30.0/24
add action=accept chain=input dst-address=192.168.1.20 dst-address-list=\
    Router port=137,138,1434 protocol=udp src-address=192.168.1.0/24
add action=accept chain=input dst-address=192.168.1.20 dst-address-list=\
    Router port=137,138,1434 protocol=udp src-address=192.168.88.0/24
add action=accept chain=input dst-address=192.168.1.20 dst-address-list=\
    Router port=137,138,1434 protocol=udp src-address=172.16.30.0/24
add action=drop chain=input dst-address=192.168.1.20 log=yes log-prefix=\
    KRIS-POL_DROP_WAN
add action=drop chain=input dst-address=83.16.124.9 log=yes port=2121 \
    protocol=tcp
add action=drop chain=forward disabled=yes log=yes log-prefix=\
    DROP_WAN_KRIS-POL out-interface=WAN port="" src-address=172.16.10.3
/ip firewall mangle
add action=mark-routing chain=prerouting disabled=yes dst-address=\
    192.168.1.20 dst-port=1194 new-routing-mark=OVPN passthrough=yes \
    protocol=tcp
add action=mark-routing chain=prerouting disabled=yes dst-address=\
    192.168.1.20 dst-port=20 new-routing-mark=OVPN passthrough=yes protocol=\
    tcp
add action=mark-connection chain=prerouting disabled=yes dst-address=\
    192.168.1.20 dst-port=22 new-connection-mark=WAN1 passthrough=yes \
    protocol=tcp
add action=mark-routing chain=prerouting connection-mark=WAN1 disabled=yes \
    dst-address=192.168.1.20 dst-port=22 new-routing-mark=OVPN passthrough=\
    yes protocol=tcp src-address=195.117.36.29
add action=mark-routing chain=prerouting disabled=yes dst-address=83.16.124.9 \
    dst-port=22 new-routing-mark=OVPN passthrough=yes protocol=tcp \
    src-address=195.117.36.29
/ip firewall nat
add action=masquerade chain=srcnat disabled=yes dst-address=172.16.10.0/24 \
    src-address=172.16.30.0/24
add action=redirect chain=dstnat disabled=yes dst-port=80 protocol=tcp \
    src-address=172.16.10.2 to-ports=8080
add action=redirect chain=dstnat disabled=yes dst-port=443 protocol=tcp \
    src-address=172.16.10.2 to-ports=8080
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=8006 protocol=tcp to-addresses=172.16.100.100 to-ports=8006
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=22022 protocol=tcp to-addresses=172.16.100.100 to-ports=22
add action=accept chain=srcnat disabled=yes dst-address=10.1.50.0/24 \
    src-address=172.16.10.0/24
add action=accept chain=srcnat disabled=yes dst-address=10.1.50.0/24 \
    src-address=10.222.0.0/24
add action=accept chain=srcnat disabled=yes dst-address=10.1.50.0/24 \
    src-address=10.40.222.0/24
add action=accept chain=dstnat disabled=yes dst-address=10.222.0.0/24 \
    src-address=10.1.50.0/24
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=137 protocol=udp src-address-list=KRISPOL to-addresses=\
    172.16.10.2 to-ports=137
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=138 protocol=udp src-address-list=KRISPOL to-addresses=\
    172.16.10.2 to-ports=138
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=139 protocol=tcp src-address-list=KRISPOL to-addresses=\
    172.16.10.2 to-ports=139
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=1433 protocol=tcp src-address-list=KRISPOL to-addresses=\
    172.16.10.2 to-ports=1433
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=1434 protocol=udp src-address-list=KRISPOL to-addresses=\
    172.16.10.2 to-ports=1434
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=445 protocol=tcp src-address-list=KRISPOL to-addresses=\
    172.16.10.2 to-ports=445
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=3389 protocol=tcp src-address-list=KRISPOL to-addresses=\
    172.16.10.2 to-ports=3389
add action=dst-nat chain=dstnat disabled=yes dst-address=192.168.1.20 \
    dst-port=2121 protocol=tcp src-address-list=KRISPOL to-addresses=\
    172.16.10.2 to-ports=2121
add action=dst-nat chain=dstnat disabled=yes dst-address=10.1.2.2 dst-port=\
    6556 protocol=tcp to-addresses=172.16.10.2 to-ports=6556
add action=masquerade chain=srcnat out-interface=WAN
/ip ipsec identity
add disabled=yes peer=ipsec-F001 secret=Rupm2021!@#
/ip ipsec policy
set 0 disabled=yes
add disabled=yes dst-address=10.1.50.0/24 peer=ipsec-F001 proposal=\
    proposal_F001 src-address=172.16.10.0/24 tunnel=yes
/ip proxy
set cache-administrator=biuro@tmask.pl enabled=yes max-cache-size=none
/ip proxy access
add dst-host=*.windowsupdate.com
add dst-host=*.update.microsoft.com
add dst-host=*.update.microsoft.com
add dst-host=*.download.windowsupdate.com
add dst-host=*.windowsupdate.microsoft.com
add dst-host=*.ntservicepack.microsoft.com
add dst-host=*.wustat.windows.com
add dst-host=*.onedrive.live.com
add dst-host=*.ubuntu.com
add dst-host=*zus.pl path=""
add dst-host=*tmask.pl
add action=deny dst-host=*
/ip route
add disabled=yes distance=1 gateway=192.168.1.1 routing-mark=OVPN
add disabled=yes distance=1 gateway=192.168.1.1
add disabled=yes distance=2 gateway=10.2.1.2
add check-gateway=ping disabled=yes distance=2 dst-address=8.8.4.4/32 \
    gateway=10.2.1.2
add check-gateway=ping disabled=yes distance=1 dst-address=8.8.8.8/32 \
    gateway=192.168.1.1
add disabled=yes distance=1 dst-address=10.1.50.0/24 gateway=176.107.116.230
add distance=1 dst-address=10.4.222.0/24 gateway=ipip-TMask
add distance=1 dst-address=10.20.222.207/32 gateway=ipip-TMask
add distance=1 dst-address=10.20.222.213/32 gateway=ipip-TMask
add distance=1 dst-address=10.30.222.202/32 gateway=ipip-TMask
add distance=1 dst-address=10.30.222.203/32 gateway=ipip-TMask
add distance=1 dst-address=10.30.222.210/32 gateway=ipip-TMask
add distance=1 dst-address=10.30.222.211/32 gateway=ipip-TMask
add distance=1 dst-address=10.40.222.200/32 gateway=ipip-TMask
add distance=1 dst-address=10.40.222.204/32 gateway=ipip-TMask
add distance=1 dst-address=10.40.222.207/32 gateway=ipip-TMask
add distance=1 dst-address=10.222.0.0/24 gateway=ipip-TMask
add distance=1 dst-address=10.222.10.0/24 gateway=ipip-TMask
add distance=1 dst-address=10.222.81.0/24 gateway=*F00026
add distance=1 dst-address=10.222.99.5/32 gateway=ipip-TMask
add distance=1 dst-address=10.222.222.235/32 gateway=ipip-TMask
add distance=1 dst-address=10.222.222.238/32 gateway=ipip-TMask
add disabled=yes distance=1 dst-address=172.16.10.0/24 gateway=10.2.1.2
add disabled=yes distance=1 dst-address=172.16.20.0/24 gateway=10.2.1.2
add disabled=yes distance=1 dst-address=172.16.29.0/24 gateway=10.2.1.2
add disabled=yes distance=1 dst-address=172.16.100.0/24 gateway=10.2.1.2
add distance=1 dst-address=192.168.88.0/24 gateway=192.168.87.3
add disabled=yes distance=1 dst-address=192.168.88.0/24 gateway=\
    192.168.87.200
/ip service
set telnet disabled=yes
set ftp disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/ppp secret
add name=fs password=FSuser123!@ profile=OVPN service=ovpn
add name=krzysztof password=KR1234!@ profile=OVPN service=ovpn
add disabled=yes name=dagmara password=DA1234! profile=OVPN service=ovpn
add name=dniemczok password=o00okapA profile=OVPN service=ovpn
add name=justyna password=JK1234ala!@ profile=OVPN service=ovpn
add disabled=yes name=mosica password=MO1234ica@@ profile=OVPN \
    remote-address=172.16.30.100 service=ovpn
add name=natalia password=NP1234erz# profile=OVPN service=ovpn
add name=alina password=TYBGD39m profile=OVPN service=ovpn
add name=tmaskcloud password=pn8JPhS0FDaBVv0ryUa profile=OVPN remote-address=\
    172.16.30.99 service=ovpn
/snmp
set contact=biuro@tmask.pl enabled=yes location=\
    "KRIS-POL Czeladz ul. Katowicka 87"
/system clock
set time-zone-name=Europe/Warsaw
/system identity
set name=KRIS-POL-R1
/system logging
set 0 action=echo disabled=yes
set 1 action=remote
set 2 action=remote
set 3 action=remote
add action=echo topics=ovpn
add action=remote disabled=yes topics=ipsec
add action=echo topics=firewall
add action=remote topics=account
add action=echo disabled=yes topics=ipsec
add action=remote topics=write
/system ntp client
set enabled=yes primary-ntp=193.70.94.126 secondary-ntp=193.219.28.147
/system package update
set channel=long-term
/tool graphing interface
add
/tool graphing resource
add
