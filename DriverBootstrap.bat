::CONFIG
@echo off
SET dir=%~p0

::MAIN
cd %dir% 
start RPAL_Driver_Driver.sh %*
@REM PAUSE