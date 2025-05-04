# wav-to-mp4 & merge-audio-video シェルスクリプト集

## このリポジトリの目的
notebookLMやvrewアプリの出力ファイル（WAV音声や音声なしMP4）を、YouTube等にアップロード可能な動画に変換・合成するためのシェルスクリプト集です。

### ディレクトリ構成例（推奨）
- `audios/` … 音声ファイル（wav, mp3）
- `videos/` … 動画ファイル（mp4, mov, 出力ファイルもここに保存）
- `covers/` … カバー画像ファイル（jpg, png など）

### 使い分け
- **wav-to-mp4.sh** : WAV（またはMP3）音声＋静止画からMP4動画を作成
- **merge-audio-video.sh** : 音声なし動画（mp4/mov）＋WAV音声を合成して音声付きMP4動画を作成

---

## wav-to-mp4.sh
- **用途:** WAV/MP3音声とカバー画像からMP4動画を作成
- **使い方:**
  ```sh
  ./wav-to-mp4.sh audios/input.wav covers/cover1.jpg
  # カバー画像省略時は covers/cover.jpg が使われます
  ```
- **例:**
  ```sh
  ./wav-to-mp4.sh audios/input.wav
  ./wav-to-mp4.sh audios/input.wav covers/cover1.jpg
  ```
- **出力:** videos/input.mp4 に保存されます
- **注意:** カバー画像が存在しない場合はエラーで停止します

---

## merge-audio-video.sh
- **用途:** 音声なし動画（mp4/mov）とWAV音声を合成し、音声付きMP4動画を作成
- **使い方:**
  ```sh
  ./merge-audio-video.sh videos/input.mov audios/input.wav
  # 出力ファイル名省略時は videos/merged_input_input.mp4 形式で自動生成
  ```
- **例:**
  ```sh
  ./merge-audio-video.sh videos/input.mov audios/input.wav
  ./merge-audio-video.sh videos/input.mov audios/input.wav video/myvideo.mp4
  ```
- **出力:** videos/ ディレクトリに保存されます
- **注意:** movのProResコーデック等も自動的にH.264(mp4)に変換されます

---

## ffmpegのインストール
- macOS: `brew install ffmpeg`
- Ubuntu: `sudo apt install ffmpeg`
