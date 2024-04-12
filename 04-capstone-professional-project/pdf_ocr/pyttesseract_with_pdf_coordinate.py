import fitz  # PyMuPDF
from PIL import Image
import pytesseract
import io

# Specify the installation path of Tesseract and modify it according to your actual installation location
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'  # Windows

def extract_text_from_coordinates(pdf_path, coordinates):
    # Open PDF file
    doc = fitz.open(pdf_path)
    extracted_texts = {}
    
    for label, (x0, y0, x1, y1) in coordinates.items():
        # Get the pixmap of the entire page (image)
        page = doc[0]  # Assume the first page for simplicity; adjust as needed
        pix = page.get_pixmap()
        
        # Convert the pixmap to an image object
        img = Image.open(io.BytesIO(pix.tobytes()))
        
        # Define the region of interest (ROI) as a box
        roi = img.crop((x0, y0, x1, y1))
        
        # Use Tesseract to do OCR on the ROI
        text = pytesseract.image_to_string(roi, lang='eng', config='--psm 6').strip()
        extracted_texts[label] = text
    
    return extracted_texts

# Coordinates for the areas to extract
coordinates = {
    "title": (62, 62, 780, 174),
    "notes": (62, 1488, 890, 1618),
    "information_block": (1488, 1498, 2327, 1627)
}

# Paths
pdf_path = r'pdf_files\236-020-STR-001_D.pdf'
output_text_path = r'extract_data\testing.txt'

# Extract text
extracted_text_regions = extract_text_from_coordinates(pdf_path, coordinates)

# Structuring, saving, and printing the extracted text
with open(output_text_path, 'w', encoding='utf-8', errors='replace') as file:
    for label, text in extracted_text_regions.items():
        # Print to console
        print(f"{label}:\n{text}\n")
        
        # Save to file
        file.write(f"{label}:\n{text}\n\n")

print(f"Extracted text saved to {output_text_path}")