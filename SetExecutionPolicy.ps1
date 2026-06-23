$answer = Read-Host "Set the execution policy to RemoteSigned? (y/n)"
if ($answer.ToLower() -eq "y") {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
}