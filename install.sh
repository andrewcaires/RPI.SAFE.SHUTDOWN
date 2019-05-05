#!/bin/bash

if [ "$(id -u)" != "0" ];
    then
        echo "Este script deve ser executado como root."
        exit 1
fi

sudo apt-get -y update

sudo apt-get install -y python3 python3-gpiozero

mkdir -p /andrewcaires

cd /andrewcaires

if [ -f rpisafeshutdown.py ];
    then
        rm rpisafeshutdown.py
fi

wget "https://raw.githubusercontent.com/andrewcaires/rpi.safeshutdown/master/rpisafeshutdown.py"

if grep -q "rpisafeshutdown.py" /etc/rc.local;
    then
        echo "Arquivo /etc/rc.local já configurado."
    else
        sed -i '/^exit 0/d' /etc/rc.local
        echo "sudo python3 /andrewcaires/rpisafeshutdown.py &" >> /etc/rc.local
        echo "exit 0" >> /etc/rc.local
        echo "Arquivo /etc/rc.local configurado."
fi

echo "Instalacao completa."

for i in 5 4 3 2 1; do
    echo "Reiniciando em: $i"
    sleep 1
    tput cuu1; tput dl1
done

echo "Reiniciando..."

shutdown -r now