$choco = ':\ProgramData\chocolatey'

if (Test-Path $choco) {
  Remove-Item -Recurse -Force $choco
  Write-Host "Chocolatey is deleted"
} else {
  Write-Host "Chocolatey doesn't exist, no need to delete"
}

.\setupWin.ps1
