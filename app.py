from flask import Flask, send_from_directory
from flask_cors import CORS
from convert import convert_bp
import os

app = Flask(__name__, static_folder='frontend/build', static_url_path='')
CORS(app)  # Enable CORS globally for all routes. Configure as needed.
app.register_blueprint(convert_bp)  # Register the convert Blueprint

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    if path and os.path.exists(os.path.join(app.static_folder, path)):
        return send_from_directory(app.static_folder, path)
    return send_from_directory(app.static_folder, 'index.html')

if __name__ == '__main__':
    app.run(debug=True)
