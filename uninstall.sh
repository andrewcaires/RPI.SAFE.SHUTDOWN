#!/bin/bash

if [ "$(id -u)" != "0" ];
    then
        echo "Este script deve ser executado como root."
        exit 1
fi

rm -f /andrewcaires/rpisafeshutdown.py

sed -i '/rpisafeshutdown/d' /etc/rc.local

echo "Desinstalacao completa."

for i in 5 4 3 2 1; do
    echo "Reiniciando em: $i"
    sleep 1
    tput cuu1; tput dl1
done

echo "Reiniciando..."

shutdown -r now