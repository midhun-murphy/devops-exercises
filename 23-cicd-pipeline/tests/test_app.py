import os
import sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from app import app

client = app.test_client()
from app import app

client = app.test_client()


def test_home():
    response = client.get("/")
    assert response.status_code == 200


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json()["status"] == "UP"


def test_add():
    response = client.post("/", data={
        "num1": 10,
        "num2": 20,
        "operation": "add"
    })

    assert response.status_code == 200
    assert b"30" in response.data


def test_subtract():
    response = client.post("/", data={
        "num1": 20,
        "num2": 5,
        "operation": "subtract"
    })

    assert response.status_code == 200
    assert b"15" in response.data


def test_multiply():
    response = client.post("/", data={
        "num1": 5,
        "num2": 8,
        "operation": "multiply"
    })

    assert response.status_code == 200
    assert b"40" in response.data


def test_divide():
    response = client.post("/", data={
        "num1": 30,
        "num2": 5,
        "operation": "divide"
    })

    assert response.status_code == 200
    assert b"6" in response.data


def test_divide_by_zero():
    response = client.post("/", data={
        "num1": 30,
        "num2": 0,
        "operation": "divide"
    })

    assert response.status_code == 200
    assert b"Division by zero is not allowed" in response.data