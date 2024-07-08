import os
from langchain_community.document_loaders import TextLoader, DirectoryLoader
from langchain.indexes import VectorstoreIndexCreator
from langchain_community.llms import openai
from langchain.chains.question_answering import load_qa_chain
from langchain_openai import ChatOpenAI, OpenAIEmbeddings
from langchain.text_splitter import CharacterTextSplitter
from langchain_community.vectorstores.faiss import FAISS
from langchain.schema import Document


# OpenAI API key
os.environ["OPENAI_API_KEY"] = "sk-proj-8gosgQLsvWUoF6g4iPgnT3BlbkFJZHxOCpHPNV6S1DxfvEZ7"

def create_index():
    loader = DirectoryLoader(r"C:\Users\joyleo\sample_openai\docs\cloud\azure\sef", 
    glob="**/*.md",
    loader_cls=TextLoader)
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

def query_index(index, query, chat_history):
    # Get the embeddings for the query
    embeddings = OpenAIEmbeddings()
    query_embedding = embeddings.embed_query(query)
    
    # Quering the FAISS index
    results = index.similarity_search(query)
    
    # Using the retrieved documents to generate an answer
    chain = load_qa_chain(ChatOpenAI(model="ft:gpt-3.5-turbo-0125:personal::9bmeZOoz"))
    answer = chain.invoke({"input_documents": results, "question": query, "chat_history": chat_history})
    
    # Extract the output text
    output_text = answer['output_text']
    return output_text

if __name__ == "__main__":
    faiss_index = create_index()
    query = "What is Azure?"
    chat_history = []
    answer = query_index(faiss_index, query, chat_history)
    print(answer)
