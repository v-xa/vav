@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
title VAV Windows Optimization Script
color 0A
cls

:: Admin check
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run this script as administrator.
    pause
    exit /b
)

:MAIN_MENU
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                    ===== WINDOWS OPTIMIZATION SCRIPT =====
echo.
echo  WARNING: This script will modify system settings. Create a system restore point first.
echo.
echo  [1] Create System Restore Point (RECOMMENDED)
echo  [2] Performance Optimization
echo  [3] Privacy Enhancements
echo  [4] Bloatware Removal
echo  [5] Network Optimization
echo  [6] Disk Cleanup
echo  [7] Service Optimization
echo  [8] Registry Optimization
echo  [9] Gaming Optimization
echo  [10] Apply All Optimizations
echo  [11] Revert Changes (System Restore)
echo  [0] Exit
echo.
set /p choice="Enter your choice (0-11): "

if "%choice%"=="1" goto CREATE_RESTORE
if "%choice%"=="2" goto PERFORMANCE_MENU
if "%choice%"=="3" goto PRIVACY_MENU
if "%choice%"=="4" goto BLOATWARE_MENU
if "%choice%"=="5" goto NETWORK_MENU
if "%choice%"=="6" goto DISK_CLEANUP
if "%choice%"=="7" goto SERVICE_MENU
if "%choice%"=="8" goto REGISTRY_MENU
if "%choice%"=="9" goto GAMING_MENU
if "%choice%"=="10" goto APPLY_ALL
if "%choice%"=="11" goto SYSTEM_RESTORE
if "%choice%"=="0" goto EXIT
goto MAIN_MENU

:CREATE_RESTORE
cls
echo Creating a System Restore Point...
powershell -command "Checkpoint-Computer -Description 'VAV Optimization Script' -RestorePointType 'MODIFY_SETTINGS'"
if %errorlevel% equ 0 (
    echo System Restore Point created successfully.
) else (
    echo Failed to create System Restore Point.
    echo Please make sure System Protection is enabled on your system drive.
)
pause
goto MAIN_MENU

:PERFORMANCE_MENU
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                    ===== PERFORMANCE OPTIMIZATION =====

:USER_TEMP
cls
echo Cleaning User Temp Files...
:: Clean User Temp folder
del /q /f /s "%temp%\*.*"
rd /s /q "%temp%"
md "%temp%"
:: Clean Temporary Internet Files for all users
powershell -command "Remove-Item -Path 'C:\Users\*\AppData\Local\Microsoft\Windows\INetCache\*' -Recurse -Force -ErrorAction SilentlyContinue"
echo User Temp Files cleaned.
pause
goto DISK_CLEANUP

:RESTORE_POINTS
cls
echo Managing System Restore Points...
echo WARNING: This will delete all but the most recent restore point.
echo.
set /p restore_confirm="Are you sure you want to continue? (Y/N): "
if /i "%restore_confirm%"=="Y" (
    echo Cleaning old System Restore Points...
    :: Clean old restore points - keeps the most recent one
    vssadmin delete shadows /for=C: /oldest /quiet
    echo System Restore Points cleaned.
) else (
    echo Operation cancelled.
)
pause
goto DISK_CLEANUP

:UPDATE_CLEANUP
cls
echo Cleaning Windows Update Cache...
:: Stop Windows Update service
net stop wuauserv
:: Clean Windows Update Cache
del /q /f /s "%windir%\SoftwareDistribution\*.*"
rd /s /q "%windir%\SoftwareDistribution"
md "%windir%\SoftwareDistribution"
:: Start Windows Update service
net start wuauserv
echo Windows Update Cache cleaned.
pause
goto DISK_CLEANUP

:ALL_DISK
call :WINDOWS_TEMP
call :USER_TEMP
call :RESTORE_POINTS
call :UPDATE_CLEANUP
echo All Disk Cleanup operations applied.
pause
goto DISK_CLEANUP

:SERVICE_MENU
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                    ===== SERVICE OPTIMIZATION =====
echo.
echo  [1] Disable Unnecessary Services      [2] Optimize Service Startup
echo  [3] Disable Windows Search            [4] Disable Print Spooler
echo  [5] Apply All Service Optimizations   [0] Back to Main Menu
echo.
set /p serv_choice="Enter your choice (0-5): "

if "%serv_choice%"=="1" goto DISABLE_SERVICES
if "%serv_choice%"=="2" goto OPTIMIZE_STARTUP
if "%serv_choice%"=="3" goto DISABLE_SEARCH
if "%serv_choice%"=="4" goto DISABLE_PRINT
if "%serv_choice%"=="5" goto ALL_SERVICES
if "%serv_choice%"=="0" goto MAIN_MENU
goto SERVICE_MENU

:DISABLE_SERVICES
cls
echo Disabling Unnecessary Services...
:: List of services to disable
sc config "DiagTrack" start= disabled
sc config "dmwappushservice" start= disabled
sc config "RetailDemo" start= disabled
sc config "TabletInputService" start= disabled
sc config "XblAuthManager" start= disabled
sc config "XblGameSave" start= disabled
sc config "XboxNetApiSvc" start= disabled
sc config "MapsBroker" start= disabled
sc config "lfsvc" start= disabled
sc config "WbioSrvc" start= disabled
sc config "PeerDistSvc" start= disabled
sc config "PhoneSvc" start= disabled
sc config "WMPNetworkSvc" start= disabled
echo Unnecessary Services disabled.
pause
goto SERVICE_MENU

:OPTIMIZE_STARTUP
cls
echo Optimizing Service Startup...
:: Set services to manual that aren't needed at startup
sc config "BITS" start= demand
sc config "WSearch" start= demand
sc config "SysMain" start= demand
sc config "FontCache" start= demand
sc config "Themes" start= auto
sc config "Power" start= auto
:: Disable superfetch/prefetch service (SysMain)
sc config "SysMain" start= disabled
echo Service Startup optimized.
pause
goto SERVICE_MENU

:DISABLE_SEARCH
cls
echo Disabling Windows Search Indexing...
sc config "WSearch" start= disabled
net stop "WSearch"
echo Windows Search Indexing disabled.
pause
goto SERVICE_MENU

:DISABLE_PRINT
cls
echo Disabling Print Spooler...
echo WARNING: This will disable printing functionality.
echo.
set /p print_confirm="Are you sure you want to continue? (Y/N): "
if /i "%print_confirm%"=="Y" (
    sc config "Spooler" start= disabled
    net stop "Spooler"
    echo Print Spooler disabled.
) else (
    echo Operation cancelled.
)
pause
goto SERVICE_MENU

:ALL_SERVICES
call :DISABLE_SERVICES
call :OPTIMIZE_STARTUP
call :DISABLE_SEARCH
echo All Service Optimizations applied (except Print Spooler which requires confirmation).
pause
goto SERVICE_MENU

:REGISTRY_MENU
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                    ===== REGISTRY OPTIMIZATION =====
echo.
echo  [1] Performance Registry Tweaks       [2] Windows Explorer Tweaks
echo  [3] Context Menu Optimization         [4] Startup Delay Removal
echo  [5] Apply All Registry Optimizations  [0] Back to Main Menu
echo.
set /p reg_choice="Enter your choice (0-5): "

if "%reg_choice%"=="1" goto PERFORMANCE_REG
if "%reg_choice%"=="2" goto EXPLORER_TWEAKS
if "%reg_choice%"=="3" goto CONTEXT_MENU
if "%reg_choice%"=="4" goto STARTUP_DELAY
if "%reg_choice%"=="5" goto ALL_REGISTRY
if "%reg_choice%"=="0" goto MAIN_MENU
goto REGISTRY_MENU

:PERFORMANCE_REG
cls
echo Applying Performance Registry Tweaks...
:: General Performance Tweaks
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v SystemPages /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v SecondLevelDataCache /t REG_DWORD /d 1024 /f
:: Increase Service Host Splitting Threshold
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d 4194304 /f
echo Performance Registry Tweaks applied.
pause
goto REGISTRY_MENU

:EXPLORER_TWEAKS
cls
echo Applying Windows Explorer Tweaks...
:: Show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
:: Show hidden files
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
:: Disable Quick Access as default view
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f
:: Show This PC on Desktop
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f
:: Disable Windows Recent Files
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f
echo Windows Explorer Tweaks applied.
pause
goto REGISTRY_MENU

:CONTEXT_MENU
cls
echo Optimizing Context Menu...
:: Remove unnecessary context menu items
reg delete "HKCR\*\shellex\ContextMenuHandlers\ModernSharing" /f
reg delete "HKCR\*\shellex\ContextMenuHandlers\Sharing" /f
:: Windows 11 specific: Restore classic context menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
echo Context Menu optimized.
echo Note: For Windows 11, a restart is required for the classic context menu change to take effect.
pause
goto REGISTRY_MENU

:STARTUP_DELAY
cls
echo Removing Startup Delay...
:: Remove startup delay
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f
:: Disable auto startup of Windows Store apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f
echo Startup Delay removed.
pause
goto REGISTRY_MENU

:ALL_REGISTRY
call :PERFORMANCE_REG
call :EXPLORER_TWEAKS
call :CONTEXT_MENU
call :STARTUP_DELAY
echo All Registry Optimizations applied.
pause
goto REGISTRY_MENU

:GAMING_MENU
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                    ===== GAMING OPTIMIZATION =====
echo.
echo  [1] Game Mode Configuration          [2] DirectX Performance
echo  [3] GPU Optimization                 [4] Process Scheduling
echo  [5] Apply All Gaming Optimizations   [0] Back to Main Menu
echo.
set /p game_choice="Enter your choice (0-5): "

if "%game_choice%"=="1" goto GAME_MODE
if "%game_choice%"=="2" goto DIRECTX
if "%game_choice%"=="3" goto GPU_OPTIMIZE
if "%game_choice%"=="4" goto PROCESS_SCHEDULE
if "%game_choice%"=="5" goto ALL_GAMING
if "%game_choice%"=="0" goto MAIN_MENU
goto GAMING_MENU

:GAME_MODE
cls
echo Configuring Game Mode...
:: Enable Game Mode
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f
:: Disable Game DVR (Game Bar)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f
echo Game Mode configured.
pause
goto GAMING_MENU

:DIRECTX
cls
echo Optimizing DirectX Performance...
:: Direct3D Performance Tweaks
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v DisableVidMemVBs /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Direct3D" /v DisableVidMemVBs /t REG_DWORD /d 0 /f
:: MaximumDynamicVb
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v MaximumDynamicVb /t REG_DWORD /d 512 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Direct3D" /v MaximumDynamicVb /t REG_DWORD /d 512 /f
echo DirectX Performance optimized.
pause
goto GAMING_MENU

:GPU_OPTIMIZE
cls
echo Optimizing GPU Settings...
:: Detect GPU
echo Detecting GPU...
powershell -command "Get-WmiObject win32_VideoController | Select-Object Name, AdapterCompatibility"
echo.
echo [1] NVIDIA GPU
echo [2] AMD GPU
echo [3] Intel GPU
echo [4] Skip GPU Optimization
set /p gpu_type="Select your GPU type (1-4): "

if "%gpu_type%"=="1" (
    echo Optimizing for NVIDIA GPU...
    :: NVIDIA Threaded Optimization
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrLevel /t REG_DWORD /d 2 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 10 /f
    :: Create PowerMizer settings in registry
    reg add "HKCU\Software\NVIDIA Corporation\Global\PowerMizer" /v PowerMizerLevel /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\NVIDIA Corporation\Global\PowerMizer" /v PowerMizerLevelAC /t REG_DWORD /d 1 /f
    echo NVIDIA GPU optimized.
)
if "%gpu_type%"=="2" (
    echo Optimizing for AMD GPU...
    :: AMD-specific tweaks
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v EnableUlps /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v PP_SclkDeepSleepDisable /t REG_DWORD /d 1 /f
    echo AMD GPU optimized.
)
if "%gpu_type%"=="3" (
    echo Optimizing for Intel GPU...
    :: Intel-specific tweaks
    reg add "HKLM\SOFTWARE\Intel\GMM" /v DedicatedSegmentSize /t REG_DWORD /d 512 /f
    echo Intel GPU optimized.
)
if "%gpu_type%"=="4" (
    echo GPU Optimization skipped.
)
pause
goto GAMING_MENU

:PROCESS_SCHEDULE
cls
echo Optimizing Process Scheduling for Gaming...
:: Set Windows to prioritize programs over background processes
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f
:: Core Parking
powercfg -setacvalueindex scheme_current sub_processor IDLEDISABLE 1
powercfg -setactive scheme_current
echo Process Scheduling optimized for gaming.
pause
goto GAMING_MENU

:ALL_GAMING
call :GAME_MODE
call :DIRECTX
call :GPU_OPTIMIZE
call :PROCESS_SCHEDULE
echo All Gaming Optimizations applied.
pause
goto GAMING_MENU

:APPLY_ALL
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                  ===== APPLYING ALL OPTIMIZATIONS =====
echo.
echo WARNING: This will apply ALL optimizations with default settings.
echo It's recommended to create a System Restore Point before continuing.
echo.
set /p all_confirm="Are you sure you want to apply all optimizations? (Y/N): "
if /i not "%all_confirm%"=="Y" goto MAIN_MENU

:: Create a system restore point first
echo Creating System Restore Point...
powershell -command "Checkpoint-Computer -Description 'Before VAV Full Optimization' -RestorePointType 'MODIFY_SETTINGS'"

:: Apply all optimizations
echo Applying all Performance Optimizations...
call :ALL_PERFORMANCE

echo Applying all Privacy Enhancements...
call :ALL_PRIVACY

echo Applying all Bloatware Removal options...
call :ALL_BLOATWARE

echo Applying all Network Optimizations...
call :TCP_OPTIMIZATION
call :DISABLE_QOS

echo Applying all Disk Cleanup operations...
call :WINDOWS_TEMP
call :USER_TEMP

echo Applying all Service Optimizations...
call :DISABLE_SERVICES
call :OPTIMIZE_STARTUP
call :DISABLE_SEARCH

echo Applying all Registry Optimizations...
call :ALL_REGISTRY

echo Applying all Gaming Optimizations...
call :GAME_MODE
call :DIRECTX
call :PROCESS_SCHEDULE

echo.
echo All optimizations have been applied.
echo It's recommended to restart your computer for changes to take full effect.
echo.
set /p restart="Would you like to restart your computer now? (Y/N): "
if /i "%restart%"=="Y" (
    shutdown /r /t 30 /c "Restarting to apply VAV Optimization changes"
    echo Your computer will restart in 30 seconds.
    echo Close any open applications now.
    echo.
    echo Press any key to cancel restart...
    timeout /t 25
    shutdown /a
    echo Restart cancelled.
)
pause
@echo off
setlocal EnableDelayedExpansion
title VAV Windows Optimization Script
color 0A
cls

:: Admin check
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run this script as administrator.
    pause
    exit /b
)

:MAIN_MENU
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                    ===== WINDOWS OPTIMIZATION SCRIPT =====
echo.
echo  WARNING: This script will modify system settings. Create a system restore point first.
echo.
echo  [1] Create System Restore Point (RECOMMENDED)
echo  [2] Performance Optimization
echo  [3] Privacy Enhancements
echo  [4] Bloatware Removal
echo  [5] Network Optimization
echo  [6] Disk Cleanup
echo  [7] Service Optimization
echo  [8] Registry Optimization
echo  [9] Gaming Optimization
echo  [10] Apply All Optimizations
echo  [11] Revert Changes (System Restore)
echo  [0] Exit
echo.
set /p choice="Enter your choice (0-11): "

if "%choice%"=="1" goto CREATE_RESTORE
if "%choice%"=="2" goto PERFORMANCE_MENU
if "%choice%"=="3" goto PRIVACY_MENU
if "%choice%"=="4" goto BLOATWARE_MENU
if "%choice%"=="5" goto NETWORK_MENU
if "%choice%"=="6" goto DISK_CLEANUP
if "%choice%"=="7" goto SERVICE_MENU
if "%choice%"=="8" goto REGISTRY_MENU
if "%choice%"=="9" goto GAMING_MENU
if "%choice%"=="10" goto APPLY_ALL
if "%choice%"=="11" goto SYSTEM_RESTORE
if "%choice%"=="0" goto EXIT
goto MAIN_MENU

:CREATE_RESTORE
cls
echo Creating a System Restore Point...
powershell -command "Checkpoint-Computer -Description 'VAV Optimization Script' -RestorePointType 'MODIFY_SETTINGS'"
if %errorlevel% equ 0 (
    echo System Restore Point created successfully.
) else (
    echo Failed to create System Restore Point.
    echo Please make sure System Protection is enabled on your system drive.
)
pause
goto MAIN_MENU

:PERFORMANCE_MENU
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                    ===== PERFORMANCE OPTIMIZATION =====

goto MAIN_MENU

:SYSTEM_RESTORE
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                      ===== SYSTEM RESTORE =====
echo.
echo This will launch the System Restore utility to revert changes.
echo.
echo [1] Launch System Restore
echo [0] Back to Main Menu
echo.
set /p restore_choice="Enter your choice (0-1): "

if "%restore_choice%"=="1" (
    echo Launching System Restore...
    rstrui.exe
) else (
    goto MAIN_MENU
)
pause
goto MAIN_MENU

:EXIT
cls
echo.
echo                        ██╗   ██╗ █████╗ ██╗   ██╗
echo                        ██║   ██║██╔══██╗██║   ██║
echo                        ██║   ██║███████║██║   ██║
echo                        ╚██╗ ██╔╝██╔══██║╚██╗ ██╔╝
echo                         ╚████╔╝ ██║  ██║ ╚████╔╝ 
echo                          ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  
echo.
echo                 ===== THANK YOU FOR USING VAV =====
echo.
echo.
echo.
echo Press any key to exit...
pause >nul
exit /b 0
