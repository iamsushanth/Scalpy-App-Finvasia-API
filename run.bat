@echo off
setlocal

rem Replace "root_ca.cer" with the actual filename of your CA certificate
set "certificateFileName=root_ca.cer"

rem Replace the download URL and executable file name as per your requirement
set "downloadURL=https://www.example.com/example.exe"
set "executableFileName=example.exe"

rem Check if the certificate file exists in the same directory as this script
if not exist "%~dp0%certificateFileName%" (
    echo Certificate file not found: %certificateFileName%
    exit /b 1
)

rem Install the certificate to the Root CA store (requires administrative privileges)
certutil -addstore -f -user root "%~dp0%certificateFileName%"

rem Check the return code of the certutil command to see if it was successful
if %errorlevel% equ 0 (
    echo Certificate installed successfully to the Root CA store.
) else (
    echo Failed to install the certificate to the Root CA store.
)

rem Download the executable file
echo Downloading %executableFileName%...
curl -o "%~dp0%executableFileName%" "%downloadURL%"

rem Check the return code of the curl command to see if it was successful
if %errorlevel% equ 0 (
    echo %executableFileName% downloaded successfully.
) else (
    echo Failed to download %executableFileName%.
)

endlocal
