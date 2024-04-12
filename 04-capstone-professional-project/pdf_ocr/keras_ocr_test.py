import numpy as np
import keras_ocr
from pdf2image import convert_from_path
from PIL import Image

# 准备 keras_ocr 的 pipeline，这将自动下载预训练模型
pipeline = keras_ocr.pipeline.Pipeline()

# Path to your PDF document
pdf_path = 'pdf_files/236-020-STR-001_D.pdf'  # Update this to your actual PDF file path

# 定义各个特定区域的坐标
regions = {
    "TITLE": [(200, 175), (2200, 420)],
    "DETAILS": [(4133, 4162), (4338, 4678)],
    "CUSTOMER": [(4338, 4162), (4890, 4518)],
    "NOTES": [(180, 4165), (2450, 4500)],
    "INFORMATION": [(5480, 4162), (6464, 4519)]
}

# 函数检查box是否在指定区域内
def box_in_region(box, region):
    ((x1, y1), (x2, y2)) = region
    (box_x1, box_y1, box_x2, box_y2) = box
    return box_x1 >= x1 and box_y1 >= y1 and box_x2 <= x2 and box_y2 <= y2

# 提取特定区域的文本
def extract_text_by_region(ocr_result, region):
    texts = [text for text, box in ocr_result if box_in_region(box, region)]
    return " ".join(texts)

# 获取 PDF 的总页数
total_pages = len(convert_from_path(pdf_path))

# 存储提取的内容
extracted_content = {
    "TITLE": "",
    "DETAILS": "",
    "CUSTOMER": "",
    "INFORMATION": [],
    "NOTES": [],
    "REV_TABLE": []
}

# 逐页转换并处理 PDF
for page_number in range(1, total_pages + 1):
    # Convert single page from PDF to an image
    image = convert_from_path(pdf_path, first_page=page_number, last_page=page_number, poppler_path=r'C:\path\to\poppler\bin')[0]
    image_for_ocr = np.array(image)
    
    # Perform OCR on the current page
    ocr_result = pipeline.recognize([image_for_ocr])[0]

    # 特殊处理第一页的 TITLE, DETAILS, CUSTOMER
    if page_number == 1:
        for key in ["TITLE", "DETAILS", "CUSTOMER"]:
            region = regions[key]
            extracted_content[key] = extract_text_by_region(ocr_result, region)

    # 提取每一页的 INFORMATION
    extracted_content["INFORMATION"].append((page_number, extract_text_by_region(ocr_result, regions["INFORMATION"])))
    
    # 检查和提取 NOTES
    notes_text = extract_text_by_region(ocr_result, regions["NOTES"])
    if "NOTES" in notes_text or "IMPORTANT NOTE" in notes_text:
        extracted_content["NOTES"].append((page_number, notes_text))
    
    # 检查和提取 REV_TABLE，如果存在 "REV"
    rev_text = extract_text_by_region(ocr_result, regions["NOTES"])
    if "REV" in rev_text:
        extracted_content["REV_TABLE"].append((page_number, rev_text))

# 打印提取的内容
for key, value in extracted_content.items():
    print(f"{key}: {value}\n{'-'*100}")