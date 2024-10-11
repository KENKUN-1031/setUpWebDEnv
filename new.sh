#!/bin/bash

# エラーハンドリングを有効化
set -e

# エラー時に実行される関数
error_handler() {
  echo "エラーが発生しました。処理を終了します。"
  exit 1
}

# エラーシグナルをキャッチして error_handler を呼び出す
trap 'error_handler' ERR

# OSを判定して適切な処理を実行
allinstall() {

  # OSの確認
  OS_TYPE="$(uname -s)"

  if [[ "$OS_TYPE" == "Darwin" ]]; then
    echo "macOS 環境を検出しました。"

    # Homebrewのインストールを確認
    if command -v brew >/dev/null 2>&1; then
      echo "Homebrew はすでにインストールされています。"
    else
      echo "Homebrew がインストールされていません。インストールを開始します..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      # パスの設定
      if [[ "$(uname -m)" == "arm64" ]]; then
        # Apple Silicon Macの場合
        eval "$(/opt/homebrew/bin/brew shellenv)"
      else
        # Intel Macの場合
        eval "$(/usr/local/bin/brew shellenv)"
      fi
    fi

    # Visual Studio Code のインストールを確認
    if brew list --cask | grep -q "visual-studio-code"; then
      echo "Visual Studio Code はすでにインストールされています。"
    else
      echo "Visual Studio Code をインストールします..."
      brew install --cask visual-studio-code
    fi

  elif [[ "$OS_TYPE" == "MINGW64_NT"* || "$OS_TYPE" == "MSYS_NT"* || "$OS_TYPE" == "CYGWIN_NT"* ]]; then
    echo "Windows 環境を検出しました。"

    # Chocolatey がインストールされているか確認
    if command -v choco >/dev/null 2>&1; then
      echo "Chocolatey はすでにインストールされています。"
    else
      echo "Chocolatey がインストールされていません。インストールを開始します..."
      powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    fi

    # Visual Studio Code のインストールを確認
    if choco list --local-only | grep -q "vscode"; then
      echo "Visual Studio Code はすでにインストールされています。"
    else
      echo "Visual Studio Code をインストールします..."
      choco install vscode -y
    fi

  else
    echo "サポートされていないOSです。"
    exit 1
  fi

  # 共通の処理（Windows/macOS 共通で VSCode 拡張機能のインストール）
  echo "Visual Studio Code の拡張機能をインストールしています..."

  # Prettier 拡張機能のインストールを確認
  if code --list-extensions | grep -q "esbenp.prettier-vscode"; then
    echo "Prettier 拡張機能はすでにインストールされています。"
  else
    echo "Prettier 拡張機能をインストールします..."
    code --install-extension esbenp.prettier-vscode
  fi

  # Live Server 拡張機能のインストールを確認
  if code --list-extensions | grep -q "ritwickdey.liveserver"; then
    echo "Live Server 拡張機能はすでにインストールされています。"
  else
    echo "Live Server 拡張機能をインストールします..."
    code --install-extension ritwickdey.liveserver
  fi
}

# 関数を実行
allinstall

# 正常終了時のメッセージ
echo "すべての処理が完了しました！"
