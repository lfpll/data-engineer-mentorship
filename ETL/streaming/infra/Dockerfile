FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7

COPY ./queue_api.py /app/queue_api.py

RUN pip install kafka-python typing
CMD ["uvicorn", "queue_api:app", "--host", "0.0.0.0", "--port", "80"]
