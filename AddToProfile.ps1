if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

$fullPath = (Get-Item -Path "CleanPSAlias.ps1").FullName
Add-Content -Path $PROFILE -Value "Invoke-Expression `"$fullPath`""