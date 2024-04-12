from pdf2image import convert_from_path
import easyocr
import numpy as np

# 初始化 easyOCR 读取器
reader = easyocr.Reader(['en'])

def extract_text_from_pdf(pdf_path):
    images = convert_from_path(pdf_path)
    # 初始化存储结构
    first_page_texts = {}
    rev_texts = []
    notes_texts = []
    information_texts = []

    for i, image in enumerate(images):
        image_np = np.array(image)

        if i == 0:  # 仅从第一页提取
            # 提取 TITLE 区域文本
            title_region = image_np[175:420, 200:2200]
            title_text = ' '.join(reader.readtext(title_region, detail=0, paragraph=True))
            first_page_texts['TITLE'] = title_text

            # 提取 DETAILS 区域文本
            details_region = image_np[4162:4678, 4133:4338]
            details_text = ' '.join(reader.readtext(details_region, detail=0, paragraph=True))
            first_page_texts['DETAILS'] = details_text

            # 提取 CUSTOMER 区域文本
            customer_region = image_np[4162:4518, 4338:4890]
            customer_text = ' '.join(reader.readtext(customer_region, detail=0, paragraph=True))
            first_page_texts['CUSTOMER'] = customer_text

        # 检查 REV_TABLE 是否存在
        rev_text = reader.readtext(image_np, detail=0)
        if any('REV' in word for word in rev_text):
            rev_texts.append((i + 1, ' '.join(rev_text)))

        # 提取 NOTES 区域文本
        notes_region = image_np[4165:4500, 180:2450]
        notes_text = ' '.join(reader.readtext(notes_region, detail=0, paragraph=True))
        if notes_text:
            notes_texts.append((i + 1, notes_text))

        # 提取 INFORMATION 区域文本
        information_region = image_np[4162:4519, 5480:6464]
        information_text = ' '.join(reader.readtext(information_region, detail=0, paragraph=True))
        information_texts.append((i + 1, information_text))

    # 创建字典以存储所有提取的内容
    extracted_content = {
        "TITLE": first_page_texts.get("TITLE", ""),
        "DETAILS": first_page_texts.get("DETAILS", ""),
        "CUSTOMER": first_page_texts.get("CUSTOMER", ""),
        "REV_TABLES": rev_texts,
        "NOTES": notes_texts,
        "INFORMATION": information_texts
    }

    return extracted_content

# 这是一个示例PDF路径，您需要根据实际情况更改它
pdf_path = 'pdf_files/236-020-STR-001_D.pdf' 
extracted_content = extract_text_from_pdf(pdf_path)

# 输出所有存储在字典中的内容
print("Extracted Content Summary:")
for key, value in extracted_content.items():
    print(f"{key}:")
    if isinstance(value, list):
        for item in value:
            print(f"Page {item[0]}:")
            print(item[1])  # Print the entire text content
            print("-" * 50)  # Separator line
    else:
        print(value)
        print("-" * 50)  # Separator line