#!/bin/bash
#formatting drive in fdisk
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
o
n



+512M
t
82
n




w
q
EOF
#
#properly format main drive
mkfs.ext4 /dev/sda2
#making and mounting swap
mkswap /dev/sda1
swapon /dev/sda1
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
echo -e "127.0.0.1 \tlocalhost\n::1 \t\tlocalhost\n127.0.1.1 \thost" >> /etc/hosts
#echo 127.0.0.1 localhost ::1 localhost 127.0.1.1 host >> /etc/hosts
#update pacman
pacman -Syu --noconfirm
#network manager
pacman -S networkmanager --noconfirm
#mkinitcpio
mkinitcpio -P
#set up grub
pacman -S grub --noconfirm
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager.service