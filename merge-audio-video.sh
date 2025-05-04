#!/bin/bash

# 使い方: ./merge-audio-video.sh 映像ファイル 音声ファイル [出力ファイル名]
# 例: ./merge-audio-video.sh videos/input.mov audios/input.wav

set -e

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
  echo "使い方: $0 映像ファイル 音声ファイル [出力ファイル名]"
  exit 1
fi

VIDEO_FILE="$1"
AUDIO_FILE="$2"

# 拡張子を除いたベース名を取得
VIDEO_BASE="$(basename "$VIDEO_FILE" | sed 's/\.[^.]*$//')"
AUDIO_BASE="$(basename "$AUDIO_FILE" | sed 's/\.[^.]*$//')"

if [ "$#" -eq 3 ]; then
  OUTPUT_FILE="$3"
else
  OUTPUT_FILE="videos/merged_${VIDEO_BASE}_${AUDIO_BASE}.mp4"
fi

if [ ! -f "$VIDEO_FILE" ]; then
  echo "❌ $VIDEO_FILE が見つかりません。"
  exit 1
fi
if [ ! -f "$AUDIO_FILE" ]; then
  echo "❌ $AUDIO_FILE が見つかりません。"
  exit 1
fi

echo "🎬 映像: $VIDEO_FILE"
echo "🎵 音声: $AUDIO_FILE"
echo "➡️  出力: $OUTPUT_FILE"

ffmpeg -y -i "$VIDEO_FILE" -i "$AUDIO_FILE" -c:v libx264 -c:a aac -map 0:v:0 -map 1:a:0 -shortest "$OUTPUT_FILE"

echo "✅ 完了: $OUTPUT_FILE を生成しました。" 