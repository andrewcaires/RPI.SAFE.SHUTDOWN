from subprocess import call
from gpiozero import LED, Button
from signal import pause

powerBtn = Button(3)
resetBtn = Button(2)

led = LED(14)
led.on()

power = LED(4)
power.on()

def shutdownH():
    call("sudo shutdown -h now", shell=True)

def shutdownR():
    call("sudo shutdown -r now", shell=True)

powerBtn.when_pressed = shutdownH

powerBtn.when_released = led.off

resetBtn.when_pressed = shutdownR

pause()