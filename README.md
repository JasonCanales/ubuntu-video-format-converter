# Web App Version Documentation

## Overview
This document outlines the web app version of the video conversion tool, developed on the 'web-app-version' branch. This version introduces a web interface allowing users to upload video files, select a target conversion format, and download the converted file.

## Features
- **File Upload**: Users can upload video files for conversion.
- **Format Selection**: Users can select the desired output format from a dropdown menu.
- **File Conversion**: The application converts the uploaded video file to the selected format using FFmpeg.
- **File Download**: Users can download the converted file directly from the web interface.

## Technical Details
- The web app is built using the Flask framework for Python.
- Video file conversion is handled by FFmpeg, which must be installed on the server.
- Uploaded and converted files are temporarily stored in designated directories on the server.

## Setup and Installation
1. Ensure Python and Flask are installed on your system.
2. Install FFmpeg and ensure it's accessible in your system's PATH.
3. Clone the repository and switch to the 'web-app-version' branch.
4. Install required Python packages listed in 'requirements.txt'.
5. Run the Flask application.

## Usage
- Navigate to the web app's URL in a web browser.
- Use the file upload button to select a video file.
- Choose the desired output format from the dropdown menu.
- Click the 'Convert' button to start the conversion process.
- Download the converted file once the conversion is complete.

## Contributing
Contributions to the web app version are welcome. Please follow the project's contributing guidelines when submitting pull requests or reporting issues.