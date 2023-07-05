FROM ubuntu:latest

# 安装系统依赖
RUN apt-get update \
    && apt-get install -y python3 python3-pip

# 安装 Flask 和 Flask-Caching
RUN pip3 install flask flask-caching

# 设置工作目录
WORKDIR /app

# 将项目文件复制到容器中
COPY . /app

# 暴露端口
EXPOSE 8000

# 启动应用程序
CMD ["python3", "main.py"]
