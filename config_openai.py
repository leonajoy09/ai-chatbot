
import os
import openai
import certifi
import logging

# Configure logging
logging.basicConfig(level=logging.DEBUG)

# Ensure SSL certificate verification uses the path to cacert.pem file
os.environ['CURL_CA_BUNDLE'] = (r"C:\Users\joyleo\Downloads\cacert-2024-07-02.pem")

# Set your OpenAI API key here
openai.api_key = "sk-proj-8gosgQLsvWUoF6g4iPgnT3BlbkFJZHxOCpHPNV6S1DxfvEZ7"
if not openai.api_key:
    raise ValueError("OpenAI API key is not set. Please set the OPENAI_API_KEY environment variable.")
