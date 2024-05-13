from pdf2image import convert_from_path
from PIL import Image
import pytesseract

# Specify the installation path of Tesseract for Windows users
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'
poppler_path = r"C:\poppler-24.02.0\Library\bin"

# Path to your PDF document
pdf_path = r'pdf_files\236-020-STR-001_D.pdf' # Update this to your actual PDF file path  # Update this to your actual PDF file path

# Convert the PDF to images (all pages)
images = convert_from_path(pdf_path)

# Function to check if a region contains any of the specified keywords
def contains_keywords(image, coords, keywords):
    cropped_image = image.crop(coords)
    text = pytesseract.image_to_string(cropped_image)
    return any(keyword in text for keyword in keywords)

# Extract text from TITLE, DETAILS, and CUSTOMER on the first page
regions = {
    "TITLE": (200, 175, 2200, 420),
    "DETAILS": (4133, 4162, 4338, 4678),
    "CUSTOMER": (4338, 4162, 4890, 4518)
}
first_page_texts = {key: pytesseract.image_to_string(images[0].crop(value)) for key, value in regions.items()}

# Check and extract REV_TABLE if "REV" is present, indicate page number
rev_table_coords = (2504, 4160, 4133, 4520)
rev_texts = [(page_num+1, pytesseract.image_to_string(image.crop(rev_table_coords))) for page_num, image in enumerate(images) if contains_keywords(image, rev_table_coords, ['REV'])]

# Process NOTES sections from all pages without uniqueness check
notes_coords = (180, 4165, 2450, 4500)
notes_texts = [(page_num+1, pytesseract.image_to_string(image.crop(notes_coords)).strip()) for page_num, image in enumerate(images)]

# Extract INFORMATION from every page and indicate page number
information_coords = (5480, 4162, 6464, 4519)
information_texts = [(page_num+1, pytesseract.image_to_string(image.crop(information_coords)).strip()) for page_num, image in enumerate(images)]

# # Output extracted texts
# for label, text in first_page_texts.items():
#     print(f"{label}:\n{text}\n{'-'*50}")

# print("REV_TABLES:")
# for page_num, text in rev_texts:
#     print(f"Page {page_num}:\n{text}\n{'-'*50}")

# print("NOTES:")
# for page_num, note in notes_texts:
#     print(f"Page {page_num}:\n{note}\n{'-'*50}")

# print("INFORMATION:")
# for page_num, info in information_texts:
#     print(f"Page {page_num}:\n{info}\n{'-'*50}")


# Create a dictionary to store all extracted content
extracted_content = {
     "TITLE": first_page_texts.get("TITLE", ""),
     "DETAILS": first_page_texts.get("DETAILS", ""),
     "CUSTOMER": first_page_texts.get("CUSTOMER", ""),
     "REV_TABLES": rev_texts,
     "NOTES": notes_texts,
     "INFORMATION": information_texts
}

# Output all contents stored in the dictionary
print("Extracted Content Summary:")
for key, value in extracted_content.items():
     print(f"{key}:")
     if isinstance(value, list):
         # If the value is a list (such as REV_TABLES, NOTES, INFORMATION), print each item in the list separately
         for item in value:
             if isinstance(item, tuple):
                 # If the items in the list are tuples (page number, text), print them separately
                 print(f"Page {item[0]}:")
                 print(item[1]) #Print the entire text content
                 print("-" * 50) # separator line
             else:
                 print(item) # Print the item directly
                 print("-" * 50) # separator line
     else:
         # If the value is not a list (such as TITLE, DETAILS, CUSTOMER), print directly
         print(value)
         print("-" * 50) # separator line