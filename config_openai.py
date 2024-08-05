
import os
import openai
import certifi
import logging
from openai import OpenAI

# Configure logging
logging.basicConfig(level=logging.DEBUG)

# Ensure SSL certificate verification uses the path to cacert.pem file
os.environ['CURL_CA_BUNDLE'] = (r"C:\Users\joyleo\Downloads\cacert-2024-07-02.pem")

# Set your OpenAI API key here
client = OpenAI()
if not openai.api_key:
    raise ValueError("OpenAI API key is not set. Please set the OPENAI_API_KEY environment variable.")