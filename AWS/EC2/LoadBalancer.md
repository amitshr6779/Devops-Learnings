## Classis LoadBalancer:
The Load Balancer balances the traffic across multiple instances in multiple availability zones is called a Classic Load Balancer. <br>
It works on all protocol i.e TCP, HTTP, HTTPS, SSL

### Steps to Configure Classic Loadbalancer :

![1682279372370](https://user-images.githubusercontent.com/84858868/233862040-9e725f18-dc34-48f0-a18b-6e7c4930944a.JPEG)

![1682279371685](https://user-images.githubusercontent.com/84858868/233862072-9ac8302c-4076-4c5b-a91b-883c680b6d1d.JPEG)

![1682279371090](https://user-images.githubusercontent.com/84858868/233862079-a63462a5-f668-4136-8df2-bf7c78769231.JPEG)

![1682279370623](https://user-images.githubusercontent.com/84858868/233862085-fd8bab5e-8b4a-456a-bfaf-66f33a95ba47.JPEG)

![1682279370038](https://user-images.githubusercontent.com/84858868/233862096-2bbefe9d-b618-44c1-9dbb-98e721334247.JPEG)

![1682279365643](https://user-images.githubusercontent.com/84858868/233862100-ddac9341-21d5-4f3a-9934-15d369fc4ef6.JPEG)

Note: Status should be above 2/2 to check loadbancer is running successfully.

<br> <br> <br>

## Application Loadbalancer

### Steps to Configure Classic Loadbalancer :

1.  Create 3 ec2 with webserver installed , Host multiple public websites  on  EC2  i.e /delhi , /mumbai , /kolkata <br>


![1682282572017](https://user-images.githubusercontent.com/84858868/233865408-56d03eb4-6578-4637-82a9-5896040d46a4.JPEG)

2. Create 3 target group for each ec2  <br>
![1682282571327](https://user-images.githubusercontent.com/84858868/233865412-1e16d9b1-25e4-482a-b0fb-f1302ffc5225.JPEG)
![1682282570809](https://user-images.githubusercontent.com/84858868/233865420-8aa3dad2-8ca0-43c3-948f-f2742462c0c8.JPEG)

![1682282570363](https://user-images.githubusercontent.com/84858868/233865423-b5e15289-5c7d-4861-9d5f-69109d94cd94.JPEG)

![1682282570184](https://user-images.githubusercontent.com/84858868/233865427-58592243-5757-4aeb-be58-f1643268e63a.JPEG)

![1682282569965](https://user-images.githubusercontent.com/84858868/233865430-1d2fb2f4-e849-488c-9fdf-99bacb53db0e.JPEG)

![1682282568762](https://user-images.githubusercontent.com/84858868/233865436-c2dce38f-33e8-4c02-87c4-4b34b7641df9.JPEG)

<br>

3. Now Create ALB  <br> <br>
![1682282568096](https://user-images.githubusercontent.com/84858868/233865438-7c4d770a-d186-48f2-94a8-40bbd722275c.JPEG)
![1682282567670](https://user-images.githubusercontent.com/84858868/233865445-664416d7-295b-42ad-a3f7-af809732d420.JPEG)

<br> 4. Add listener i.e point to one target group. Here, Delhi target Group <br> <br>

![1682282567413](https://user-images.githubusercontent.com/84858868/233865450-63d4d49e-6fe7-4700-9db8-3f04559d9d84.JPEG)
![1682282566387](https://user-images.githubusercontent.com/84858868/233865453-ba648e67-fc9d-400f-9130-8c18704f3af9.JPEG)

![1682282565174](https://user-images.githubusercontent.com/84858868/233865462-f2647e53-aaa9-423c-aa46-016a3cd3a1df.JPEG)

<br> 5. Click on listener and Add Rule --> Manage Rules

![1682282564387](https://user-images.githubusercontent.com/84858868/233865470-d08ebe28-40de-492e-8f4c-5ade2962b96f.JPEG)

<br> 6. Add website path and target group name . Here, /kolkata and kolkata target group name 
<br>

![1682282564099](https://user-images.githubusercontent.com/84858868/233865477-1bec4fd1-1194-4990-8619-ebf11d20e5e6.JPEG)

![1682282563800](https://user-images.githubusercontent.com/84858868/233865481-24ccbff2-432c-47bd-9fa3-636ef3c1a45b.JPEG)

![1682282563591](https://user-images.githubusercontent.com/84858868/233865488-a01431e4-2327-46e8-b92a-b145041763f9.JPEG)

<br> 
<hr>

# Network LoadBalancer 
It works in TCP layer. <br>

<b>Steps</b>
* Create two ec2 in diffrent avalabity zone.
* Choose Instance or Ip Address
![Screenshot_2023-05-17-19-00-10-88_f2cb81fb7cf38af7978f186f2a61634a](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/c4b46c1b-4753-4b38-8aec-8d7a1d63cce4)
* choose protocol as TCP
![Screenshot_2023-05-17-19-00-26-64_f2cb81fb7cf38af7978f186f2a61634a](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/76bcddf7-f405-48ba-8525-486a586090f1)
* Create ALB with empty target group, add target group later.
![Screenshot_2023-05-17-19-00-43-49_f2cb81fb7cf38af7978f186f2a61634a](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/3d7d800d-835c-4a13-800a-0b5153076ffe)
![Screenshot_2023-05-17-19-01-06-65_f2cb81fb7cf38af7978f186f2a61634a](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/e372dede-7b0a-430c-a2d7-044039022a2a)
* Now, Create  Traget  group with register  target group with private ip
![Screenshot_2023-05-17-19-01-36-97_f2cb81fb7cf38af7978f186f2a61634a](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/cd16a776-2542-46c5-a666-c719d0a7a7b9)
* Register Pending target
![Screenshot_2023-05-17-19-01-45-29_f2cb81fb7cf38af7978f186f2a61634a](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/5515ccda-1ee7-4f91-9195-4a326b6d9446)
* Wait for ALB to active
![Screenshot_2023-05-17-19-03-10-27_f2cb81fb7cf38af7978f186f2a61634a](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/795e4fe8-0d41-4db4-b051-01aeb59fe46b)
* Access NLB url in browser  from VPN or Public EC2  in that VPC
![Screenshot_2023-05-17-19-03-21-76_f2cb81fb7cf38af7978f186f2a61634a](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/38d9d1f2-bf42-4d5c-91db-6147dbf88aab)

**NOTE** : it will redirect traffic to one ec2/IP only untill it become unresponsive and High load then it will transfer traffic to other target group

<br>
<hr>

# Internal Loadbalancer 

It is private load balancer , access using VPN or Same  VPC  Public Instnace. <br>
Steps to Configure: <br>
* choose LB Types
* Select Internal Load balncer
* Select VPC and subnet
* Add Security Group
* Add targest
* Add Healt-check TCP



