@echo off
echo Building AtoMMC Firmware for V4 hardware...
rmdir /s /q intermediate >nul 2>&1
mkdir intermediate
rmdir /s /q picfirmware-bin >nul 2>&1
mkdir picfirmware-bin
call genbuild
::Remove the /DV4HARDWARE to build for V3 hardware
::call picfirmware-build2.bat 25 5
call picfirmware-build2.bat 25 5 /DV4HARDWARE
rmdir /s /q intermediate
del *.cof
del *.hex
del *.lst

