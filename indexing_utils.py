import os
import logging
import ssl
from langchain_community.document_loaders import DirectoryLoader, TextLoader
from langchain.indexes import VectorstoreIndexCreator
from langchain_community.embeddings import OpenAIEmbeddings
from langchain.text_splitter import CharacterTextSplitter
from langchain_community.vectorstores import FAISS
from langchain.schema import Document
from langchain.chains.question_answering import load_qa_chain
from langchain_community.llms import OpenAI
import openai
import httpx
from langchain.prompts import ChatPromptTemplate, ChatTemplate, HumanMessage

logging.basicConfig(level=logging.DEBUG)

class UTF8TextLoader(TextLoader):
    def lazy_load(self):
        try:
            with open(self.file_path, "r", encoding="utf-8") as f:
                text = f.read()
        except UnicodeDecodeError as e:
            raise RuntimeError(f"Error loading {self.file_path}") from e
        return [Document(page_content=text)]

def create_index(directory_path):
    logging.info(f"Loading documents from {directory_path}")
    loader = DirectoryLoader(directory_path, glob="**/*.md", loader_cls=UTF8TextLoader)
    data = loader.load()
    logging.info(f"Loaded {len(data)} documents")

    # Splitting text into smaller chunks
    splitter = CharacterTextSplitter(
        separator=" ", 
        chunk_size=1000,  
        chunk_overlap=0, 
        keep_separator=False
    )

    split_docs = []
    for doc in data:
        split_docs.extend(splitter.split_text(doc.page_content))
    logging.info(f"Split documents into {len(split_docs)} chunks")

    # Creating embeddings for the split documents
    embeddings = OpenAIEmbeddings()
    embedded_docs = [Document(page_content=text) for text in split_docs]

    # Disable SSL verification
    ssl_context = ssl.create_default_context()
    ssl_context.check_hostname = False
    ssl_context.verify_mode = ssl.CERT_NONE
    client = httpx.Client(verify=False)
    openai._default_http_client = client

    embedded_texts = [embeddings.embed_documents([doc.page_content])[0] for doc in embedded_docs]
    
    if not embedded_texts:
        raise ValueError("No embeddings generated for the documents")

    # Creating FAISS index
    faiss_index = FAISS.from_documents(embedded_docs, embeddings)
    logging.info("FAISS index created successfully")
    
    return faiss_index

def query_index(index, query, chat_history):
    # Querying the FAISS index
    results = index.similarity_search(query)
    logging.info(f"Found {len(results)} relevant documents")

    # Prepare the documents content to provide as context
    context = " ".join([doc.page_content for doc in results])
    
    # Create a prompt for the language model
    prompt_template = ChatPromptTemplate.from_messages([
        HumanMessage(content=f"The following is a query: {query}"),
        HumanMessage(content=f"Here is some context to help you answer the query: {context}"),
        HumanMessage(content="Please provide a detailed and formatted response based on the context."),
    ])
    
    prompt = ChatTemplate.from_template(prompt_template)
    
    # Using the OpenAI model to generate an answer
    response = OpenAI(model="ft:gpt-3.5-turbo-0125:personal::9bmeZOoz").invoke(prompt)
    
    # Extract the output text
    output_text = response['choices'][0]['message']['content']
    
    # Format the output as bullet points
    formatted_output = format_as_bullet_points(output_text)
    
    return formatted_output

def format_as_bullet_points(text):
    # Splitting the text into lines and create bullet points
    lines = text.strip().split('\n')
    bullet_points = "\n".join([f"- {line}" for line in lines if line.strip()])
    return bullet_points
