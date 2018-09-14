#bin/sh
#$1 es la particion de EFI
#$2 es la particion donde esta la instalación de Linux a la cual quiere accederse
#Basado en las instrucciones en https://kali.training/forums/topic/how-to-repair-kali-linux-grub-in-pcs-with-uefi-firmware/ el 14/9/2018
mount $2 /mnt
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /sys/firmware/efi/efivars /mnt/sys/firmware/efi/efivars
echo "Tratando de crear la carpeta \'/boot/efi\' donde se montará la partición de UEFI"
mkdir /mnt/boot/efi
mount $1 /mnt/boot/efi
mount -o remount,rw $1 /mnt/boot/efi
echo "Tratando de crear la carpeta \'/hostrun\' donde se montará la partición de /run de la Live"
mkdir /mnt/hostrun
mount --bind /run /mnt/hostrun
echo "Terminado, si todo (a excepción de la creación de las carpetas que puede que ya estuvieran creadas) ha terminado sin errores, ejecute (en el orden que se muestra):"
echo "chroot /mnt     --> Esto abrirá una consola en su instalación de Linux en el disco de la PC, la cual está en la partición que indicó al ejecutar el script"
echo "mkdir /run/lvm      --> Crea la carpeta /run/lvm. Este comando puede arrojar un error, ya que puede que la carpeta ya exista"
echo "mount --bind /hostrun/lvm /run/lvm      --> Montamos /run/lvm del sistema Live, como si fuera de la instalación en disco"
echo "grub-install "$2"     --> Por último creamos el GRUB nuevamente"
echo "Si diera un error al crear el GRUB, puede que haya ingresado erroneamente alguna de las 2 particiones (que no contengan lo que se espera). Si no es el caso ejecute el comando:"
echo "rm /sys/firmware/efi/efivars/dump-*"
echo "Luego de ello ejecute de nuevo:"
echo "grub-install "$2
