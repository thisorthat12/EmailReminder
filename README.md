A project to send email reminders. It consists of a Flutter desktop application, an AWS Step Function and an AWS Lambda Python function.

The application consists of a home page displaying previously entered items and an input form page where reminders can be created. 

![image info](images/home.png) ![image info](images/addition.png)

API key
https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-setup-api-key-with-console.html
https://stackoverflow.com/questions/39061041/using-an-api-key-in-amazon-api-gateway

{
   "input": "{\"sendTime\": \"2024-04-28T17:34:00+02:00\",\"queryStringParameters\": {\"subject\": \"subjectin\",\"body\": \"nobody\",\"sender\": \"s331zg8id@mozmail.com\",\"recipient\": \"srlvvlw39@mozmail.com\"}}",
   "name": "MyExecution8",
   "stateMachineArn": "arn:aws:states:eu-north-1:222103012619:stateMachine:MyStateMachine-iq91z8dq4"
}

Step Function API
https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-api-gateway.html