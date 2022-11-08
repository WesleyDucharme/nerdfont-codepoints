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

# Will fail to start process when we have python or the venv in a path with spaces
$VenvConan = "$VenvPath/Scripts/conan.exe"

# Will produce an error when the remote is already added. Happens when the user cache already had the remote added.
# We could try to set the environment variable CONAN_USER_HOME to change this to be local to the repository and clear it in this script. Avoiding it for simplicity.
Invoke-Expression "$VenvConan remote add wducharme-cpp-packages https://wducharme.jfrog.io/artifactory/api/conan/cpp-packages"
