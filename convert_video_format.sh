#!/bin/bash

# Prompt user for the source directory and read the input
echo "Enter the source directory:"
read SOURCE_DIR

# Prompt user for the output directory and read the input
echo "Enter the output directory:"
read OUTPUT_DIR

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
