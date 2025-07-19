#!/bin/bash
### Thanks to Eddie the engineer for providing examples on how to flash Klipper on different devices!!!

cat << "EOF" 
###########################################################################################################################

██████╗  ██████╗ ██╗   ██╗██████╗ ██╗     ███████╗████████╗
██╔══██╗██╔═══██╗██║   ██║██╔══██╗██║     ██╔════╝╚══██╔══╝
██║  ██║██║   ██║██║   ██║██████╔╝██║     █████╗     ██║   
██║  ██║██║   ██║██║   ██║██╔══██╗██║     ██╔══╝     ██║   
██████╔╝╚██████╔╝╚██████╔╝██████╔╝███████╗███████╗   ██║   
╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚══════╝╚══════╝   ╚═╝   
                                                           
###########################################################################################################################
EOF

echo "Stopping Klipper..."
sudo service klipper stop
echo "Klipper has stopped"

cat << "EOF" 
############################################################################################################################

██████╗  █████╗ ███████╗██████╗ ██████╗ ███████╗██████╗ ██████╗ ██╗   ██╗    ██████╗ ██╗
██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝    ██╔══██╗██║
██████╔╝███████║███████╗██████╔╝██████╔╝█████╗  ██████╔╝██████╔╝ ╚████╔╝     ██████╔╝██║
██╔══██╗██╔══██║╚════██║██╔═══╝ ██╔══██╗██╔══╝  ██╔══██╗██╔══██╗  ╚██╔╝      ██╔═══╝ ██║
██║  ██║██║  ██║███████║██║     ██████╔╝███████╗██║  ██║██║  ██║   ██║       ██║     ██║
╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝       ╚═╝     ╚═╝
                                                                                        
############################################################################################################################
EOF


### Flash Raspberry Pi linux Processor
echo "Start processing for Raspberry Pi"
make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make flash  KCONFIG_CONFIG=config.rpi
if [ $? -eq 0 ]; then
   echo "*** Successfully flashed linux process for Raspberry Pi"
else
   echo "*** Unable to flash linux process for Raspberry Pi"
fi

cat << "EOF" 
############################################################################################################################

██╗     ███████╗██╗   ██╗██╗ █████╗ ████████╗██╗  ██╗ █████╗ ███╗   ██╗
██║     ██╔════╝██║   ██║██║██╔══██╗╚══██╔══╝██║  ██║██╔══██╗████╗  ██║
██║     █████╗  ██║   ██║██║███████║   ██║   ███████║███████║██╔██╗ ██║
██║     ██╔══╝  ╚██╗ ██╔╝██║██╔══██║   ██║   ██╔══██║██╔══██║██║╚██╗██║
███████╗███████╗ ╚████╔╝ ██║██║  ██║   ██║   ██║  ██║██║  ██║██║ ╚████║
╚══════╝╚══════╝  ╚═══╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
                                                                       
############################################################################################################################
EOF

### Flash the Leviathan via USB...
echo "Start processing for the Leviathan..."
make clean KCONFIG_CONFIG=config.leviathan
make menuconfig KCONFIG_CONFIG=config.leviathan
make -j4 KCONFIG_CONFIG=config.leviathan
make flash KCONFIG_CONFIG=config.leviathan FLASH_DEVICE=/dev/serial/by-id/usb-Klipper_stm32f446xx_27004F000A51313133353932-if00
if [ $? -eq 0 ]; then # Sometimes the MCU is stuck in DFU mode...
   echo "*** Successfully flashed Leviathan"
else
   echo "*** Unable to flash via serial path, attempting via USB device ID..."
   make flash KCONFIG_CONFIG=config.leviathan FLASH_DEVICE=0483:df11
fi

cat << "EOF" 
############################################################################################################################

███╗   ██╗██╗████████╗███████╗██╗  ██╗ █████╗ ██╗    ██╗██╗  ██╗
████╗  ██║██║╚══██╔══╝██╔════╝██║  ██║██╔══██╗██║    ██║██║ ██╔╝
██╔██╗ ██║██║   ██║   █████╗  ███████║███████║██║ █╗ ██║█████╔╝ 
██║╚██╗██║██║   ██║   ██╔══╝  ██╔══██║██╔══██║██║███╗██║██╔═██╗ 
██║ ╚████║██║   ██║   ███████╗██║  ██║██║  ██║╚███╔███╔╝██║  ██╗
╚═╝  ╚═══╝╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝         

############################################################################################################################
EOF

### Flash the SB2040 via CAN Boot...
#echo "Start processing for the Fly-sht36..."
#make clean KCONFIG_CONFIG=config.sht36v2.7a268842af31
#make menuconfig KCONFIG_CONFIG=config.sht36v2.7a268842af31
#make -j4 KCONFIG_CONFIG=config.sht36v2.7a268842af31
#python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u 7a268842af31


### Flash the SB2040 via CAN Boot...
#echo "Start processing for the SB2040..."
#make clean KCONFIG_CONFIG=config.sb2040
#make menuconfig KCONFIG_CONFIG=config.sb2040
#make -j4 KCONFIG_CONFIG=config.sb2040
#python3 ~/CanBoot/scripts/flash_can.py -i can0 -f ~/klipper/out/klipper.bin -u d063055012c2

echo "Starting Klipper..."
sudo service klipper start
echo "Klipper has started"
