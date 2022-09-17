echo off
cls
echo Make sure that the figure you want to install is,
echo 1. Named character.rbxm
echo 2. In the same folder that this script is in
pause >nul
cls
echo 06blox should be installed via the installer, into the correct location,
pause >nul
cls
del "C:\Program Files\06blox\content\fonts\character.rbxm"
move character.rbxm "C:\Program Files\06blox\content\fonts"
cls
echo Your character should be replaced, if you join a game, it should have changed.
echo Thank you for using this tool.
pause >nul
cls
exit
