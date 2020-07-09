# Virtualbox-Arch-linux-installation-script  
# Prerequisites  
-A working virtualbox (you should be able to launch VMs with no problem  
-The arch linux installation ISO - available from the archlinux.org  
-Virtualbox guest additions ISO  
-Virtualbox extension pack  
-Enough storage to install arch linux  
  
# Installation Instructions  
On host system, start virtualbox  
  
Run main.sh script (through the terminall) ex. `/bin/bash main.sh`  
  
follow the prompts  
  
When specifying ISO locations, you must specify the entire path ex. `/home/ethannij/Desktop/ArchInstallation/GuestAdditions.iso`  
  
When the arch linux installation starts type the following in the commandline -  
  
`curl -o- https://raw.githubusercontent.com/ethannij/Virtualbox-Arch-linux-installation-script/master/install.sh type | 
bash`  
  
When the installion is complete, reboot the system.  
username: root  
password: root  
  
Upon system startup, type -  
`$ systemctl start NetworkManager.service` and  
`$ systemctl enable NetworkManager.service`  
Congratulations you now have an arch linux virtual machine in less than 5 minutes.
