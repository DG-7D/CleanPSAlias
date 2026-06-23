$blacklist = @("?")
$names = Get-Command -CommandType Alias,Function -All | Where-Object {$_.Source -eq "" -and $blacklist -notcontains $_.Name} | Select-Object -ExpandProperty Name

$psname = (Get-Process -Id $PID).ProcessName
$cleanerName = "generated\$psname.ps1"
Set-Content -Path $cleanerName -Value $null -Force

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
            Add-Content -Path $cleanerName -Value "Remove-Item `"Alias:$name`" -Force"
            Write-Host "Alias $name :" $before.Definition "->" $after.Definition
        }
        "Function" {
            Add-Content -Path $cleanerName -Value "Remove-Item `"Function:$name`" -Force"
            Write-Host "Function $name ->" $after.Definition
        }
    }
    
}

. (Get-Item -Path $cleanerName).FullName

Write-Host "`nTo add this script to `$PROFILE, run ``.\AddToProfile.ps1``"
