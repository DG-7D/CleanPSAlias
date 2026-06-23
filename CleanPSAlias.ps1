param( [switch]$Verbose )

$aliases = Get-Alias
foreach ($alias in $aliases) {
    $commands = Get-Command $alias.Name -All
    $before = $null
    $after = $null
    foreach ($command in $commands) {
        if ($null -eq $after -and $command.CommandType -eq "Application") {
            $after = $command.Definition
        } elseif ($null -eq $before) {
            $before = $command.Definition
        }
    }
    if ($null -ne $after -and $null -ne $before) {
        if ($Verbose) {
            Write-Host ($alias.Name + " : " + $before + " -> " + $after)
        }
        Remove-Item "Alias:$($alias.Name)" -Force
    }
}

if ($Verbose) {
    Write-Host "`nTo add this script to `$PROFILE, run ``.\AddToProfile.ps1``"
}