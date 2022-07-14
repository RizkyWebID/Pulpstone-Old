@SHIFT /0
@ECHO off
COLOR A
MODE CON: COLS=57 LINES=40
TITLE Pulpstone Amlogic Update USB Tool v2.1
setlocal enabledelayedexpansion
cls

:RizkyWebID
cls
SET Timestamp=%date:~0,2%-%date:~3,2%-%date:~6,8%
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo   - Install USB Burning Tool 2.1.6 [bila belum install]
echo   - Install WorldCup Device Driver [bila belum install]
echo.
echo   - Tahan tombol power lalu colokan kabel USBtoUSB Male
echo     pada Port-2 USB di STB B860H
echo       *Tanpa Adaptor STB B860H dari PT.Panggung
echo       *Wajib Adaptor STB B860H dari PT.Industri
echo.
echo   - Lakukan Erase ( G ) Data sebelum Flashing STB
echo.
echo   Pilih : ' 0 ' Untuk Exit ( KELUAR )
echo.
echo   A.  Buka App Boot Card Maker Tools
echo   B.  Install USB Burning Tool 2.1.6
echo   C.  Install WorldCup Device Driver
echo.
echo   D.  Scan Device ( Perangkan Yang terhubung )
echo.
echo   E.  Setting EnableSelinux Permissive
echo   F.  Setting HDMI Mode 720p60hz
echo.
echo   G.  Erase Data
echo   H.  BulkCMD Reset
echo.
echo   I.  Flashing B860H V1, V2 Pulpstone
echo   J.  Flashing B860H V1, V2 RizkyWebID
echo.
echo   K.  STB Flashing ( Dari Hasil Back-UP )
echo   L.  STB Backup   ( Kloning IMG / File )
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
echo.
set /P "M=Ketikan Pilihan Anda : "
set var=%M%
if !var!==0 goto keluar

if !var!==A goto bootcardmaker
if !var!==B goto usbburningtool
if !var!==C goto worldcupdevice

if !var!==D goto scanstb

if !var!==E goto setenv
if !var!==F goto sethdmi

if !var!==G goto erasedata
if !var!==H goto resetdata

if !var!==I goto flashORI
if !var!==J goto flashRWID

if !var!==K goto dataflash
if !var!==L goto databackup

if !var!==  goto noinput

cls
goto RizkyWebID

:bootcardmaker
cls
"%SystemRoot%"\explorer.exe "%cd%"\pulpstone\BootcardMaker
cd /d "%cd%"\pulpstone\BootcardMaker
start BootcardMaker.exe
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo                  BOOTCARDMAKER TUTORIAL
echo.
echo   Indikasi STB B860 untuk dengan ciri :
echo   1.  Tampilan PuTTY ...................
echo   2.  Lampu indikator orange	 
echo   3.  Tidak terdeteksi di komputer 
echo.     
echo   Tahapan Flash Bootloader :
echo   [KHUSUS STB HANYA ERROR BOOTLOADER]  
echo   - Buat BootCardMaker SDCard Class10 file u-boot.bin 
echo   - Copy file u-boot.bin ke SDCard [main directory]
echo   - Pasang SDCard, STB ON, jika berhasil booting     
echo     Flash bootloader via PuTTY / ADB / TE [root]
echo     "dd if=uboot.bin of=/dev/block/bootloader"
echo     [perintah bila sudah berada di directory SDCard]
echo   - Matikan STB, cabut SDCard, STB ON, Finish
echo.
echo   [KHUSUS STB ERROR BOOTLOADER DAN SYSTEM]
echo   - Buat BootCardMaker SDCard Class10 file u-boot.bin 
echo   - Copy file u-boot.bin ke SDCard [main directory]   
echo   - Pasang SDCard, flash firmware via USB2USB
echo   - STB ON, jika berhasil booting
echo     Flash bootloader via PuTTY / ADB / TE [root]
echo     "dd if=uboot.bin of=/dev/block/bootloader"
echo     [perintah bila sudah berada di directory SDCard]
echo   - Matikan STB, cabut SDCard, STB ON, Finish     
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
echo.
SET /P AREYOUSURE=Press any key to exit...
GOTO keluar

:usbburningtool
cls
cd /d "%cd%"\pulpstone\USB_Burning_Tool
start setup_v2.1.6.exe
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo                  USB BURNING TOOL V2.1.6
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
echo.
SET /P AREYOUSURE=Press any key to exit...
GOTO RizkyWebID

:worldcupdevice
cls
cd /d "%cd%"\pulpstone\WorldCup_Device
start InstallDriver.exe
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo                  WorldCup Device Driver
echo                  Harap Restart Komputer
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
echo.
SET /P AREYOUSURE=Press any key to exit...
GOTO keluar

:scanstb
cls
"%cd%"\pulpstone\update.exe scan
echo.
echo   =====================================================
echo   Pastikan STB sudah terdeteksi di MPtool devices list.
echo   =====================================================
TIMEOUT /T 10
cls
GOTO RizkyWebID

:setenv
cls
"%cd%"\pulpstone\update.exe bulkcmd "setenv -f EnableSelinux permissive"
"%cd%"\pulpstone\update.exe bulkcmd "saveenv"
TIMEOUT /T 10
cls
GOTO RizkyWebID

:sethdmi
cls
"%cd%"\pulpstone\update.exe bulkcmd "setenv hdmimode 720p60hz"
"%cd%"\pulpstone\update.exe bulkcmd "saveenv"
TIMEOUT /T 10
cls
GOTO RizkyWebID

:erasedata
cls
"%cd%"\pulpstone\update.exe bulkcmd "amlmmc erase data"
TIMEOUT /T 10
cls
GOTO RizkyWebID

:resetdata
cls
"%cd%"\pulpstone\update.exe bulkcmd "reset"
TIMEOUT /T 10
cls
GOTO RizkyWebID

:flashORI
cls
SET Timestamp=%date:~0,2%-%date:~3,2%-%date:~6,8%
"%cd%"\pulpstone\7z2200-extra\7za e "%cd%"\Pulpstone.7z -pRizkyWebID -y -oC:\Windows\Temp\ -bd 
cls
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo   Flashing Pulpstone Original Android B860H Versi 1 n 2
echo       Harap Bersabar Proses Sedang Berjalan........
echo.
echo.
echo EnableSelinux permissive
"%cd%"\pulpstone\update.exe bulkcmd "setenv -f EnableSelinux permissive"
"%cd%"\pulpstone\update.exe bulkcmd "saveenv"
echo OK
echo.
echo Copy Partisi Boot [1/3]
"%cd%"\pulpstone\update.exe partition boot C:\Windows\Temp\EnbUbFHc
echo OK
echo.
echo Copy Partisi Logo [2/3]
"%cd%"\pulpstone\update.exe partition logo C:\Windows\Temp\ZSRmXrsB
echo OK
echo.
echo Copy Partisi System [3/3]
"%cd%"\pulpstone\update.exe partition system C:\Windows\Temp\iAs3QjM7
echo OK
echo.
"%cd%"\pulpstone\update.exe bulkcmd "amlmmc erase data"
"%cd%"\pulpstone\update.exe bulkcmd "setenv hdmimode 720p60hz"
"%cd%"\pulpstone\update.exe bulkcmd "reset"
echo.
del "C:\Windows\Temp\EnbUbFHc" /s /f /q
del "C:\Windows\Temp\ZSRmXrsB" /s /f /q
del "C:\Windows\Temp\iAs3QjM7" /s /f /q
del "C:\Windows\Temp\sPWrqRJC" /s /f /q
del "C:\Windows\Temp\85k169Ss" /s /f /q
del "C:\Windows\Temp\4sZNXeXk" /s /f /q
del "C:\Windows\Temp\0JY2gzn7" /s /f /q

cls
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo   Flashing Pulpstone Original Android B860H Versi 1 n 2
echo                       S E L E S A I
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
TIMEOUT /T 10
cls
GOTO keluar

:flashRWID
cls
SET Timestamp=%date:~0,2%-%date:~3,2%-%date:~6,8%
"%cd%"\pulpstone\7z2200-extra\7za e "%cd%"\Pulpstone.7z -pRizkyWebID -y -oC:\Windows\Temp\ -bd 
cls
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo   Flashing Pulpstone by.Rizky Android B860H Versi 1 n 2
echo       Harap Bersabar Proses Sedang Berjalan........
echo.
echo.
echo EnableSelinux permissive
"%cd%"\pulpstone\update.exe bulkcmd "setenv -f EnableSelinux permissive"
"%cd%"\pulpstone\update.exe bulkcmd "saveenv"
echo OK
echo.
echo Copy Partisi Boot [1/4]
"%cd%"\pulpstone\update.exe partition boot C:\Windows\Temp\sPWrqRJC
echo OK
echo.
echo Copy Partisi Logo [2/4]
"%cd%"\pulpstone\update.exe partition logo C:\Windows\Temp\85k169Ss
echo OK
echo.
echo Copy Partisi System [3/4]
"%cd%"\pulpstone\update.exe partition system C:\Windows\Temp\4sZNXeXk
echo OK
echo.
"%cd%"\pulpstone\update.exe bulkcmd "amlmmc erase data"
"%cd%"\pulpstone\update.exe bulkcmd "setenv hdmimode 720p60hz"
echo.
echo Copy Partisi data [4/4]
"%cd%"\pulpstone\update.exe partition data C:\Windows\Temp\0JY2gzn7
echo OK
echo.
del "C:\Windows\Temp\EnbUbFHc" /s /f /q
del "C:\Windows\Temp\ZSRmXrsB" /s /f /q
del "C:\Windows\Temp\iAs3QjM7" /s /f /q
del "C:\Windows\Temp\sPWrqRJC" /s /f /q
del "C:\Windows\Temp\85k169Ss" /s /f /q
del "C:\Windows\Temp\4sZNXeXk" /s /f /q
del "C:\Windows\Temp\0JY2gzn7" /s /f /q

cls
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo   Flashing Pulpstone by.Rizky Android B860H Versi 1 n 2
echo                       S E L E S A I
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
TIMEOUT /T 10
cls
GOTO keluar

:dataflash
cls
SET Timestamp=%date:~0,2%-%date:~3,2%-%date:~6,8%
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo            STB Flashing ( Dari Hasil Back-UP )
echo.
echo          Lakukan Erase Data sebelum Flashing STB
echo.
echo      Pastikan Anda Sudah Merubah Nama File yang akan
echo      digunakan untuk Flashing ke STB anda, Contohnya
echo    file hasil Back-UP terletak didalam folder firmware
echo    recovery_21011996.img di rubah menjadi recovery.img
echo.
echo   Pilih : ' 0 ' Untuk Exit ( KELUAR )
echo.
echo   A.  Flashing  Boot
echo   B.  Flashing  Logo
echo   C.  Flashing  System
echo   D.  Flashing  Bootloader
echo   E.  Flashing  Data
echo   F.  Flashing  Cache
echo   G.  Flashing  Conf
echo   H.  Flashing  Recovery
echo.
echo   1.  STB Backup   ( Kloning IMG / File )
echo   2.  KEMBALI KE HALAMAN UTAMA PULPSTONE
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
echo.
set /P "M=Ketikan Pilihan Anda : "
set var=%M%
if !var!==0 goto keluar
if !var!==1 goto databackup
if !var!==2 goto RizkyWebID

if !var!==A goto DFBoot
if !var!==B goto DFLogo
if !var!==C goto DFSystem
if !var!==D goto DFBootloader
if !var!==E goto DFData
if !var!==F goto DFCache
if !var!==G goto DFConf
if !var!==H goto DFRecovery

if !var!==  goto noinput

cls
goto RizkyWebID

:DFBoot
cls
"%cd%"\pulpstone\update.exe partition boot "%cd%"\firmware\boot.img
TIMEOUT /T 10
cls
GOTO dataflash

:DFLogo
cls
"%cd%"\pulpstone\update.exe partition logo "%cd%"\firmware\logo.img
TIMEOUT /T 10
cls
GOTO dataflash

:DFSystem
cls
"%cd%"\pulpstone\update.exe partition system "%cd%"\firmware\system.img
TIMEOUT /T 10
cls
GOTO dataflash

:DFBootloader
cls
SET Timestamp=%date:~0,2%-%date:~3,2%-%date:~6,8%
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo    Flash bootloader via PuTTY / ADB / TE [ root ]
echo.
echo    "dd if=uboot.bin of=/dev/block/bootloader"
echo.
echo    [ perintah bila sudah berada didirectory file ]
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
TIMEOUT /T 20
cls
GOTO dataflash

:DFData
cls
"%cd%"\pulpstone\update.exe partition data "%cd%"\firmware\data.img
TIMEOUT /T 10
cls
GOTO dataflash

:DFCache
cls
"%cd%"\pulpstone\update.exe partition cache "%cd%"\firmware\cache.img
TIMEOUT /T 10
cls
GOTO dataflash

:DFConf
cls
"%cd%"\pulpstone\update.exe partition conf "%cd%"\firmware\conf.img
TIMEOUT /T 10
cls
GOTO dataflash

:DFRecovery
cls
"%cd%"\pulpstone\update.exe partition recovery "%cd%"\firmware\recovery.img
TIMEOUT /T 10
cls
GOTO dataflash

:databackup
cls
SET Timestamp=%date:~0,2%-%date:~3,2%-%date:~6,8%
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo            STB Backup   ( Kloning IMG / File )
echo.
echo   Pilih : ' 0 ' Untuk Exit ( KELUAR )
echo.
echo   A.  Back-UP  Boot
echo   B.  Back-UP  Logo
echo   C.  Back-UP  System
echo   D.  Back-UP  Bootloader
echo   E.  Back-UP  Data
echo   F.  Back-UP  Cache
echo   G.  Back-UP  Conf
echo   H.  Back-UP  Recovery
echo.
echo   1.  STB Flashing ( Dari Hasil Back-UP )
echo   2.  KEMBALI KE HALAMAN UTAMA PULPSTONE
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
echo.
set /P "M=Ketikan Pilihan Anda : "
set var=%M%
if !var!==0 goto keluar
if !var!==1 goto dataflash
if !var!==2 goto RizkyWebID

if !var!==A goto DBBoot
if !var!==B goto DBLogo
if !var!==C goto DBSystem
if !var!==D goto DBBootloader
if !var!==E goto DBData
if !var!==F goto DBCache
if !var!==G goto DBConf
if !var!==H goto DBRecovery

if !var!==  goto noinput

cls
goto RizkyWebID

:DBBoot
cls
"%cd%"\pulpstone\update.exe mread store boot normal 0x1000000 "%cd%"\firmware\boot_%Timestamp%.img
TIMEOUT /T 10
cls
GOTO databackup

:DBLogo
cls
"%cd%"\pulpstone\update.exe mread store logo normal 0x1000000 "%cd%"\firmware\logo_%Timestamp%.img
TIMEOUT /T 10
cls
GOTO databackup

:DBSystem
cls
"%cd%"\pulpstone\update.exe mread store system normal 0x6cc00000 "%cd%"\firmware\system_%Timestamp%.img
TIMEOUT /T 10
cls
GOTO databackup

:DBBootloader
cls
"%cd%"\pulpstone\update.exe mread store bootloader normal 0x12C260 "%cd%"\firmware\bootloader_%Timestamp%.bin
TIMEOUT /T 10
cls
GOTO databackup

:DBData
cls
"%cd%"\pulpstone\update.exe mread store data normal 0x11f200000 "%cd%"\firmware\data_%Timestamp%.img
TIMEOUT /T 10
cls
GOTO databackup

:DBCache
cls
"%cd%"\pulpstone\update.exe mread store cache normal 0x37a00000 "%cd%"\firmware\cache_%Timestamp%.img
TIMEOUT /T 10
cls
GOTO databackup

:DBConf
cls
"%cd%"\pulpstone\update.exe mread store conf normal 0x400000 "%cd%"\firmware\conf_%Timestamp%.img
TIMEOUT /T 10
cls
GOTO databackup

:DBRecovery
cls
"%cd%"\pulpstone\update.exe mread store recovery normal 0x1800000 "%cd%"\firmware\recovery_%Timestamp%.img
TIMEOUT /T 10
cls
GOTO databackup

:noinput
cls
SET Timestamp=%date:~0,2%-%date:~3,2%-%date:~6,8%
echo.
echo   =====================================================
echo                STB ZTE B860H Versi 1 dan 2
echo       Pulpstone Amlogic Update USB Tools RizkyWebID
echo   =====================================================
echo.
echo      Pastikan Nomor Pilihan Sudah Benar dan pastikan
echo     Tulisan Huruf Besar atau Kecil sangat Berpengaruh
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
TIMEOUT /T 10
cls
GOTO RizkyWebID

:keluar
cls
echo   =====================================================
echo                          ZTE B860H
echo         Pulpstone Amlogic Update USB Tool v2.1
echo   =====================================================
echo.
echo   DONATION,
echo   Please consider donating 
echo   if you appreciate our work
echo    0813 9131 6060 [ OVO / GO-PAY / DANA / TELKOMSEL ]
echo. 
echo   Regrads,
echo    Rizky Arinanda AR ( RizkyWebID ) 
echo     [ github.com/RizkyWebID ]
echo     [ linkedin.com/in/rizkyarinandaar ]
echo.
echo   =====================================================
echo                don't forget to be grateful
echo   =====================================================
echo.
SET /P AREYOUSURE=Press any key to exit...
IF /I "%AREYOUSURE%" NEQ "Y" cls GOTO end

:end