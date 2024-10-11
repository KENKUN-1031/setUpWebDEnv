[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# PowerShellスクリプト

# エラーハンドリングの有効化
$ErrorActionPreference = "Stop"

# エラー時に実行される関数
function ErrorHandler {
    Write-Host "エラーが発生しました。処理を終了します。" -ForegroundColor Red
    exit 1
}

# トラップの設定（エラー発生時に ErrorHandler を呼び出す）
trap {
    ErrorHandler
    continue
}

function AllInstall {
    # Chocolatey のインストール確認
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "Chocolatey はすでにインストールされています。"
    }
    else {
        Write-Host "Chocolatey がインストールされていません。インストールを開始します..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }

    # Visual Studio Code のインストール確認
    if (choco list --local-only | Select-String -Pattern "vscode") {
        Write-Host "Visual Studio Code はすでにインストールされています。"
    }
    else {
        Write-Host "Visual Studio Code をインストールします..."
        choco install vscode -y
    }

    # Visual Studio Code の拡張機能のインストールを確認して、なければインストールする
    Write-Host "Visual Studio Code の拡張機能をインストールしています..."

    # Prettier 拡張機能のインストール確認とインストール
    $prettierExtension = & code --list-extensions | Select-String "esbenp.prettier-vscode"
    if ($prettierExtension) {
        Write-Host "Prettier 拡張機能はすでにインストールされています。"
    }
    else {
        Write-Host "Prettier 拡張機能をインストールします..."
        & code --install-extension esbenp.prettier-vscode
    }

    # Live Server 拡張機能のインストール確認とインストール
    $liveServerExtension = & code --list-extensions | Select-String "ritwickdey.liveserver"
    if ($liveServerExtension) {
        Write-Host "Live Server 拡張機能はすでにインストールされています。"
    }
    else {
        Write-Host "Live Server 拡張機能をインストールします..."
        & code --install-extension ritwickdey.liveserver
    }
}  # ここに閉じ括弧を追加

# 関数を実行
AllInstall

# 正常終了時のメッセージ
Write-Host "すべての処理が完了しました！" -ForegroundColor Green
