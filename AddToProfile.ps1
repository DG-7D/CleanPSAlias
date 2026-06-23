$psname = (Get-Process -Id $PID).ProcessName

if ($psname -eq "powershell") {
    $answer = Read-Host "Set the execution policy to RemoteSigned? (y/n)"
    if ($answer.ToLower() -eq "y") {
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
    }
}
$cleanerName = "generated\$psname.ps1"

if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}
$fullPath = (Get-Item -Path "generated\$psname.ps1").FullName
Add-Content -Path $PROFILE -Value ". `"$fullPath`""