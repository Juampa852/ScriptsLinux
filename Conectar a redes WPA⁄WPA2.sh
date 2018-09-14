#!/bin/sh
#$1 = SSID de la red
#$2 = Contraseña de la red
#$3 = Interfaz de conexion, por lo general es wlan0
echo "Guardando configuración en /etc/wpa_supplicant/"$1".conf"
wpa_passphrase $1 $2 > /etc/wpa_supplicant/$1.conf
cat /etc/wpa_supplicant/$1.conf
echo "Tratando de conectar a "$1
wpa_supplicant -i $3 -D wext -c/etc/wpa_supplicant/$1.conf &
dhclient $3
echo "Configuración terminada, verifique los mensajes anteriores"
exit
