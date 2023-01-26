set MCC=%MCC_INCLUDE%\..\

if "%MCC%"=="\..\" (
 echo Environment variable MCC is not set.
 echo SET MCC=[path to microchip C18 installation]
 exit /b
)

"%MCC%\bin\mcc18.exe" /p=18F45%1 %2 /i"%MCC%\h" "main-bootld.c" -fo=".\intermediate\BootLoader.o" --extended -k -O- >nul 2>&1
"%MCC%\bin\mplink.exe" -q 18f4525_g-bootld.lkr /p18F45%1 /l"%MCC%\lib" /k"." "intermediate\BootLoader.o" /u_CRUNTIME /u_EXTENDEDMODE /z__MPLAB_BUILD=1 /m"BootLoader.map" /w /o"BootLoader.cof" >nul 2>&1
copy BootLoader.hex picBootloader-hex\atommcv3-bl.hex >nul 2>&1
