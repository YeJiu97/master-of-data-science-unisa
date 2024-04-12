from pdf2image import convert_from_path
from PIL import Image
import pytesseract

# Specify the installation path of Tesseract for Windows users
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

# Path to your PDF document
pdf_path = r'pdf_files\236-020-WAS-120_1.pdf'

# Convert the PDF to images (all pages)
images = convert_from_path(pdf_path)

# Define coordinates for cropping specific regions
regions = {
    "TITLE": ((200, 175), (2200, 420)),
    "REV_TABLE": ((2504, 4160), (4133, 4520)),
    "DETAILS": ((4133, 4162), (4338, 4678)),
    "CUSTOMER": ((4338, 4162), (4890, 4518)),
    "Information": ((5480, 4162), (6464, 4519))
}

# Define NOTES section coordinates
notes_coords = (180, 4165, 2450, 4500)

# Function to extract text from given image regions
def extract_text(images, regions, config=''):
    extracted_texts = {}
    for label, ((x1, y1), (x2, y2)) in regions.items():
        for image in images:
            cropped_image = image.crop((x1, y1, x2, y2))
            text = pytesseract.image_to_string(cropped_image, config=config if label == 'Information' else '')
            if text.strip():
                extracted_texts[label] = text.strip()
                break  # Stop after finding text for a region
    return extracted_texts

# Extract text from specified regions on the first page
extracted_texts = extract_text(images[:1], regions)

# Print extracted text
for label, text in extracted_texts.items():
    print(f"Text from {label}:")
    print(text)
    print("-" * 50)

# Process NOTES sections from all pages
unique_notes = set()
for page_num, image in enumerate(images, start=1):
    notes_section = image.crop(notes_coords)
    notes_text = pytesseract.image_to_string(notes_section).strip()

    if notes_text and notes_text not in unique_notes:
        unique_notes.add(notes_text)
        print(f"Page {page_num} has unique NOTES:")
        print(notes_text)
        print("-" * 50)