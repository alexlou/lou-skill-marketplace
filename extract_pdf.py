import sys
from pdfminer.high_level import extract_pages
from pdfminer.layout import LTTextContainer

def extract_text_from_pdf(pdf_path, start_page, end_page):
    try:
        pages = list(extract_pages(pdf_path))
        for i in range(start_page - 1, min(end_page, len(pages))):
            print(f"--- Page {i+1} ---")
            for element in pages[i]:
                if isinstance(element, LTTextContainer):
                    print(element.get_text())
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python3 extract_pdf.py <pdf_path> <start_page> <end_page>")
    else:
        extract_text_from_pdf(sys.argv[1], int(sys.argv[2]), int(sys.argv[3]))
