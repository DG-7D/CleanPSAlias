@powershell -ExecutionPolicy RemoteSigned -File ".\SetExecutionPolicy.ps1"
@powershell -NoLogo -NoExit -NoProfile -ExecutionPolicy RemoteSigned -File ".\CleanPSAlias.ps1" -Verbose