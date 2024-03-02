from flask import Blueprint, request, jsonify, send_from_directory, current_app
import subprocess
import os
from werkzeug.utils import secure_filename

convert_bp = Blueprint('convert', __name__)

@convert_bp.route('/convert', methods=['POST'])
def convert():
    if 'source_file' not in request.files:
        return jsonify({"message": "No file part"}), 400
    file = request.files['source_file']
    target_format = request.form.get('target_format')
    
    if file and target_format:
        filename = secure_filename(file.filename)
        input_path = os.path.join(current_app.root_path, 'uploads', filename)
        os.makedirs(os.path.dirname(input_path), exist_ok=True)
        file.save(input_path)
        
        output_filename = f"{os.path.splitext(filename)[0]}.{target_format}"
        output_path = os.path.join(current_app.root_path, 'converted', output_filename)
        os.makedirs(os.path.dirname(output_path), exist_ok=True)

        cmd = ['ffmpeg', '-i', input_path, output_path]
        try:
            subprocess.run(cmd, check=True)
            return jsonify({"message": "Conversion successful", "filename": output_filename}), 200
        except subprocess.CalledProcessError as e:
            return jsonify({"message": "Conversion failed", "error": str(e)}), 500
    else:
        return jsonify({"message": "Missing file or target format"}), 400

@convert_bp.route('/downloads/<filename>', methods=['GET'])
def download(filename):
    directory = os.path.join(current_app.root_path, 'converted')
    return send_from_directory(directory, filename, as_attachment=True)
