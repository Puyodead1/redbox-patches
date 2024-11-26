@echo off

powershell -ExecutionPolicy Bypass -File "%~dp0CreatePatch.ps1" %*
