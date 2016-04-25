del /q /s *.dcu
del /q /s *.exe
del /q /s *.dll
del /q /s *.cbk
del /q /s *.drc
del /q /s *.dsk
del /q /s *.dsm
del /q /s *.identcache
del /q /s *.local
del /q /s *.map
del /q /s *.ico
del /q /s *.otares
del /q /s *.stat

rmdir /Q /S Lib\__history
rmdir /Q /S Lib\__recovery
rmdir /Q /S GDIPlus\__history
rmdir /Q /S GDIPlus\__recovery
rmdir /Q /S "Packages\Delphi DX10\__history"
rmdir /Q /S "Packages\Delphi DX10\__recovery"
rmdir /Q /S "Packages\Delphi DX10.1\__history"
rmdir /Q /S "Packages\Delphi DX10.1\__recovery"

rmdir /Q /S bin
pause
