from fastapi.testclient import TestClient
import kafka
import os
from pytest import MonkeyPatch
from unittest import mock


def test_insert_data(monkeypatch):
    producer = mock.MagicMock(kafka.KafkaProducer)
    os.environ['KAFKA_TOPIC'] = 'TEST'
    monkeypatch.setattr(kafka,'KafkaProducer',producer)
    
    from ETL.streaming.queue_api import app
    client = TestClient(app)
    response = client.post("/",json=[{"data":"test"},{"data":"test"}])

    assert response.status_code == 200
    assert response.json() == {"success": "true","num_events":2}