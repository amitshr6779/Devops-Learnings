
# Setup Nginx Server 

### Install nginx in ubuntu
```
sudo apt update
sudo apt install nginx
sudo systemctl status nginx
```
### Setting Up Server for routing
```
mkdir -i /opt/nginx
cd /etc/ngninx
ln -s /etc/nginx/nginx.conf /opt/nginx
ln -s /etc/nginx/sites-enabled/  /opt/nginx
```

### Now write down you routing file
```
cd /opt/nginx/sites-enabled
vi test.technicalguy.club
```

```
server {
  server_name test.technicalguy.club;
  location / {
        proxy_pass http://test.technicalguy.club:5601;
   }

```
###  Now test your above nginx configration
```
sudo nginx -t
sudo systemctl restart nginx
```

### To secure or https to your Domain , install certbot

```
sudo apt install certbot python3-certbot-nginx
```

### Now, to activate htpps and certficate , run below commands inside your custom nginx path

```
sudo certbot -t
```

