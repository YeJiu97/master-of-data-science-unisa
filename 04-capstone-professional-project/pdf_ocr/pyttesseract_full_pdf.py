import fitz  # PyMuPDF
from PIL import Image
import pytesseract
import io

#Specify the installation path of Tesseract and modify it according to your actual installation location
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'  # Windows
# pytesseract.pytesseract.tesseract_cmd = '/usr/bin/tesseract'  # Linux

def pdf_to_text(pdf_path):
    #Open PDF file
    doc = fitz.open(pdf_path)
    text = ''
    
    for page_num in range(len(doc)):
        # Get the image list of a single page
        page = doc.load_page(page_num)
        pix = page.get_pixmap()
        img = Image.open(io.BytesIO(pix.tobytes()))

        # Use OCR to extract text from images
        page_text = pytesseract.image_to_string(img, lang='eng', config='--psm 6')
        text += page_text + '\n'
    
    return text

pdf_path = r'pdf_files\236-020-STR-001_D.pdf'  # Please modify the path according to the actual situation
extracted_text = pdf_to_text(pdf_path)
print(extracted_text)