from flask import Flask, render_template, request, send_from_directory, redirect, url_for
import os
import subprocess
import uuid

app = Flask(__name__)

# Directories for uploads and converted files
UPLOAD_FOLDER = '/home/jason/Desktop/projects/linux-video-format-converter/uploads'
CONVERTED_FOLDER = '/home/jason/Desktop/projects/linux-video-format-converter/converted'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(CONVERTED_FOLDER, exist_ok=True)

@app.route('/')
def index():
    return render_template('index.html')  # Show the upload form

@app.route('/convert', methods=['POST'])
def convert():
    try:
        source_file = request.files['source_file']
        target_format = request.form['target_format']
        unique_id = uuid.uuid4().hex  # Unique ID for file naming
        
        # Save the uploaded file
        source_path = os.path.join(UPLOAD_FOLDER, f"{unique_id}.{source_file.filename.rsplit('.', 1)[-1]}")
        source_file.save(source_path)
        
        # Determine the target path
        target_filename = f"{unique_id}.{target_format}"
        target_path = os.path.join(CONVERTED_FOLDER, target_filename)
        
        # Convert the video using FFmpeg
        subprocess.run(['ffmpeg', '-i', source_path, target_path], check=True)
        
        # Redirect to the download route after conversion
        return redirect(url_for('download_file', filename=target_filename))
    except Exception as e:
        return f"Error during conversion: {e}"

@app.route('/downloads/<filename>')
def download_file(filename):
    # Serve the converted file for download
    return send_from_directory(CONVERTED_FOLDER, filename, as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True)

