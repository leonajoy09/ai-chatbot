import os
import logging
from langchain_community.document_loaders import TextLoader, DirectoryLoader
from langchain.indexes import VectorstoreIndexCreator
from langchain_community.llms import openai
from langchain.chains.question_answering import load_qa_chain
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain.text_splitter import CharacterTextSplitter
from langchain_community.vectorstores.faiss import FAISS
from langchain.schema import Document
from openai import OpenAI

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# OpenAI API key from environment variable
api_key = os.getenv("OPENAI_API_KEY")
if not api_key:
    raise ValueError("OpenAI API key not found in environment variables")
client = OpenAI(api_key=api_key)

def create_index():
    try:
        logger.info("Starting to create index...")
        # Using relative path for the project directory
        base_path = os.path.dirname(__file__)
        docs_path = os.path.join(base_path, 'docs', 'cloud', 'azure')
        logger.info(f"Docs path: {docs_path}")
        if not os.path.exists(docs_path):
            raise FileNotFoundError(f"Directory not found: {docs_path}")
        loader = DirectoryLoader(docs_path, glob="**/*.md", loader_cls=TextLoader)
        data = loader.load()

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

        # Creating embeddings for the split documents
        embeddings = OpenAIEmbeddings()
        embedded_docs = [Document(page_content=text) for text in split_docs]

        # Creating FAISS index
        faiss_index = FAISS.from_documents(embedded_docs, embeddings)
        return faiss_index
    except Exception as e:
        logger.error(f"Error creating index: {e}")
        raise

def query_index(index, query, chat_history):
    try:
        # Get the embeddings for the query
        embeddings = OpenAIEmbeddings()
        query_embedding = embeddings.embed_query(query)

        # Quering the FAISS index
        results = index.similarity_search(query)

        # Using the retrieved documents to generate an answer
        chain = load_qa_chain(ChatOpenAI(model="ft:gpt-3.5-turbo-0125:personal::9oqzemdr"))
        answer = chain.invoke({"input_documents": results, "question": query, "chat_history": chat_history})

        # Extract the output text
        output_text = answer['output_text']
        return output_text
    except Exception as e:
        logger.error(f"Error processing query: {e}")
        return f"Error processing query: {e}"

if __name__ == "__main__":
    try:
        faiss_index = create_index()
        query = "What is Azure?"
        chat_history = []
        answer = query_index(faiss_index, query, chat_history)
        print(answer)
    except Exception as e:
        logger.error(f"Error running main: {e}")
