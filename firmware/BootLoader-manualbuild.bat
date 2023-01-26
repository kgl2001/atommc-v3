@echo off
echo Building AtoMMC Bootloader for V4 hardware...
rmdir /s /q intermediate >nul 2>&1
mkdir intermediate
rmdir /s /q picBootloader-hex >nul 2>&1
mkdir picBootloader-hex
::Remove the /DV4HARDWARE to build for V3 hardware
::call BootLoader-build2.bat 25
call BootLoader-build2.bat 25 /DV4HARDWARE
rmdir /s /q intermediate
del *.cof
del *.hex
del *.map

