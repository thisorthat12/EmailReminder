import boto3
import json

def send_email(event, context):
    subject = event["queryStringParameters"]['subject']
    body = event["queryStringParameters"]['body']
    sender = event["queryStringParameters"]['sender']
    recipient = event["queryStringParameters"]['recipient']
    client = boto3.client('ses', region_name='eu-north-1')
    response = client.send_email(
        Source=sender,
        Destination={
            'ToAddresses': [recipient]
        },
        Message={
            'Subject': {
                'Data': subject
            },
            'Body': {
                'Text': {
                    'Data': body
                }
            }
        }
    )
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({
            'response': response['MessageId']
        }),
        "isBase64Encoded": False
    }