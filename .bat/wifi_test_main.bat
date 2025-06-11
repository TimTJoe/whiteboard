@echo off
setlocal enabledelayedexpansion

set "password=12345678"

echo Listing available Wi-Fi networks...
netsh wlan show networks mode=bssid

echo Available networks:
for /f "tokens=*" %%a in ('netsh wlan show networks ^| findstr /r /c:"SSID"') do (
    set "line=%%a"
    set "line=!line:*SSID : =!"
    echo.
    echo Attempting to connect to: !line!
    netsh wlan connect name="!line!" ssid="!line!" interface="Wi-Fi"
    if !errorlevel! == 0 (
        echo Successfully connected to !line!.
    ) else (
        echo Failed to connect to !line!.
        echo Attempting to add and connect with specified password...
        netsh wlan add profile filename="temp_profile.xml" user=all
        (
            echo ^<?xml version="1.0"?^>
            echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^>
            echo     ^<name^>!line!^</name^>
            echo     ^<SSIDConfig^>
            echo         ^<SSID^>
            echo             ^<name^>!line!^</name^>
            echo         ^</SSID^>
            echo     ^</SSIDConfig^>
            echo     ^<connectionType^>ESS^</connectionType^>
            echo     ^<connectionMode^>auto^</connectionMode^>
            echo     ^<MSM^>
            echo         ^<security^>
            echo             ^<authEncryption^>
            echo                 ^<authentication^>WPA2PSK^</authentication^>
            echo                 ^<encryption^>AES^</encryption^>
            echo                 ^<useOneX^>false^</useOneX^>
            echo             ^</authEncryption^>
            echo             ^<sharedKey^>
            echo                 ^<keyType^>passPhrase^</keyType^>
            echo                 ^<protected^>false^</protected^>
            echo                 ^<keyMaterial^>%password%^</keyMaterial^>
            echo             ^</sharedKey^>
            echo         ^</security^>
            echo     ^</MSM^>
            echo ^</WLANProfile^>
        ) > temp_profile.xml
        netsh wlan connect name="!line!"
        del temp_profile.xml
        if !errorlevel! == 0 (
            echo Successfully connected to !line! using the password.
        ) else (
            echo Failed to connect to !line! using the password.
        )
    )
)
pause