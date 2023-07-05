From ubuntu
USER root
Run apt update && apt install python-pip -y
RUN pip install flask flask_caching
COPY main.py ./
EXPOSE 8000
CMD ["python", "main.py"]
