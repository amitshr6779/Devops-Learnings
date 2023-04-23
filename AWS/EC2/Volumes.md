## Create External Volume and attach to EC2 in an availabity zone.
Steps: <br>
1. Create External volume in an availabity zone.
![1681760753547](https://user-images.githubusercontent.com/84858868/232594760-9cde8c39-2761-4dde-a672-cf4546f29b70.JPEG)


2. Attach above ext. volume to EC2 in same availabity zone as volume.
![1681760753358](https://user-images.githubusercontent.com/84858868/232594891-31b928ba-9904-46cb-9330-fd0c1075a80c.JPEG)

![1681760753194](https://user-images.githubusercontent.com/84858868/232594944-1adbb0ab-bd80-4766-952a-b744d33d7406.JPEG)


3. Login to EC2 and make volume online.
* Go to server manager
![1681760754985](https://user-images.githubusercontent.com/84858868/232595222-d9f14edb-c69b-4d02-b749-c898184d88b0.JPEG)

![1681760754449](https://user-images.githubusercontent.com/84858868/232595262-47d7da83-4dfb-47e2-8432-d7f47965e9c3.JPEG)

* create new volume  with  default values & create voulme

![1681760754171](https://user-images.githubusercontent.com/84858868/232595298-571aa8ff-35ff-4e6f-8f33-2462e2682b9a.JPEG)

![1681760753694](https://user-images.githubusercontent.com/84858868/232595316-a33277e3-7c8b-4507-803a-d7482cab1204.JPEG)

<br> <br>

# Attach volume in a availabity zone to another availabity zone.
Steps: <br>
1. Create Snapshot from volume.
![1681761676870](https://user-images.githubusercontent.com/84858868/232599130-98a6f676-3a2e-4625-9098-731585fdb93f.JPEG)
![1681761676022](https://user-images.githubusercontent.com/84858868/232599216-60a4cc27-d378-4430-837c-2499b963f946.JPEG)

2. Create Volume  from above snapshot in another availabity zone.

![1681761674978](https://user-images.githubusercontent.com/84858868/232599372-a62c9962-696c-4687-8221-0286cd4a8173.JPEG)

![1681761673505](https://user-images.githubusercontent.com/84858868/232599392-a7129ae5-f0af-4372-a8de-867abe186cfe.JPEG)
![1681761673266](https://user-images.githubusercontent.com/84858868/232599434-7e1fb5bf-2648-4876-a60b-d912b9b510ce.JPEG)

3. Attach Volume to EC2 in availabity zone where above volume is created.
![1681761673057](https://user-images.githubusercontent.com/84858868/232599513-da80b787-6a27-4215-ba15-2af3cdb618a5.JPEG)

![1681761672842](https://user-images.githubusercontent.com/84858868/232599534-96e8122b-dbbf-4daa-8146-53abfab183cb.JPEG)


