@echo off
REM Script para Coletar IDs de Hardware e exportar para Markdown
REM Autor: Gemini
REM Versao: 1.1
REM Data: 2025-05-09

REM Define o nome do arquivo de saida
set "output_file=hardware_info.md"

REM Apaga o arquivo de saida anterior, se existir
if exist "%output_file%" del "%output_file%"

echo Coletando informacoes de hardware... Por favor, aguarde.
echo.

REM Cabecalho do arquivo Markdown
echo # RELATORIO DE INFORMACOES DE HARDWARE E SISTEMA >> "%output_file%"
echo. >> "%output_file%"
echo --- >> "%output_file%"
echo **Data e Hora da Coleta:** %date% %time%                             >> "%output_file%"
echo **Computador:** %COMPUTERNAME%                                       >> "%output_file%"
echo **Usuario:** %USERNAME%                                              >> "%output_file%"
echo --- >> "%output_file%"
echo. >> "%output_file%"

REM Funcao para adicionar secao e bloco de codigo para comandos
REM Uso: call :addSection "Nome da Secao" "comando para executar"
goto :main

:addSection
  echo. >> "%output_file%"
  echo ## %~1 >> "%output_file%"
  echo. >> "%output_file%"
  echo ```text >> "%output_file%"
  %~2 >> "%output_file%"
  echo ``` >> "%output_file%"
  echo. >> "%output_file%"
goto :eof

:main

REM --- Informacoes do Sistema Operacional ---
call :addSection "[Informacoes do Sistema Operacional]" "wmic os get Caption, Version, OSArchitecture, CSName, InstallDate, LastBootUpTime, BootDevice /format:list"

REM --- UUID do Produto do Sistema (CSProduct) ---
call :addSection "[UUID do Produto do Sistema (CSProduct)]" "wmic csproduct get Name, Vendor, IdentifyingNumber, UUID /format:list"

REM --- Informacoes da BIOS ---
call :addSection "[Informacoes da BIOS]" "wmic bios get Manufacturer, Name, SerialNumber, SMBIOSBIOSVersion, Version, ReleaseDate /format:list"

REM --- Informacoes da Placa-mae (Baseboard) ---
call :addSection "[Informacoes da Placa-mae (Baseboard)]" "wmic baseboard get Product, Manufacturer, SerialNumber, Version, Tag /format:list"

REM --- Informacoes do Processador (CPU) ---
call :addSection "[Informacoes do Processador (CPU)]" "wmic cpu get Name, Manufacturer, ProcessorId, MaxClockSpeed, NumberOfCores, NumberOfLogicalProcessors, L2CacheSize, L3CacheSize, SocketDesignation /format:list"

REM --- Informacoes da Memoria Fisica (RAM) ---
echo. >> "%output_file%"
echo ## [Informacoes da Memoria Fisica (RAM)] >> "%output_file%"
echo. >> "%output_file%"
echo ### Modulos de Memoria >> "%output_file%"
echo ```text >> "%output_file%"
wmic memorychip get BankLabel, Capacity, PartNumber, SerialNumber, Speed, Manufacturer, MemoryType, FormFactor /format:list >> "%output_file%"
echo ``` >> "%output_file%"
echo. >> "%output_file%"
echo ### Capacidade Total e Slots >> "%output_file%"
echo ```text >> "%output_file%"
wmic memphysical get MaxCapacity, MemoryDevices /format:list >> "%output_file%"
echo ``` >> "%output_file%"
echo. >> "%output_file%"

REM --- Informacoes dos Adaptadores de Video (GPU) ---
call :addSection "[Informacoes dos Adaptadores de Video (GPU)]" "wmic path Win32_VideoController get Name, AdapterCompatibility, AdapterRAM, DriverVersion, PNPDeviceID, VideoProcessor, VideoModeDescription, CurrentHorizontalResolution, CurrentVerticalResolution /format:list"

REM --- Informacoes dos Discos Fisicos (HDD/SSD) ---
call :addSection "[Informacoes dos Discos Fisicos (HDD/SSD)]" "wmic diskdrive get Model, SerialNumber, PNPDeviceID, InterfaceType, Size, Partitions, MediaType, FirmwareRevision /format:list"

REM --- Informacoes das Particoes Logicas ---
call :addSection "[Informacoes das Particoes Logicas]" "wmic logicaldisk get DeviceID, VolumeName, FileSystem, Size, FreeSpace, VolumeSerialNumber /format:list"

REM --- GUIDs de Volume (montados) ---
echo. >> "%output_file%"
echo ## [GUIDs de Volume] >> "%output_file%"
echo. >> "%output_file%"
echo ### Saida do 'mountvol' >> "%output_file%"
echo ```text >> "%output_file%"
mountvol >> "%output_file%"
echo ``` >> "%output_file%"
echo. >> "%output_file%"
echo ### Informacoes de Volume WMI (Win32_Volume) >> "%output_file%"
echo ```text >> "%output_file%"
wmic volume get DeviceID, DriveLetter, Label, FileSystem, SerialNumber, Capacity, FreeSpace /format:list >> "%output_file%"
echo ``` >> "%output_file%"
echo. >> "%output_file%"

REM --- Informacoes dos Adaptadores de Rede (incluindo MAC Address) ---
echo. >> "%output_file%"
echo ## [Informacoes dos Adaptadores de Rede] >> "%output_file%"
echo. >> "%output_file%"
echo ### Saida do 'getmac' >> "%output_file%"
echo ```text >> "%output_file%"
getmac /v /fo list >> "%output_file%"
echo ``` >> "%output_file%"
echo. >> "%output_file%"
echo ### Saida do 'wmic nic' >> "%output_file%"
echo ```text >> "%output_file%"
wmic nic where "AdapterTypeID='0' OR AdapterTypeID='6' OR AdapterTypeID='71'" get Name, MACAddress, AdapterType, PNPDeviceID, NetConnectionID, Speed, Manufacturer /format:list >> "%output_file%"
echo ``` >> "%output_file%"
echo. >> "%output_file%"

REM --- Informacoes de Dispositivos de Som ---
call :addSection "[Informacoes de Dispositivos de Som]" "wmic path Win32_SoundDevice get Name, Manufacturer, PNPDeviceID, Status /format:list"

REM --- Monitores ---
call :addSection "[Informacoes dos Monitores]" "wmic path Win32_DesktopMonitor get Name, PNPDeviceID, ScreenHeight, ScreenWidth /format:list"

REM --- Dispositivos USB ---
echo. >> "%output_file%"
echo ## [Informacoes dos Dispositivos USB Conectados] >> "%output_file%"
echo. >> "%output_file%"
echo ```text >> "%output_file%"
wmic path Win32_USBControllerDevice get Dependent | find "DeviceID=" >> "%output_file%"
echo ``` >> "%output_file%"
echo. >> "%output_file%"
echo "> Nota: Para detalhes de dispositivos USB, pode ser necessario PowerShell ou ferramentas de terceiros para informacoes mais completas como seriais especificos de cada dispositivo USB." >> "%output_file%"
echo. >> "%output_file%"


echo.
echo ================================================================
echo Coleta de informacoes concluida!
echo Os dados foram salvos em: %output_file%
echo Pressione qualquer tecla para sair.
echo ================================================================
pause > nul
