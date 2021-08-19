from fastapi import FastAPI,Request
import os
import logging 
import json
from kafka import KafkaProducer
from typing import List

app = FastAPI()
logging.error(os.environ['KAFKA_HOST'])

producer = KafkaProducer(bootstrap_servers=os.environ['KAFKA_HOST'].split(','))

TOPIC = os.environ['KAFKA_TOPIC']

if isinstance(TOPIC,bytes):
    TOPIC = TOPIC.decode('utf-8') 


@app.post('/')
async def insert_data(request: Request):
    
    resp = await request.json()
    i = 0
    for e in resp:
        i += 1
        producer.send(topic=TOPIC,
                      value=bytes(json.dumps(e),encoding='utf-8'))
    producer.flush()
    
    return {"success":"true","num_events":i}
