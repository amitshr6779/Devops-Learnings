![Screenshot from 2023-05-18 18-36-32](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/d560675d-89d5-44c8-aa1b-5b11b00e0a52)

A brief history of how the internet was born: <br>
• It all started in the 1960s. The US department of Defense Advanced Research Projects Agency (DARPA) worked on a packet-switching theory to send a message between themselves and a partner university. <br>
• In the 1970s, Transmission Control Protocol and Internet Protocol (IP) was developed in order to link multiple networks together.  <br>
• In the 1980s, dial-up was introduced as a way to access the internet and allowed the revolutionary way to communicated across the world using email. This was possible through a local area network (LAN). <br>
• In the 1990s, hypertext markup language (HTML) and uniform resource locator (URL) were created to visualize what is called the World Wide Web (www). In 1995 big things were happening, such as Windows 95, and large company launches that you most likely still shop on today.  <br>
• In the 2000s, the dotcom bubble had reached its end; however, this created a new wave of opportunity for technology. Networking, the internet, and the devices you use today have evolved rapidly since the start of the early 2000s. From desktops, to laptops, to tablets, technology is constantly  <br>

<hr>

![Screenshot from 2023-05-18 18-44-54](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/b785f347-ed4f-4a1d-bb86-a4fc69313fe2)

What is computer networking? <br> <br>
• It’s a collection of computing devices that are logically connected together to communicate and share resources. <br> <br>
• An example is like an interstate highway system that connects cities and states together from one point to another. Like networking, it made it possible to be connected in a faster and easier way.

How does it work at a basic level? <br> <br>

• It has a node. A node is like a computer, router, switches, modems, and printers, which are connected through links (a way for data to transmit, such as cables), that follow rules to send and receive data. <br> <br>
• It has a host. A host is a node that has a unique function. Other devices connect to nodes so they can access data or other services. An example of a host is a server, because a server can provide access to data, run an application, or provide a service <br><br>

<hr>

![Screenshot from 2023-05-18 18-51-12](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/a771f30f-0dbc-4f29-b9d3-763d5daae75c)
<br>
Above is an example of a basic computer network where a computer is connected through a network interface card (NIC) and traffic is routed/switched through a switch to its intended destination. When there are more computers within buildings, computers are grouped together to a switch that is then connected to a router as seen on the next slide.
<br>

![Screenshot from 2023-05-18 18-53-47](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/5237af52-9c72-4b4d-854f-cf5d902a4bf8) <br> <br>
As noted in the previous slide, in a bigger network, the computers are grouped to a switch, in this example, switch A and B, also known as subnets. These switches send traffic to a router, which is ultimately a bigger switch with more intelligent functions. <br> <br>
 • Computer A is a typical node on a network. On the network, it can be either a client or a server. Clients and servers will be discussed shortly. <br> <br>
 • Network interface card (NIC) connects a computer to a network cable. <br> <br>
 • Network cables connect the nodes on a network. <br> <br>
 • Switch A and B connect multiple devices on a network. <br> <br>
 • Router connects multiple switches on a network. <br> <br>
 
![Screenshot from 2023-05-18 19-39-03](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/75ec0beb-486e-45a9-9af4-8aefeca532e2)

The diagram illustrates how data flows in an OSI-compliant network from a source computer to a target computer.  <br> <br>
1. Data starts from the source computer. The source computer sends data to the target computer. As the data leaves the source computer, it is processed and transformed by the different functions in the OSI layers, from layer 7 down to layer 1. During transmission of data, it can also be encrypted, and additional transmission-related information, which are called headers, are added to it. <br> <br>
2. Next, the data travels to the application layer (layer 7). This layer provides the interface that enables applications to access the network services. <br> <br>
3. Next is the presentation layer (layer 6). This layer ensures that the data is in a usable format and handles encryption and decryption. <br> <br>
4. The data moves to the session layer (layer 5). This layer maintains the distinction between the data of separate applications. <br> <br>
5. Next is the transport layer (layer 4). This establishes a logical connection between the source and destination. It also specifies the transmission protocol to use, such as Transmission Control Protocol (TCP). <br> <br>
6. The network layer (layer 3) decides which physical path the data will take. <br> <br>
7. The data link layer (layer 2) defines the format of the data on the network. <br> <br>
8. Finally, the data travels to the physical layer (layer 1), which transmits the raw bitstream over the physical network. <br> <br>
9. After the data has been transformed through the OSI layers, it is in a package format that is ready to be transmitted over the physical network. <br> <br>
10.Once the target computer receives the data package, it unpacks the data through the OSI layers, but in reverse, from layer 1 (physical) through 7 (application). <br> <br>

![Screenshot from 2023-05-18 20-12-13](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/47eb64a3-7e96-4ca1-b653-8718897a0163)

<br> <br>

![Screenshot from 2023-05-18 20-14-30](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/64caf3c9-56c3-480d-8868-4f96f78ddd24)

The client connects to the server over a network. <br>
A client is also a computer hardware device that accesses the data or a service that is managed by another computer hardware device, which is also called a server. <br>
A client can also refer to software on the accessing device. For example, a web browser is a client for accessing content from a web server. <br>

![Screenshot from 2023-05-18 20-19-29](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/f13cf6c8-d45e-49bd-9287-27a5c09bd2c2)

![Screenshot from 2023-05-18 20-21-51](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/93e24e1b-e302-4836-bbf6-35f2aa147826)

![Screenshot from 2023-05-18 20-22-26](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/f329ce33-e059-4556-9d78-9a1d144fd8e6)

![Screenshot from 2023-05-18 20-22-46](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/0afdba5b-1e0b-493d-93fa-97b235684f4c)

![Screenshot from 2023-05-18 20-23-03](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/95f07b5f-5dbe-4732-a225-e9f351b887df)

![Screenshot from 2023-05-18 20-23-19](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/f4724412-9c26-466b-bc1f-20d48b3c9eb0)

![Screenshot from 2023-05-18 20-23-37](https://github.com/amitshr6779/Devops-Learnings/assets/84858868/c64041e6-0921-4834-8113-7c936c7c9d65)


