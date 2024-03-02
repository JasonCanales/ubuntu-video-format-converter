import React, { useState } from 'react';
import './VideoConverter.css'; // Assuming you have modern styles defined here

function VideoConverter() {
  const [file, setFile] = useState(null);
  const [format, setFormat] = useState('');
  const [formats, setFormats] = useState(['mp4', 'avi', 'mov']); // Example formats
  const [downloadLink, setDownloadLink] = useState('');
  const [isConverting, setIsConverting] = useState(false);

  const handleFileChange = (event) => {
    setFile(event.target.files[0]);
    setDownloadLink('');
    setIsConverting(false);
    // Reset format selection when a new file is chosen
    setFormat('');
  };

  const handleFormatChange = (event) => {
    setFormat(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    setIsConverting(true); // Show converting status

    const formData = new FormData();
    formData.append('source_file', file);
    formData.append('target_format', format);

    try {
      const response = await fetch('http://localhost:5000/convert', {
        method: 'POST',
        body: formData,
      });
      const data = await response.json();
      if (response.ok) {
        setDownloadLink(`/downloads/${data.filename}`);
        setIsConverting(false); // Hide converting status
      } else {
        alert(`Conversion failed: ${data.message}`);
        setIsConverting(false);
      }
    } catch (error) {
      console.error('Error:', error);
      alert('An error occurred. Please try again.');
      setIsConverting(false);
    }
  };

  return (
    <div className="container">
      <h1>Video Converter</h1>
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="source_file">Choose video file:</label>
          <input type="file" id="source_file" name="source_file" accept="video/*" onChange={handleFileChange} required />
        </div>
        {file && (
          <div>
            <label htmlFor="target_format">Choose output format:</label>
            <select id="target_format" name="target_format" value={format} onChange={handleFormatChange} required>
              <option value="">Select a format</option>
              {formats.map(f => (
                <option key={f} value={f}>{f.toUpperCase()}</option>
              ))}
            </select>
          </div>
        )}
        {format && !isConverting && (
          <input type="submit" value="Convert" />
        )}
        {isConverting && <p>Converting...</p>}
      </form>
      {downloadLink && (
        <div>
          <a href={downloadLink} download>Download Converted File</a>
        </div>
      )}
    </div>
  );
}

export default VideoConverter;
