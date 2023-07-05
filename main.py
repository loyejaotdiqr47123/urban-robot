from flask import Flask, request, make_response
import requests

app = Flask(__name__)

# 反代和替换功能
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def proxy(path):
    # 构建目标URL
    url = 'https://cdn.jsdelivr.net/' + path
    
    # 发送请求
    response = requests.get(url, stream=True)
    
    # 构建响应对象
    resp = make_response(response.content)
    
    # 替换响应内容中的域名
    resp.set_data(resp.get_data().replace(b'cdn.jsdelivr.net', b'jsdelivr.bobocdn.tk'))
    
    # 设置响应头
    for name, value in response.headers.items():
        resp.headers[name] = value
    
    return resp

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
