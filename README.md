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
