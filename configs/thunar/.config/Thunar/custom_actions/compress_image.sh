#!/bin/bash
# Thunar custom action to compress images using FFmpeg

# Check if FFmpeg is installed
if ! command -v ffmpeg >/dev/null 2>&1; then
    zenity --error --text="FFmpeg not found. Please install FFmpeg."
    exit 1
fi

# Create output directory if it doesn't exist
DEST_DIR=$(dirname "$1")/compressed
mkdir -p "$DEST_DIR"

# Loop through selected files
for FILE in "$@"; do
    # Get the base filename and extension
    BASENAME=$(basename "$FILE")
    EXT="${BASENAME##*.}"
    NAME="${BASENAME%.*}"

    # Compress based on file type
    case "${EXT,,}" in
        jpg|jpeg)
            # JPEG compression: q:v 8 gives ~70% size reduction
            ffmpeg -i "$FILE" -q:v 8 -y "$DEST_DIR/${NAME}_compressed.jpg"
            ;;
        png)
            # PNG compression: maximum compression level
            ffmpeg -i "$FILE" -compression_level 9 -y "$DEST_DIR/${NAME}_compressed.png"
            ;;
        *)
            zenity --warning --text="Unsupported file format: $EXT"
            continue
            ;;
    esac
done

zenity --info --text="Images compressed successfully! Check the 'compressed' folder."
