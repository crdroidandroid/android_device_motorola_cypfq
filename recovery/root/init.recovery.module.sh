#!/system/bin/sh

if [[ $1 == "0" ]]; then
    rmmod moto_f_usbnet
else
    insmod /lib/modules/moto_f_usbnet.ko
fi
