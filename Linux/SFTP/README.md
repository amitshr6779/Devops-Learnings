# What is SFTP ?
<summary> SFTP stands for SSH File Transfer Protocol </sumaary>
<summary> It enables a secured data transfer between SFTP server and client machine.  </summary>
<summary> SFTP encrypts both data and commands and also protects passwords and sensitive information from being transferred openly over the network.  </summary>

## Lets Setup the SFTP server on AWS EC2 (Ubuntu) <br>
Follow to following steps to configure SFTP :
<br>
<summary>SSH to ec2 Instance </summary>
<summary>Move to root user </summary>

```
sudo su
```
<summary>Update all the packages </summary>

```
apt update -y
```
<summary> Install vsftpd package </summary>

```
apt-get install vsftpd
```

<summary> Add a user and set its password </summary>

```
adduser testuser
```
<summary>Make .ssh directory in User’s Home Directory. This directory will help us to login into the server using a private key.</summary>

```
mkdir /home/testuser/.ssh
```
<summary> Let us create key pair using KeyGen. First go to the .ssh directory which we have created recently.</summary>

```
cd /home/testuser/.ssh
ssh-keygen -t rsa
```
<summary> Copy the content of public key (file with .pub extension) into the authorized_keys which should be located inside the .ssh directory </summary>

```
cat id_rsa.pub
vim authorized_keys
```
` Paste the Pulic Key content in authorized_keys file `

<summary> Now change the file permissions and the ownership </summary>

```
chmod 700 /home/testuser/.ssh
chmod 600 /home/testuser/.ssh/authorized_keys
chown -R testuser:testuser /home/testuser/.ssh
```

<summary> jail the user to specific directory and we should restrict it’s shell access so that user can’t access the command shell of the server. </summary>

`First of all, create a group for SFTP users, then, add our user into that group`
```
groupadd sftpusers
adduser testuser sftpusers
```

```
mkdir /sftp
chmod 755 /sftp
chown root:sftpusers /sftp
```
<summary> Create a directory inside ‘sftp’ for example, we are going to create directory ‘shared’ to share the data among several users. Also Change the permissions of ‘shared’ directory so that only users of sftpusers group can see and modify the data inside the ‘shared’ directory </summary>

```
mkdir /sftp/shared
chown root:sftpusers /sftp/shared
```
<summary> Modify sshd_config to specify the SFTP directory and jail user into that directory </summary>

Open the file `vi /etc/ssh/sshd_config` and enter the following content at the end of file..

```
#Subsystem sftp /usr/lib/openssh/sftp-server
Subsystem sftp internal-sftp
Match group sftpusers
ChrootDirectory /sftp/
PasswordAuthentication yes
X11Forwarding no
AllowTcpForwarding no
ForceCommand internal-sftp
```
**NOTE** : Make sure to comment `Subsystem sftp /usr/lib/openssh/sftp-server`  this line, if already exists.

<summary> Switch the ownership of user’s home directory to root user without changing the ownership of .ssh directory which will be used to verify the Key </summary>

```
chown root:root /home/atidke
chown -R  testuser:testuser /home/atidke/.ssh
```
<summary>Finally, Restart SSH </summary>

```
/etc/init.d/ssh restart
```

</summary> Now Lets Login sftp server from client </sumary>

```
sftp testuser@<sftp-server-DNS-OR-IP>
```

**Example**

![Screenshot from 2023-01-11 01-44-05](https://user-images.githubusercontent.com/84858868/211652685-b1fdb451-8906-4fbb-b658-0155a04d6707.png)

**Refrences** <br>
https://blog.e-zest.com/setting-up-sftp-server-on-amazon-ec2  <br>
https://dev.to/tanmaygi/how-to-create-a-sftp-server-on-ec2centosubuntu--1f0m
