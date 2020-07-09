echo Enter the desired name for your VirtualBox ArchLinux
read VMName
set VM=%VMName%
echo set VM directory. Prefferably you Virtualbox VMs folder
read Path
set Directory=%Path%
mkdir "%Directory%/%VMName%"
cd "%Directory%/%VMName%"
echo Input desired size of virtual harddisk MiB Min: 2000
read diskSizeInput
set diskSize="%undefined%"
cd "%Directory%/%VMName%"
VBoxManage createhd --filename %VM%%CD%vdi --size %diskSize%
VBoxManage createvm --name %VM% --ostype ArchLinux_64 --register
VBoxManage storagectl %VM% --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach %VM% --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium %VM%%CD%vdi
echo Input Guest Additions ISO directory
read ADDDIR
set ADD=%ADDDIR%
cd "%Directory%"
VBoxManage storagectl %VM% --name "IDE Controller" --add ide
VBoxManage storageattach %VM% --storagectl "IDE Controller" --port 1 --device 1 --type dvddrive --medium "%ADD%"
echo Input Installation ISO directory
read ISODIR
set ISO=%ISODIR%
cd "%Directory%"
VBoxManage storageattach %VM% --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "%ISO%"
VBoxManage modifyvm %VM% --ioapic on
VBoxManage modifyvm %VM% --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm %VM% --memory 1024 --vram 128
VBoxManage modifyvm %VM% --firmware efi
VBoxManage modifyvm %VM% --ioapic on
VBoxManage startvm %VM%
