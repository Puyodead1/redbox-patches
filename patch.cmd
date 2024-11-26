@echo off

powershell -ExecutionPolicy Bypass -File "%~dp0Patch.ps1" %*
