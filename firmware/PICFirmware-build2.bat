set MCC=%MCC_INCLUDE%\..\

if "%MCC%"=="\..\" (
 echo Environment variable MCC is not set.
 echo SET MCC=[path to microchip C18 installation]
 exit /b
)

if not exist BIN\hexdump-d.exe (
 echo Can't find hex->binary converter.
 exit /b
)

"%MCC%\bin\mcc18.exe" -p=18F45%1 %3 /i"." -I"%MCC%\h" -pa=8 "main-atommc.c" -fo="intermediate\picFirmware.o" --extended -k -O- >nul 2>&1
"%MCC%\bin\mcc18.exe" -p=18F45%1 %3 /i"." -I"%MCC%\h" -pa=8 "atmmccore.c" -fo="intermediate\mmc2_core.o" --extended -k -O- >nul 2>&1
"%MCC%\bin\mcc18.exe" -p=18F45%1 %3 /i"." -I"%MCC%\h" -pa=8 "atmmcwfn.c" -fo="intermediate\mmc2_wfn.o" --extended -k -O- >nul 2>&1
"%MCC%\bin\mcc18.exe" -p=18F45%1 %3 /i"." -I"%MCC%\h" -pa=8 "diskio.c" -fo="intermediate\diskio.o" --extended -k -O- >nul 2>&1
"%MCC%\bin\mcc18.exe" -p=18F45%1 %3 /i"." -I"%MCC%\h" -pa=8 "mmcio.c" -fo="intermediate\mmcio.o" --extended -k --O- >nul 2>&1
"%MCC%\bin\mcc18.exe" -p=18F45%1 %3 /i"." -I"%MCC%\h" -pa=8 "ff.c" -fo="intermediate\ff.o" --extended -k -O- >nul 2>&1
"%MCC%\bin\mcc18.exe" -p=18F45%1 %3 /i"." -I"%MCC%\h" -pa=8 "wildcard.c" -fo="intermediate\wildcard.o" --extended -k -O- >nul 2>&1

"%MCC%\bin\mplink.exe" 18f4525_g-atommc.lkr /i /p18F45%1 /l"." /l"%MCC%\lib" "intermediate\picFirmware.o" "intermediate\ff.o" "intermediate\diskio.o" "intermediate\mmcio.o" "intermediate\mmc2_core.o" "intermediate\mmc2_wfn.o" "intermediate\wildcard.o" /u_CRUNTIME /u_EXTENDEDMODE /z__MPLAB_BUILD=1 /w /o"PICFirmware.cof" >nul 2>&1
BIN\HexDump-D.exe PICFirmware.hex picFirmware-bin\atommcv3.bin %2 >nul 2>&1
