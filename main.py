import logging
from markdown_utils import extract_content_from_directory
from openai_utils import generate_qa_pairs, format_qa_pairs_for_finetuning, save_to_jsonl
from indexing_utils import create_index, query_index

if __name__ == "__main__":
    # To define the path to the directory containing markdown files
    directory_path = r"C:\Users\joyleo\sample_openai_copy\docs\cloud\azure\sef"
    
    # To extract content from markdown files
    documents = extract_content_from_directory(directory_path)
    
    # To Generate Q&A pairs from the extracted content
    qa_pairs = generate_qa_pairs(documents)
    
    # To format the Q&A pairs for fine-tuning
    formatted_data = format_qa_pairs_for_finetuning(qa_pairs)
    
    # Save the formatted data to a JSONL file, appending to existing data
    save_to_jsonl(formatted_data, 'finetuning_data.jsonl')

    # To create FAISS index
    faiss_index = create_index(directory_path)
    
    # Example query
    query = "What is Azure?"
    answer = query_index(faiss_index, query)
    
    # To print the formatted answer
    print(answer)