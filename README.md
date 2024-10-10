# HTB-Infiltrator-User-PoC
PoC for the user flag on HTB's Infiltrator machine - rated Insane difficulty. 

Warning: This contains spoilers for HTB's Infiltrator.

Requirements:
This script requires bloodyAD and impacket. It requires the use of impacket's dacledit.py.

The script may require you to change the IP of the DC if you are using a private machine, and will require you add the DC IP to your hosts file, along with `dc01.infiltrator.htb` and `infiltrator.htb`. 

Script Information:

The script automates an attack path discovered using `bloodhound-python` with the credentials found at the start of the box. We then get a TGT as d.anderson to begin the exploit. 

Once ran, the script will use impacket's getTGT.py and bloodyAD to execute commands exploiting the discovered attack path, eventually changing the password of the user `m.harris`, then loggin in as `m.harris` using an `evil-winrm` shell. 
