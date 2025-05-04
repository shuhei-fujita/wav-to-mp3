#!/bin/bash

# 使い方:
#   ./wav-to-mp4.sh 音声ファイル [カバー画像ファイル]
#   例: ./wav-to-mp4.sh audio/input.wav covers/cover1.jpg

set -e

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
  echo "使い方: $0 音声ファイル [カバー画像ファイル]"
  exit 1
fi

INPUT_FILE="$1"
BASENAME="$(basename "${INPUT_FILE%.*}")"
EXTENSION="${INPUT_FILE##*.}"

# カバー画像の指定（なければcovers/cover.jpg）
if [ "$#" -eq 2 ]; then
  COVER_IMAGE="$2"
else
  COVER_IMAGE="covers/cover.jpg"
fi

# 入力ファイルの拡張子に応じて処理を分岐
if [ "$EXTENSION" = "wav" ]; then
  # WAV → MP3 変換
  MP3_FILE="${BASENAME}.mp3"
  echo "🔄 Converting $INPUT_FILE to $MP3_FILE..."
  ffmpeg -y -i "$INPUT_FILE" -codec:a libmp3lame -qscale:a 2 "$MP3_FILE"
  AUDIO_FILE="$MP3_FILE"
elif [ "$EXTENSION" = "mp3" ]; then
  AUDIO_FILE="$INPUT_FILE"
else
  echo "❌ サポートされていないファイル形式です: $EXTENSION"
  exit 1
fi

MP4_FILE="video/${BASENAME}.mp4"

# 静止画チェック
if [ ! -f "$COVER_IMAGE" ]; then
  echo "❌ $COVER_IMAGE が見つかりません。MP4 生成には静止画像が必要です。"
  exit 1
fi

# MP3 → MP4 変換（静止画付き）
echo "🎥 Creating $MP4_FILE from $AUDIO_FILE and $COVER_IMAGE..."
ffmpeg -y -loop 1 -i "$COVER_IMAGE" -i "$AUDIO_FILE" -c:v libx264 -tune stillimage -c:a aac -b:a 192k -shortest "$MP4_FILE"

# 中間生成物（MP3）を削除（WAVから変換した場合のみ）
if [ "$EXTENSION" = "wav" ]; then
  echo "🧹 Removing intermediate file: $MP3_FILE"
  rm "$MP3_FILE"
fi

echo "✅ 完了: $MP4_FILE を生成しました。"
