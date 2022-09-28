@echo off
if "%1"=="" (
echo "useage: ./start_win_docker.bat GPU|CPU"
exit 1)
if "%2" == "h" goto begin
mshta vbscript:createobject("wscript.shell").run("%~nx0 %1 h",0)(window.close)&&exit
:begin
set ARG_LOWER=%1
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do call set ARG_LOWER=%%ARG_LOWER:%%i=%%i%%

@mode con lines=40 cols=100
color AF
title "sdktool navicate"

set pwd="%cd%"

:: kill exist process
taskkill /F /IM vcxsrv.exe

if %errorlevel% == 1 (
    echo "kill vcxsrv failed"
    pause
)

:: start VcXsrv
echo start VcXsrv......
start /wait "" "C:\Program Files\VcXsrv\xlaunch.exe"
if %errorlevel% == 1 (
    echo "start vcxsrv failed"
    pause
)
echo start VcXsrv successful

:: start adbkit, 7788 port
echo start adbkit, will use 7788 port
for /F %%i in ('adb devices') do ( set adb_device=%%i)
echo detect phone deviceid=%adb_device%
start /b adbkit usb-device-to-tcp -p 7788 %adb_device%
echo start adbkit successful
if %errorlevel% == 1 (
    echo "start adbkit failed"
    pause
)
docker stop game_ai_sdk_%ARG_LOWER%
docker rm game_ai_sdk_%ARG_LOWER%
cd %pwd%
docker run --restart=on-failure --cap-add=SYS_PTRACE -v /tmp/.X11-unix:/tmp/.X11-unix:rw --gpus all --shm-size=1024m  --name game_ai_sdk_%ARG_LOWER% -p 10022:22 -p 14000:4000 -it lsqtzj/game_ai_sdk:%ARG_LOWER% /bin/bash /data1/game_ai_sdk/bin/docker_start_service.sh

pause
