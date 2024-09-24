#!/bin/bash

# Visual Studio Code のインストールを確認
if brew list --cask | grep -q "visual-studio-code"; then
  echo "Visual Studio Code はすでにインストールされています。"
else
  echo "Visual Studio Code をインストールします..."
  brew install --cask visual-studio-code
fi

# Prettier 拡張機能のインストールを確認
if code --list-extensions | grep -q "esbenp.prettier-vscode"; then
  echo "Prettier 拡張機能はすでにインストールされています。"
else
  echo "Prettier 拡張機能をインストールします..."
  code --install-extension esbenp.prettier-vscode
fi

# すべての処理が完了したことを通知
echo "すべてのインストールが完了しました！"
