# wav-to-mp4.sh 使い方

このリポジトリには、WAV音声ファイルをMP4動画（静止画付き）に変換するシェルスクリプト `wav-to-mp4.sh` が含まれています。

## 概要
- 入力: WAVファイル（例: `input.wav`）
- 出力: MP4ファイル（例: `input.mp4`）
- 変換時にカバー画像（`cover.jpg`）が必要です
- 変換途中でMP3ファイルを一時生成しますが、最終的に削除されます

## 必要なもの
- ffmpeg（インストールされている必要があります）
- cover.jpg（MP4に埋め込む静止画像。スクリプトと同じディレクトリに配置してください）

## 使い方
```sh
./wav-to-mp4.sh 入力ファイル.wav
```
例:
```sh
./wav-to-mp4.sh General\ Questions\ on\ the\ Small\ Business\ Subsidies.wav
```

## 実行の流れ
1. WAVファイルをMP3に変換
2. cover.jpgとMP3を合成してMP4を生成
3. 中間生成物（MP3）を自動削除

## 注意事項
- `cover.jpg` が存在しない場合、スクリプトはエラーで停止します
- ffmpegが必要です。インストールされていない場合は、以下でインストールできます:
  - macOS: `brew install ffmpeg`
  - Ubuntu: `sudo apt install ffmpeg`

## ライセンス
ご自由にご利用ください。 