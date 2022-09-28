@echo off
if "%1"=="" (
echo "useage: ./run.bat GPU|CPU"
exit 1)
set ARG_LOWER=%1
for %%i in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do call set ARG_LOWER=%%ARG_LOWER:%%i=%%i%%
docker run --name game_ai_sdk_%ARG_LOWER% -tid lsqtzj/game_ai_sdk:%ARG_LOWER%
docker exec -it game_ai_sdk_%ARG_LOWER% /bin/bash