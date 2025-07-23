import json
import pickle
import numpy as np

model = pickle.load(open("model.pkl", "rb"))

def lambda_handler(event, context):
    try:
        if "queryStringParameters" in event and event["queryStringParameters"]:
            x = float(event["queryStringParameters"].get("x", 0))
        elif "body" in event and event["body"]:
            body_data = json.loads(event["body"])
            x = float(body_data.get("x", 0))
        elif "x" in event:
            x = float(event["x"])
        else:
            x = 0
    except (ValueError, TypeError, json.JSONDecodeError):
        x = 0

    pred = model.predict(np.array([[x]]))[0]
    return {
        "statusCode": 200,
        "body": json.dumps({ "prediction": int(pred) })
    }