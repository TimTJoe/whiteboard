@echo off
REM Wi-Fi Password Tester Script
REM Author: Gemini
REM Date: June 7, 2025

REM IMPORTANT SECURITY NOTICE:
REM This script contains a plain-text password. Use with extreme caution
REM and only on networks you are authorized to access. Running this script
REM requires Administrator privileges.

SETLOCAL ENABLEDELAYEDEXPANSION

REM --- Configuration ---
SET "PASSWORD=12345678"
SET "TEMP_PROFILE_DIR=%TEMP%\WifiProfiles"
SET "LOG_FILE=%TEMP%\wifi_connection_log.txt"

REM --- Cleanup previous logs/profiles ---
IF EXIST "%LOG_FILE%" DEL "%LOG_FILE%"
IF EXIST "%TEMP_PROFILE_DIR%" RMDIR /S /Q "%TEMP_PROFILE_DIR%"
MD "%TEMP_PROFILE_DIR%" >NUL 2>&1

ECHO --- Wi-Fi Password Tester --- >> "%LOG_FILE%"
ECHO Script started at %DATE% %TIME% >> "%LOG_FILE%"
ECHO.

ECHO Checking for Wi-Fi adapter...
netsh wlan show interfaces | findstr /i "State" | findstr /i "connected disconnected" >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO Error: No active Wi-Fi adapter found or Wi-Fi is disabled.
    ECHO Error: No active Wi-Fi adapter found or Wi-Fi is disabled. >> "%LOG_FILE%"
    GOTO :EOF
)
ECHO Wi-Fi adapter found.

ECHO Scanning for available Wi-Fi networks...
ECHO This may take a few moments...
REM Scan for networks and redirect output to a temporary file
netsh wlan show networks mode=Bssid > "%TEMP_PROFILE_DIR%\networks.txt"

REM Extract SSIDs from the networks.txt file
REM We look for lines starting with "SSID"
FOR /F "tokens=1,2* delims=:" %%A IN ('findstr /I /C:"SSID" "%TEMP_PROFILE_DIR%\networks.txt"') DO (
    SET "LINE=%%B"
    REM Remove leading spaces from the SSID
    SET "SSID=!LINE:~1!"

    REM Strip any carriage returns that might be present due to file encoding
    FOR %%C IN ("!SSID!") DO SET "SSID_CLEAN=%%~nC"
    SET "SSID_CLEAN=!SSID_CLEAN: =!"
    SET "SSID_CLEAN=!SSID_CLEAN:~1!" REM Remove first character if it's a space

    REM Sometimes the SSID might be enclosed in quotes if it contains spaces.
    REM Let's try to handle that.
    IF "!SSID_CLEAN:~0,1!"=="\"" (
        SET "SSID_CLEAN=!SSID_CLEAN:~1!"
        IF "!SSID_CLEAN:~-1!"=="\"" (
            SET "SSID_CLEAN=!SSID_CLEAN:~0,-1!"
        )
    )

    REM Skip empty SSIDs or those that are clearly not valid
    IF NOT "!SSID_CLEAN!"=="" (
        ECHO Found network: !SSID_CLEAN!
        ECHO Found network: !SSID_CLEAN! >> "%LOG_FILE%"

        REM --- Create the Wi-Fi profile XML ---
        REM A basic WPA2-PSK profile template
        SET "PROFILE_XML_NAME=!SSID_CLEAN!.xml"
        (
            ECHO ^<?xml version="1.0"?^>
            ECHO ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^>
            ECHO   ^<name^>!SSID_CLEAN!^</name^>
            ECHO   ^<SSIDConfig^>
            ECHO     ^<SSID^>
            ECHO       ^<name^>!SSID_CLEAN!^</name^>
            ECHO     ^</SSID^>
            ECHO   ^</SSIDConfig^>
            ECHO   ^<connectivity^>
            ECHO     ^<connectionMode^>auto^</connectionMode^>
            ECHO     ^<nonBroadcast^>false^</nonBroadcast^>
            ECHO   ^</connectivity^>
            ECHO   ^<MSM^>
            ECHO     ^<security^>
            ECHO       ^<authEncryption^>
            ECHO         ^<authentication^>WPA2PSK^</authentication^>
            ECHO         ^<encryption^>AES^</encryption^>
            ECHO         ^<useOneX^>false^</useOneX^>
            ECHO       ^</authEncryption^>
            ECHO       ^<sharedKey^>
            ECHO         ^<keyType^>passPhrase^</keyType^>
            ECHO         ^<protected^>false^</protected^>
            ECHO         ^<keyMaterial^>!PASSWORD!^</keyMaterial^>
            ECHO       ^</sharedKey^>
            ECHO     ^</security^>
            ECHO   ^</MSM^>
            ECHO ^</WLANProfile^>
        ) > "%TEMP_PROFILE_DIR%\!PROFILE_XML_NAME!"

        IF EXIST "%TEMP_PROFILE_DIR%\!PROFILE_XML_NAME!" (
            ECHO Created profile XML for !SSID_CLEAN!: "%TEMP_PROFILE_DIR%\!PROFILE_XML_NAME!"
            ECHO Created profile XML for !SSID_CLEAN!: "%TEMP_PROFILE_DIR%\!PROFILE_XML_NAME!" >> "%LOG_FILE%"

            REM --- Add the profile ---
            ECHO Adding Wi-Fi profile for !SSID_CLEAN!...
            netsh wlan add profile filename="%TEMP_PROFILE_DIR%\!PROFILE_XML_NAME!" user=current >> "%LOG_FILE%" 2>&1
            IF %ERRORLEVEL% EQU 0 (
                ECHO Profile added successfully for !SSID_CLEAN!.
                ECHO Profile added successfully for !SSID_CLEAN!. >> "%LOG_FILE%"

                REM --- Connect to the network ---
                ECHO Attempting to connect to !SSID_CLEAN!...
                netsh wlan connect name="!SSID_CLEAN!" >> "%LOG_FILE%" 2>&1
                IF %ERRORLEVEL% EQU 0 (
                    ECHO Successfully issued connection command for !SSID_CLEAN!.
                    ECHO Waiting a few seconds for connection to establish...
                    PING 127.0.0.1 -n 5 >NUL
                    netsh wlan show interfaces | findstr /i "SSID" | findstr /i "!SSID_CLEAN!" >NUL
                    IF %ERRORLEVEL% EQU 0 (
                        ECHO CONNECTED to !SSID_CLEAN!!
                        ECHO CONNECTED to !SSID_CLEAN!! >> "%LOG_FILE%"
                        REM You might want to stop here if a connection is made
                        REM GOTO :END_SCRIPT
                    ) ELSE (
                        ECHO Failed to connect to !SSID_CLEAN! (connection not established).
                        ECHO Failed to connect to !SSID_CLEAN! (connection not established). >> "%LOG_FILE%"
                    )
                ) ELSE (
                    ECHO Failed to issue connection command for !SSID_CLEAN!.
                    ECHO Failed to issue connection command for !SSID_CLEAN!. >> "%LOG_FILE%"
                )

                REM --- Delete the temporary profile after attempt ---
                ECHO Deleting temporary profile for !SSID_CLEAN!...
                netsh wlan delete profile name="!SSID_CLEAN!" >> "%LOG_FILE%" 2>&1
                IF %ERRORLEVEL% EQU 0 (
                    ECHO Profile deleted successfully for !SSID_CLEAN!.
                    ECHO Profile deleted successfully for !SSID_CLEAN!. >> "%LOG_FILE%"
                ) ELSE (
                    ECHO Failed to delete profile for !SSID_CLEAN!. Manual cleanup might be needed.
                    ECHO Failed to delete profile for !SSID_CLEAN!. Manual cleanup might be needed. >> "%LOG_FILE%"
                )
            ) ELSE (
                ECHO Failed to add profile for !SSID_CLEAN!.
                ECHO Failed to add profile for !SSID_CLEAN!. >> "%LOG_FILE%"
            )
        ) ELSE (
            ECHO Error: Could not create profile XML for !SSID_CLEAN!.
            ECHO Error: Could not create profile XML for !SSID_CLEAN!. >> "%LOG_FILE%"
        )
    )
)

:END_SCRIPT
ECHO.
ECHO Script finished. Check "%LOG_FILE%" for detailed results.
ECHO Script finished at %DATE% %TIME% >> "%LOG_FILE%"
ENDLOCAL
PAUSE
