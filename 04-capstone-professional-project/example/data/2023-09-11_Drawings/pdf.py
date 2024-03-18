import fitz #PyMuPDF

def extract_text_from_pdf(pdf_file_path):
     # Open the PDF file
     pdf_document = fitz.open(pdf_file_path)

     text = ""

     # Iterate through each page in the PDF
     for page_num in range(len(pdf_document)):
         page = pdf_document.load_page(page_num)
         text += page.get_text()

     # Close the PDF document
     pdf_document.close()

     return text

if __name__ == "__main__":
     # PDF file path
     pdf_file_path = "236-020-SAS-120_0.pdf"

     #Extract text content from PDF files
     extracted_text = extract_text_from_pdf(pdf_file_path)

     #Print the extracted text content
     print(extracted_text)