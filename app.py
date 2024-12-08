from flask import Flask
from waitress import serve

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!   Welcome to INSAT Promotion 2025'

if __name__ == '__main__':
    serve(app, host='0.0.0.0', port=5000)
