@echo off
if "%1"=="" (
echo "useage: ./build.bat GPU|CPU"
exit 1)
set ARG_LOWER=%1
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do call set ARG_LOWER=%%ARG_LOWER:%%i=%%i%%
set ARG_UPPER=%1
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do call set ARG_UPPER=%%ARG_UPPER:%%i=%%i%%
docker build --build-arg DOCKER_CUDA=%ARG_UPPER% -t lsqtzj/game_ai_sdk:%ARG_LOWER% -f Dockerfile ../..
docker tag lsqtzj/game_ai_sdk:%ARG_LOWER% lsqtzj/game_ai_sdk:latest