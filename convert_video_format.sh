#!/bin/bash

echo "Enter the source directory:"
read SOURCE_DIR

echo "Enter the output directory:"
read OUTPUT_DIR

# Preset list of video formats ffmpeg supports converting to
declare -a TO_FORMATS=("mkv" "mp4" "avi" "mov")

echo "Select the target format by entering the number:"
for i in "${!TO_FORMATS[@]}"; do
  echo "$((i+1))) ${TO_FORMATS[$i]}"
done

read TO_FORMAT_INDEX
TO_FORMAT="${TO_FORMATS[$((TO_FORMAT_INDEX-1))]}"

# Create the output directory if it does not exist
mkdir -p "$OUTPUT_DIR"

# Find all video files in the source directory (assuming common video file extensions)
find "$SOURCE_DIR" -type f \( -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.avi" -o -iname "*.mov" \) | while read FILE; do
  # Extract the filename without the extension
  FILENAME=$(basename -- "$FILE")
  FILENAME_WITHOUT_EXT="${FILENAME%.*}"

  # Construct the output file path
  OUTPUT_FILE="$OUTPUT_DIR/$FILENAME_WITHOUT_EXT.$TO_FORMAT"
  
  # Convert the file
  echo "Converting $FILE to $OUTPUT_FILE"
  ffmpeg -i "$FILE" -codec copy "$OUTPUT_FILE"
done

echo "Conversion complete."
