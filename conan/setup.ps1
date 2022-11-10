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

# Because this library is standalone with no other conan dependencies we have no need to add the https://wducharme.jfrog.io/artifactory/api/conan/cpp-packages remote
# It should be entirely up to CI/CD automation to add the remote, create the package and then upload.

# Will fail to start process when we have python or the venv in a path with spaces
# $VenvConan = "$VenvPath/Scripts/conan.exe"

# Will produce an error when the remote is already added. Happens when the user cache already had the remote added.
# Invoke-Expression "$VenvConan remote add wducharme-cpp-packages https://wducharme.jfrog.io/artifactory/api/conan/cpp-packages"
