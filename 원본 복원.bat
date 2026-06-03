@echo off
setlocal
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\restore-original.ps1"
echo.
echo Done. Restart Riftborne after restoring.
pause

