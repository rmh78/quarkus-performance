from flask import Flask
app = Flask(__name__)

import logging
log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

@app.route('/hello')
def hello_world():
    return 'Hello from Phyton'

if __name__ == '__main__':
    app.run(port=8080)