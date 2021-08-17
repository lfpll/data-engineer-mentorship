from kafka import KafkaProducer
from pytest import MonkeyPatch
from unittest import mock

def mock_producer(monkeypatch: MonkeyPatch):
    producer = mock.MagicMock(KafkaProducer)
    monkeypatch.setattr(KafkaProducer,'__init__.py',producer)


    