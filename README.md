# Video Format Converter

This project is a simple shell script that allows users to convert video files from one format to another. It utilizes FFmpeg for the conversion process.

## Features

- Convert video files to a specified format.
- Interactive prompts for source and target directory selection.
- Supports a variety of video formats.

## Requirements

- FFmpeg must be installed on the system where the script is run.
- The script should have execute permissions to run.

## Installation

### FFmpeg

To install FFmpeg on your system, follow these instructions:

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install ffmpeg
```

#### CentOS
```bash
sudo yum install epel-release
sudo yum install ffmpeg
```

#### MacOS
```bash
brew install ffmpeg
```

#### Windows

Download the FFmpeg builds from [FFmpeg Official Website](https://ffmpeg.org/download.html) and follow the instructions to add it to your system path.

### Script Permissions

To make the `convert_video_format.sh` script executable, run the following command:

```bash
chmod +x convert_video_format.sh
```

## Usage

1. Clone the repository to your local machine.
2. Run the script via the terminal with `./convert_video_format.sh`.
3. Follow the interactive prompts to select the source directory, the target directory, and the desired output format.

## License

This project is open source and available under the MIT License.