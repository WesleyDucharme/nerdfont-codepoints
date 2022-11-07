Set-Location $PSScriptRoot

$VenvPath = "./.venv"

if (Test-Path $VenvPath)
{
    Remove-Item $VenvPath -Recurse -Force
}

Invoke-Expression "python -m venv $VenvPath"

$VenvPython = "$VenvPath/Scripts/python.exe"

Invoke-Expression "$VenvPython -m pip install --upgrade pip"
Invoke-Expression "$VenvPython -m pip install -r ./requirements.txt"

# Will fail to start process when we have python or the venv in a path with spaces...
$VenvConan = "$VenvPath/Scripts/conan.exe"
Invoke-Expression $VenvConan