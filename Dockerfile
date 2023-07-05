From ubuntu
Run apt update && apt install python3-pip -y
COPY main.py ./
EXPOSE 8000
CMD ["python", "main.py"]
