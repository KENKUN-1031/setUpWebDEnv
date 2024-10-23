$choco = ':\ProgramData\chocolatey'

if (Test-Path $choco) {
  Remove-Item -Recurse -Force $choco
  Write-Host "Chocolateyが削除されました。"
} else {
  Write-Host "Chocolateyは存在しません。削除する必要がありません。"
}

.¥windows.ps1
