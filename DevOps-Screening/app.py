from flask import Flask, jsonify 
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST 
import socket

app = Flask(__name__) 
REQUESTS = Counter("app_requests_total", "Total requests")

@app.route("/") 
def home(): 
    REQUESTS.inc() 
    return jsonify(message="Hello", host=socket.gethostname())

@app.route("/health") 
def health(): 
    return jsonify(status="ok")


@app.route("/metrics") 
def metrics(): 
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}