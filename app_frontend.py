from flask import Flask, request, render_template, session, jsonify
from app import create_index, query_index

app = Flask(__name__)
app.secret_key = 'supersecretkey'  

try:
    index = create_index()
except Exception as e:
    print(f"Error creating index: {e}")
    index = None

@app.route('/')
def home():
    # Initializing a new chat history for a new session
    session['chat_history'] = []
    return render_template('chat.html', chat_history=session['chat_history'])

@app.route('/query', methods=['POST'])
def query():
    data = request.get_json()
    user_query = data['query']
    chat_history = session.get('chat_history', [])
    if index is None:
        response = "Error: Index not available."
    else:
        try:
            response = query_index(index, user_query, chat_history)
            chat_history.append({'user': user_query, 'bot': response})
            session['chat_history'] = chat_history
        except Exception as e:
            response = f"Error processing query: {e}"

    return jsonify({'response': response})

if __name__ == '__main__':
    app.run(debug=True)
