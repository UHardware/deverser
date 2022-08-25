@echo off
color A
echo You need to set a password for the ROOT user for WSL. You will have to enter it twice when installing IMG4TOOL!
color 9
echo ------------------------------------------
echo                INSTRUCTION:
echo Type "passwd root" and enter your password
echo Type "exit" or close this window manually
echo Run (3) RUN Deverser.bat
echo ------------------------------------------
pause
wsl -u root 
