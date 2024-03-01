#!/bin/bash

echo "Enter the source directory:"
read SOURCE_DIR

echo "Enter the output directory:"
read OUTPUT_DIR

# Preset lists of video formats
declare -a FROM_FORMATS=("mkv" "mp4" "avi" "mov")
declare -a TO_FORMATS=("mkv" "mp4" "avi" "mov")

echo "Select the source format by entering the number:"
for i in "${!FROM_FORMATS[@]}"; do
  echo "$((i+1))) ${FROM_FORMATS[$i]}"
done

read FROM_FORMAT_INDEX
FROM_FORMAT="${FROM_FORMATS[$((FROM_FORMAT_INDEX-1))]}"

# Remove the selected source format from the TO_FORMATS array
TO_FORMATS=("${TO_FORMATS[@]/$FROM_FORMAT}")

echo "Select the target format by entering the number:"
for i in "${!TO_FORMATS[@]}"; do
  echo "$((i+1))) ${TO_FORMATS[$i]}"
done

read TO_FORMAT_INDEX
TO_FORMAT="${TO_FORMATS[$((TO_FORMAT_INDEX-1))]}"

# Create the output directory if it does not exist
mkdir -p "$OUTPUT_DIR"

# Loop through all files in the source directory with the selected source format
for FILE in "$SOURCE_DIR"/*.$FROM_FORMAT; do
  FILENAME=$(basename -- "$FILE" .$FROM_FORMAT)
  OUTPUT_FILE="$OUTPUT_DIR/$FILENAME.$TO_FORMAT"
  
  # Convert the file
  echo "Converting $FILE to $OUTPUT_FILE"
  ffmpeg -i "$FILE" -codec copy "$OUTPUT_FILE"
done

echo "Conversion complete."
