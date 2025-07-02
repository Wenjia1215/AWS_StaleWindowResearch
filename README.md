<h4> Step 0: Create a Role in AWS for AWS STS Stale Window test: </h4>

![image](https://github.com/user-attachments/assets/374ba45c-5ead-48d1-bc80-5e16fd319873)

![image](https://github.com/user-attachments/assets/e2c066df-d131-497d-bbe3-c08b2946b049)

![image](https://github.com/user-attachments/assets/13703b5d-c3b8-432e-a931-ca19e681e360)

![image](https://github.com/user-attachments/assets/7f3b9e39-49b9-4064-81d3-13a1758b717a)

<h4>Step 1: Attach permissions to StaleWindowTester</h4>

![image](https://github.com/user-attachments/assets/44dccb10-fee1-480c-8cce-cd4b562cdfa6)


<P>in AWS, To “assume a role” means:</P>
<P>A user or service requests temporary credentials (via sts:AssumeRole) to “become” that role for a short period of time.</P>
So the user takes on the permissions of the role — but only temporarily (typically 15 minutes to a few hours).


<h4>Step 2: Generate access keys for StaleWindowTester</h4>


