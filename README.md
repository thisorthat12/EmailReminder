## A project to send email reminders based on when something was bought and when it expires. It consists of a Flutter desktop application, an AWS Step Function and an AWS Lambda Python function.

The application consists of a home page displaying previously entered items and an input form page where reminders can be created. Whenever a reminder is created, an AWS Step Function is launched. It waits for the expiry time and triggers an AWS Lamda that will send an email reminder. Reminders are sent 1 week before expiry and on the expiry date. Should the expiry date fall within one week of the purchase time, only one email at expiry time will be sent.

![Home Page](https://github.com/thisorthat12/EmailReminder/assets/133687751/30029f2b-5950-4f7b-a34b-1432667f0b06)
![Adding a reminder](https://github.com/thisorthat12/EmailReminder/assets/133687751/720fa129-7561-4ace-8743-bedffb76bf6a)

## Testing

Postman requests are included to test the Step Function API. Fill in the "x-api-key", "sender", "recipient", "stateMachineArn" and "stepFunctionAPIurl" fields with the values from the [AWS part](#aws-part). For the "sendTime" field, you can choose when you'd like the email to be sent. Subject and body can be whatever you like. For the "name", you should use a unique value each time you make a request. 

To run the flutter application tests with coverage, run the following command in the email_reminder folder: "flutter test --coverage".
The current test coverage is 91.8%. You can visualise it by running: "genhtml coverage/lcov.info -o coverage/html". You may have to install lcov in order to make it work.
This will create a coverage folder in the email_reminder folder. You can open the index.html file situated in the coverage/html folder in a browser to view the coverage of the different classes. At the time of writing, the visualisation looked like the following.

![Application test coverage](https://github.com/thisorthat12/EmailReminder/assets/133687751/5bab9028-d936-464e-926f-8e3a9d616a2b)

## Technically

The Isar database is used to store the items locally in the Flutter application.

## How to reproduce this project

### AWS part
You will need an AWS account in order to create the Lambda, Step Function and API Gateway. To create the Step Function API please follow this [tutorial](https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-api-gateway.html). I also recommend you create an api key and an associated usage plan. That wills secure your api and make sure you don't incur any unexpected costs. 

You should also [create](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#verify-email-addresses-procedure) and [verify](https://docs.aws.amazon.com/ses/latest/dg/creating-identities.html#just-verify-email-proc) the sender and recipient email identities you intend to use in AWS SES. 

Please note down your sender email address, recipient email address, Step Function ARN, API url and API key. You will need these later on.

Clone the repository to the directory of your choice. To run the application from the command line, navigate to the email_reminder folder within the repository and run: "flutter run lib/main.dart". Choose your desktop OS should the choice present itself. The application should show up auickly. On the upper right of the window, press the settings icon and fill in the fields with what you wrote down.

You are good to go now!

## Further improvements
Make it possible to set sender and recipient emails.

## Useful resources

API key for API Gateway
https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-setup-api-key-with-console.html
https://stackoverflow.com/questions/39061041/using-an-api-key-in-amazon-api-gateway

Step Function API
https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-api-gateway.html

Isar Database
https://isar.dev/tutorials/quickstart.html

Flutter Desktop Codelab
https://codelabs.developers.google.com/codelabs/flutter-codelab-first#0
