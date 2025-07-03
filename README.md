<h4> Step 0: Create a Role in AWS for AWS STS Stale Window test: </h4>

0.1

![image](https://github.com/user-attachments/assets/374ba45c-5ead-48d1-bc80-5e16fd319873)
0.2
![image](https://github.com/user-attachments/assets/e2c066df-d131-497d-bbe3-c08b2946b049)
0.3
![image](https://github.com/user-attachments/assets/04ac76dd-dc9d-4cf6-a4f1-699659a4d1bd)
0.4
![image](https://github.com/user-attachments/assets/7f3b9e39-49b9-4064-81d3-13a1758b717a)

<h4>Step 1: Create a policy for Users to Assume Roles</h4>

![image](https://github.com/user-attachments/assets/a8b4799a-fbd0-47f4-b6f0-df284192884a)
![image](https://github.com/user-attachments/assets/5f03f540-6168-407a-b507-e945783fd078)

<h4> Step 2: Create a User in AWS for this lab:</h4>

![image](https://github.com/user-attachments/assets/734ca8e7-0870-4367-b033-062ac1ff5bda)


<h4>Step 3: Attach permissions to StaleWindowTester</h4>

![image](https://github.com/user-attachments/assets/58a7a11c-aa08-4ea3-bbf6-ec30b1a704fd)



<P>in AWS, To “assume a role” means:</P>
<P>A user or service requests temporary credentials (via sts:AssumeRole) to “become” that role for a short period of time.</P>
So the user takes on the permissions of the role — but only temporarily (typically 15 minutes to a few hours).


<h4>Step 4: Generate access keys for StaleWindowTester</h4>

<ul>
  <li>Go to IAM → Users → StaleWindowTester</li>

<li>Select Security credentials tab</li>

<li>Under Access keys, click Create access key</li>

<li>Download the CSV or copy the credentials</li>


</ul>

![image](https://github.com/user-attachments/assets/ad75ec5c-f4bf-4e90-93fc-996b585cc425)


<h4>Step 5: Configure CLI with StaleWindowTester</h4>
on my terminal:
<code>aws configure --profile staleuser
</code>
Then enter for prompt:

Access key ID: (from the CSV) AKIAYNKSYTAO4UF7NTNJ


Secret access key: (from the CSV)cU41JmBxBMssLWyFeYkub+uPair4l2dK0mxlCwfz


Region: us-east-1

Output format: json

Encounter an error here:
![image](https://github.com/user-attachments/assets/10431259-3dd5-407c-8064-016b0faaa9c2)

This role's policy is not updated to trust the user:
![image](https://github.com/user-attachments/assets/008038b9-63f5-454e-9ed2-1a5bdf42544d)



<h4>Step 6: Use sts:AssumeRole</h4>
run:
<code>aws sts assume-role \
  --role-arn arn:aws:iam::578383550493:role/StaleWindowRole \
  --role-session-name test-session \
  --profile staleuser
</code>

success, and get our temporary STS credential set:

![image](https://github.com/user-attachments/assets/a9084ab8-ddff-4d11-872f-abf6a2a768d3)

<code>Last login: Sun Jun 29 22:13:10 on console
(base) ~ % aws configure --profile staleuser

AWS Access Key ID [None]: AKIAYNKSYTAO4UF7NTNJ
AWS Secret Access Key [None]: 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
Default region name [None]: us-east-1
Default output format [None]: json
(base) ~ % aws configure --profile staleuser

AWS Access Key ID [****************NTNJ]: AKIAYNKSYTAO4UF7NTNJ
AWS Secret Access Key [****************Cwfz]: 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
Default region name [us-east-1]: us-east-1
Default output format [json]: json
(base) ~ % aws sts assume-role \
  --role-arn arn:aws:iam::578383550493:role/StaleWindowRole \
  --role-session-name test-session \
  --profile staleuser


An error occurred (AccessDenied) when calling the AssumeRole operation: User: arn:aws:iam::578383550493:user/StaleWindowTester is not authorized to perform: sts:AssumeRole on resource: arn:aws:iam::578383550493:role/StaleWindowRole
(base) ~ % aws sts assume-role \
  --role-arn arn:aws:iam::578383550493:role/StaleWindowRole \
  --role-session-name test-session \
  --profile staleuser




{
    "Credentials": {
        "AccessKeyId": "ASIAYNKSYTAOWJVGG3OV",
        "SecretAccessKey": "rRZy9Aaf02O3NYb3GOEN2wRPcXrTzeQW+NcLuuu0",
        "SessionToken": "IQoJb3JpZ2luX2VjEA4aCXVzLWVhc3QtMSJHMEUCIQC7iLRZLtAShtbQDVT1RykHwXBMQN8vgmVuJV6einj29gIgedRfsXYzLMR3m15a15S7w3H6uQUZb8XBCSr8MpUhCWsqmQIIFxACGgw1NzgzODM1NTA0OTMiDPOLxVWI1W88lzA3tSr2AVv8VaM4+F85TM1jFdbOC3P6JvBBCt4XZmcTaYHqkikwDHijjK4OYeYdibjsFTzV1E32+ZiUQ2sKhg1e+AkFEM0+0ctENCe2ULz/8KuqMA3LtOuKgndMqex35i2IdyRUE+l/9qIpVISD6LMvFPvYDdiiWS0HsFlv5ECxvAeNeLCQoeb00Lhhkm6189uRvNyx/rWHD6QeMbQ317wjTe4ltt5/6Fx/06B5VuDipGrGqvwA092Wki7OzBTyVpgA2umsPQqcKTDXmHgBZG1pthA2zXHQKIfX15jOpYnAT+6iEgDKzy1dK4PqBFzl7BehEqUuCjBO18kl3TCPiJrDBjqdAWizjSad4xAcjsdAD0ECzDzw1bIE5NBry+mUFYSTWQnci6yAHX5MtBKBbtoLz1DfK4RGurXrYWNMbii4pDfRgwdKlTd/wUBDhm7YVrz7tssBBhdmwxD05tz5UPNxjvV3oMZn0KcTWDV6S2cORQk6L/rDEfNv5FFDfZY3vGFnxdZgr5tbcf5ja2hzxkFqD0ZvI5sUJyV8c8jZFMONcrI=",
        "Expiration": "2025-07-03T14:22:23+00:00"
    },
    "AssumedRoleUser": {
        "AssumedRoleId": "AROAYNKSYTAORBBEFLMOQ:test-session",
        "Arn": "arn:aws:sts::578383550493:assumed-role/StaleWindowRole/test-session"
    }
}
~
~
~
~
~
~
~
~
~
~
(END)
</code>


<h4>step 7: Create a new CLI profile for the temp STS credentials</h4>
<code>aws configure --profile tempcreds
</code>
then enter :
<code>AWS Access Key ID → from STS AccessKeyId

AWS Secret Access Key → from  STS SecretAccessKey

Default region name → us-east-1 

Output format: json</code>



revoke the session:
![image](https://github.com/user-attachments/assets/e5007cc0-b541-46ff-a556-266b457064d5)
![image](https://github.com/user-attachments/assets/8ce90f32-76db-4ede-ad3f-485709bcab3b)


create a trail: 
![image](https://github.com/user-attachments/assets/6ba9e375-7bb5-4b3e-8e15-b0a139ef1ec0)



