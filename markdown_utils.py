import os
import markdown
from bs4 import BeautifulSoup

# Function to read markdown file
def read_markdown_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        text = file.read()
    return text

# Function to convert markdown content to plain text
def markdown_to_text(markdown_content):
    html = markdown.markdown(markdown_content)
    soup = BeautifulSoup(html, features="html.parser")
    return soup.get_text()

# Function to extract content from a directory of markdown files
def extract_content_from_directory(directory):
    documents = []
    for filename in os.listdir(directory):
        if filename.endswith('.md'):
            file_path = os.path.join(directory, filename)
            markdown_content = read_markdown_file(file_path)
            text_content = markdown_to_text(markdown_content)
            documents.append(text_content)
    return documents
