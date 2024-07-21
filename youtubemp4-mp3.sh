#!/bin/bash


print_banner() {
  tput cup 0 0
  echo -e "[---------------------------------]"
  echo -e "         youtube to mp4/mp3"
  echo -e "[---------------------------------]"
}


if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing..."
  sleep 1
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  sleep 2
  clear
else
  echo "Homebrew is already installed."
  sleep 2
  clear
fi

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if youtube-dl is installed
if ! command_exists yt-dlp; then
  echo "yt-dlp not found. Installing..."
  brew install yt-dlp
fi

# Check if ffmpeg is installed
if ! command_exists ffmpeg; then
  echo "ffmpeg not found. Installing..."
  brew install ffmpeg
fi


clear
print_banner
echo
echo
echo "MP3 OR MP4"
read input1
input1=$(echo "$input1" | tr '[:lower:]' '[:upper:]')

if [ "$input1" = "MP4" ]; then
    echo "[MP4] Enter link" 
    read inputmp4
    yt-dlp -o "downloaded_video.%(ext)s" "$inputmp4"
    output_file="converted_video.mp4"
    downloaded_file=$(ls downloaded_video.* | head -n 1)
ffmpeg -i "$downloaded_file" -c:v libx264 -crf 18 -preset slow -c:a aac -b:a 192k "$output_file"
clear
echo "Downloaded succesfully"

    elif [ "$input1" = "MP3" ]; then
    echo "[MP3] Enter Link"
    read inputmp3
    yt-dlp -x --audio-format mp3 "$inputmp3"
    clear
    echo "Downloaded succesfully"
else
echo "Invalid Option"
exit 0
fi

rm "$downloaded_file"

