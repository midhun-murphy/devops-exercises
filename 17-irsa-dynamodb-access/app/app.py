import boto3
import time

table_name = "irsa-demo-table"

dynamodb = boto3.resource("dynamodb", region_name="ap-south-1")
table = dynamodb.Table(table_name)

print("=== PutItem ===")

table.put_item(
    Item={
        "id": "1001",
        "name": "Midhun",
        "course": "DevOps"
    }
)

print("Item inserted")

print("=== GetItem ===")

response = table.get_item(
    Key={
        "id": "1001"
    }
)

print(response.get("Item"))

print("=== UpdateItem ===")

table.update_item(
    Key={
        "id": "1001"
    },
    UpdateExpression="SET course = :c",
    ExpressionAttributeValues={
        ":c": "AWS DevOps"
    }
)

print("Item updated")

while True:
    time.sleep(60)