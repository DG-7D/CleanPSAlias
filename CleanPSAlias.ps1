param( [switch]$Verbose )

$names = Get-Alias | Select-Object -ExpandProperty Name
foreach ($name in $names) {
    if ($name -eq "?") { continue }
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
    if ($Verbose) {
        Write-Host ("$name : " + $before.Definition + " -> " + $after.Definition)
    }
    Remove-Item "Alias:$name" -Force
}

if ($Verbose) {
    Write-Host "`nTo add this script to `$PROFILE, run ``.\AddToProfile.ps1``"
}