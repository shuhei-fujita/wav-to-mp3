#!/bin/bash

# 使い方: ./wav-to-mp4.sh input.wav

set -e

if [ "$#" -ne 1 ]; then
  echo "使い方: $0 input.wav"
  exit 1
fi

INPUT_WAV="$1"
BASENAME="${INPUT_WAV%.*}"
MP3_FILE="${BASENAME}.mp3"
MP4_FILE="${BASENAME}.mp4"
COVER_IMAGE="cover.jpg"

# WAV → MP3 変換
echo "🔄 Converting $INPUT_WAV to $MP3_FILE..."
ffmpeg -y -i "$INPUT_WAV" -codec:a libmp3lame -qscale:a 2 "$MP3_FILE"

# 静止画チェック
if [ ! -f "$COVER_IMAGE" ]; then
  echo "❌ cover.jpg が見つかりません。MP4 生成には静止画像が必要です。"
  exit 1
fi

# MP3 → MP4 変換（静止画付き）
echo "🎥 Creating $MP4_FILE from $MP3_FILE and $COVER_IMAGE..."
ffmpeg -y -loop 1 -i "$COVER_IMAGE" -i "$MP3_FILE" -c:v libx264 -tune stillimage -c:a aac -b:a 192k -shortest "$MP4_FILE"

# 中間生成物（MP3）を削除
echo "🧹 Removing intermediate file: $MP3_FILE"
rm "$MP3_FILE"

echo "✅ 完了: $MP4_FILE を生成し、$MP3_FILE を削除しました。"
