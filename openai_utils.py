import json
import logging
import httpx
from tenacity import retry, stop_after_attempt, wait_exponential
from client import client
from config_openai import openai

@retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1, min=4, max=10))
def post_to_openai(doc):
    response = client.post(
        "https://api.openai.com/v1/chat/completions",
        headers={"Authorization": f"Bearer {openai.api_key}"},
        json={
            "model": "gpt-3.5-turbo",
            "messages": [
                {"role": "system", "content": "You are a helpful assistant."},
                {"role": "user", "content": f"Extract questions and answers from the following document:\n\n{doc}"}
            ],
            "max_tokens": 1500
        }
    )
    response.raise_for_status()
    return response

# Function to generate Q&A pairs using OpenAI's API
def generate_qa_pairs(documents):
    qa_pairs = []
    for doc in documents:
        try:
            logging.debug(f"Processing document: {doc[:100]}...")
            response = post_to_openai(doc)
            qa_pairs.extend(response.json()['choices'][0]['message']['content'].strip().split('\n'))
        except httpx.ReadTimeout:
            logging.error(f"Timeout occurred while processing the document: {doc[:100]}... Skipping this document.")
        except httpx.HTTPStatusError as e:
            logging.error(f"HTTP error occurred: {e.response.status_code} - {e.response.text}")
        except httpx.RequestError as e:
            logging.error(f"Request error occurred: {e}")
        except Exception as e:
            logging.error(f"An unexpected error occurred: {e}")
    return qa_pairs

# Function to format Q&A pairs for fine-tuning
def format_qa_pairs_for_finetuning(qa_pairs):
    formatted_data = []
    current_question = None
    for line in qa_pairs:
        line = line.strip()
        if line.startswith("Q:"):
            current_question = line[2:].strip()
        elif line.startswith("A:") and current_question:
            answer = line[2:].strip()
            formatted_data.append({
                "messages": [
                    {"role": "system", "content": "Marv is a factual chatbot that is also sarcastic."},
                    {"role": "user", "content": current_question},
                    {"role": "assistant", "content": answer}
                ]
            })
            current_question = None
    return formatted_data

# Function to save formatted data to a JSONL file, appending to existing data
def save_to_jsonl(data, file_path):
    with open(file_path, 'a', encoding='utf-8') as file:
        for entry in data:
            json.dump(entry, file)
            file.write('\n')
