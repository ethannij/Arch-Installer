#!/bin/bash
#Script Installs Arch.
#
#formatting drive in fdisk
read -p "BIOS or EFI?" type
#
if [ $type=EFI ]
then
	sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
g
n


+512M
t
1
n
2


w
q
EOF
#
#properly format main drive
mkfs.ext4 /dev/sda2
#properly format efi
mkfs.fat -F 32 /dev/sda1
#mount boot drive
mount /dev/sda2 /mnt
#install pacstrap
pacstrap /mnt base linux linux-firmware
#genfstab
genfstab -U /mnt >> /mnt/etc/fstab
#chroot
arch-chroot /mnt
#update hostname file
echo host >> /etc/hostname
#update hosts file
echo 127.0.0.1 localhost ::1 localhost 127.0.1.1 host >> /etc/hosts
#update pacman
pacman -Syu --noconfirm
#network manager
pacman -S networkmanager --noconfirm
#mkinitcpio
mkinitcpio -P
#set up grub
pacman -S grub efibootmgr --noconfirm
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager.service
echo do not forget to set root password, and create a user before rebooting
elif [ $type=BIOS ]
then
	echo "BIOS selected"
else
	echo "Invalid selection, please type BIOS or EFI"
fi
