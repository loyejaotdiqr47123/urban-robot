FROM ubuntu
USER root
RUN apt update && apt install python-pip -y
RUN pip install flask flask_caching
COPY main.py ./
EXPOSE 8000
CMD ["python", "main.py"]
