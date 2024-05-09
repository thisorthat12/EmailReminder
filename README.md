A project to send email reminders based on when something was bought and when it expires. It consists of a Flutter desktop application, an AWS Step Function and an AWS Lambda Python function.

The application consists of a home page displaying previously entered items and an input form page where reminders can be created. Whenever a reminder is created, an AWS Step Function is launched. It waits for the expiry time and triggers an AWS Lamda that will send an email reminder. Reminders are sent 1 week before expiry and on the expiry date.

Postman requests are included to test the Step Function API.

![alt text](images/home.png) ![alt text](images/addition.png)

Technically

The Isar database is used to store the items locally in the Flutter application.

Further improvements
Make it possible to set sender and recipient emails.


Useful resources

API key for API Gateway
https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-setup-api-key-with-console.html
https://stackoverflow.com/questions/39061041/using-an-api-key-in-amazon-api-gateway

Step Function API
https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-api-gateway.html

Isar Database
https://isar.dev/tutorials/quickstart.html

Flutter Desktop Codelab
https://codelabs.developers.google.com/codelabs/flutter-codelab-first#0