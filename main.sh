from flask import Flask, Response, request
from flask_caching import Cache
import requests

app = Flask(__name__)
cache = Cache(app, config={'CACHE_TYPE': 'simple'})


@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
@cache.cached(timeout=3600)
def proxy_jsdelivr(path):
  url = f"https://fastly.jsdelivr.net/{path}"
  headers = dict(request.headers)
  headers['Host'] = 'fastly.jsdelivr.net'  # 设置发送的域名为 cdn.jsdelivr.net
  response = requests.get(url, headers=headers, stream=True)
  headers = [(name, value) for name, value in response.raw.headers.items()]

  # 替换内容
  modified_content = response.content.replace(b'fastly.jsdelivr.net',
                                              b'jsdelivr.bobocdn.tk')

  return Response(modified_content, headers=headers)


@app.errorhandler(404)
def handle_404_error(e):
  return Response("404 Not Found", status=404)


@app.errorhandler(502)
def handle_502_error(e):
  return Response("502 Bad Gateway", status=502)


@app.errorhandler(403)
def handle_403_error(e):
  return Response("403 Forbidden", status=403)


if __name__ == '__main__':
  app.run(host='0.0.0.0', port=8000)
