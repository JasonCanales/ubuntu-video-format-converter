#!/bin/bash

# Directory containing the source .mkv files
SOURCE_DIR="/home/jason"

# Directory where you want to save the converted .mp4 files
OUTPUT_DIR="/home/jason"

# Create the output directory if it does not exist
mkdir -p "$OUTPUT_DIR"

# Loop through all .mkv files in the source directory
for FILE in "$SOURCE_DIR"/*.mkv; do
  # Use basename to get the file name without the path and extension
  FILENAME=$(basename -- "$FILE" .mkv)
  
  # Construct the output file path
  OUTPUT_FILE="$OUTPUT_DIR/$FILENAME.mp4"
  
  # Convert the file
  echo "Converting $FILE to $OUTPUT_FILE"
  ffmpeg -i "$FILE" -codec copy "$OUTPUT_FILE"
done

echo "Conversion complete."
