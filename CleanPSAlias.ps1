param( [switch]$Verbose )

if ($Verbose -and (Get-Process -Id $PID).ProcessName -eq "powershell") {
    $answer = Read-Host "Set the execution policy to RemoteSigned? (y/n)"
    if ($answer.ToLower() -eq "y") {
        Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
    }
}

$blacklist = @("?")
$names = Get-Command -CommandType Alias,Function -All | Where-Object {$_.Source -eq "" -and $blacklist -notcontains $_.Name} | Select-Object -ExpandProperty Name
foreach ($name in $names) {
    $commands = Get-Command $name -All
    if ($commands.Count -eq 1) { continue }
    $before = $null
    $after = $null
    foreach ($command in $commands) {
        if ($null -eq $after -and $command.CommandType -eq "Application") {
            $after = $command
        } elseif ($null -eq $before) {
            $before = $command
        }
    }
    switch ($before.CommandType) {
        "Alias" {
            Remove-Item "Alias:$name" -Force
            if ($Verbose) {
                Write-Host "Alias $name :" $before.Definition "->" $after.Definition
            }
        }
        "Function" {
            Remove-Item "Function:$name" -Force
            if ($Verbose) {
                Write-Host "Function $name ->" $after.Definition
            }
        }
    }
    
}

if ($Verbose) {
    Write-Host "`nTo add this script to `$PROFILE, run ``.\AddToProfile.ps1``"
}