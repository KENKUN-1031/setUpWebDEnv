# ファイルの説明

各ファイルの説明と使用方法を記述してます！！

## extension.sh

### 説明

必要な拡張機能や plugin をダウンロードするための shell ファイル

ダウンロードされる物

- homebrew
- vsCode をいじるためのコマンド
- prettier
- liverServer

全てのダウンロードが終了すると "すべての処理が完了しました！"というメッセージが流れます

### 実行方法

#### windows の場合

powershell の管理者権限でファイル直下まで移動してください！

以下のコマンドを実行してください！↓

`Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`

↓

`Remove-Item -Recurse -Force C:\ProgramData\chocolatey`

↓

`.¥windows.ps1`

Notes: 処理が止まった場合は Enter を押したら進みます！！

#### mac の場合

`sh extension.sh`

## settings.json

### 説明

各プロジェクトごとにコードを綺麗に整理整頓してくるコード(設定を workspace に変える必要があります！)

例：

- タブを押した時のスペースの数
- 一番下の行に改行を入れるなどなど
