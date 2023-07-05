import requests
from flask import Flask, request, Response

app = Flask(__name__)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def proxy(path):
    url = f'https://cdn.jsdelivr.net/{path}'
    headers = {key: value for (key, value) in request.headers if key != 'Host'}
    response = requests.request(
        method=request.method,
        url=url,
        headers=headers,
        data=request.get_data(),
        cookies=request.cookies,
        allow_redirects=False
    )
    resp = Response(response.content, status=response.status_code, headers=dict(response.headers))
    resp.headers['Access-Control-Allow-Origin'] = '*'
    resp.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    resp.headers['Access-Control-Allow-Headers'] = 'Content-Type'
    resp.headers['Content-Type'] = response.headers['Content-Type'].replace('cdn.jsdelivr.net', 'jsdelivr.bobocdn.tk')
    return resp

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
