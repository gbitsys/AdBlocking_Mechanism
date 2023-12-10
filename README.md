# AdBlocking_Mechanism
### Authors: 
- Georgios Bitsis (2021030043) </p>
- Athanasios Karakos (2021030011)
### Setup:
```
chmod +x adblock.sh
sudo bash adblock.sh -help #or be root user
```
### Available options: 
#### 1. -domains
```
sudo bash adblock.sh -domains
```
Configure adblock rules based on the domain names of 'domainNames.txt' file.  
It is necessary to have this file and you should have only one domain name at a line.  
Then the file named IPAddresses.txt will be filled automatically.  
This file (IPAddresses.txt) is used to create your rules.  
This program uses host command to resolve the ip address (or addresses) for a specific domain name.  
Works for both ipv4 and ipv6 addresses.  

### 2. -ips
```
sudo bash adblock.sh -ips
```
 Configure adblock rules based on the IP addresses of 'IPAddresses.txt' file.
