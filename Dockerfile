FROM python
RUN pip install flask flask_caching
COPY main.py ./
EXPOSE 8000
CMD ["python", "main.py"]
