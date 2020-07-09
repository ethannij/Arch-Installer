#Script Installs Arch.

#formatting drive in fdisk
fdisk /dev/sda;
#new gpt table
`g`
#new partition
`n`
#default partition 1
`\n`
#default first sector size
`\n`
#512+ last sector size
`+512M`
#change type
`t`
#efi type
`1`
#new drive
`n`
#automatically partition 2
`\n`
#automatically first sector size
`\n`
#automatically last sector size
`\n`
#write changes
`w`
#properly format main drive
`mkfs.ext4 /dev/sda2`
#properly format efi
`mkfs.fat -F 32 /dev/sda1`
#mount boot drive
`mount /dev/sda2 /mnt`
#install pacstrap
`pacstrap /mnt base linux linux-firmware`
#genfstab
`genfstab -U /mnt >> /mnt/etc/fstab`
#chroot
`arch-chroot /mnt`
#update hostname file
`echo host >> /etc/hostname`
#update hosts file
`echo 127.0.0.1 localhost \n
::1 localhost \n
127.0.1.1 host >> /etc/hosts`
#update pacman
`pacman -Syu`
`\n`
#network manager
`pacman -S networkmanager`
`\n`
#mkinitcpio
`mkinitcpio -P`
#set root password
`passwd`
`root`
`root`
#set up grub
`pacman -S grub efibootmgr`
`\n`
`mkdir /boot/efi`
`mount /dev/sda1 /boot/efi`
`grub-install --target=86x_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB`
`grub-mkconfig -o /boot/grub/grub.cfg`
`exit`
echo upon next boot. systemctl start NetworkManager.service and systemctl enable NetworkManger.service
read
echo username: root, password: root
read
`reboot`
