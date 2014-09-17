@echo off

powershell "Import-Module .\psake.psm1 ; Invoke-Psake .\build.ps1 Generate-Package -properties @{\"apikey\"=\"%1\"} ; exit $LASTEXITCODE"