# AdBlocking_Mechanism
### Authors: 
- Georgios Bitsis  </p>
- Athanasios Karakos 
### Setup:
```
chmod +x adblock.sh
sudo bash adblock.sh -help #or be root user
```
You have to create also a file named domainNames.txt 
or IPAddresses.txt or both. 

### Available options: 
### 1. -domains
```
sudo bash adblock.sh -domains
```
Configure adblock rules based on the domain names of 'domainNames.txt' file.  
It is necessary to have this file under your program directory and you should have only one domain name at a line.  
Then the file named IPAddresses.txt will be filled automatically.  
This file (IPAddresses.txt) is used to create your rules.  
This program uses host command to resolve the ip address (or addresses) for a specific domain name.  
Works for both ipv4 and ipv6 addresses.  
Using this command you may wait for a while because resolving ip for domain names takes some time  
depending on network connection or the existance of domain name. (DNS queries take time).  

### 2. -ips
```
sudo bash adblock.sh -ips
```
 Configure adblock rules based on the IP addresses of 'IPAddresses.txt' file.  
 It is necessary to have this file under your program directory.  
 The program reads ip addresses line by line from the line.  
 Works for both ipv4 and ipv6 addresses.  

 ### 3. -save 
 ```
sudo bash adblock.sh -save
```
With this command you save current rules to a file named adblockRules.  
adblockRules this is the file for which iptables command is used (handling ipv4 addresses)  
adblockRulesIPV6 is the file for which ip6tables command is used (handling ipv6 addresses)  

### 4. -load 
```
sudo bash adblock.sh -load
```
This command is used to load rules from files adblockRules and adblockRulesIPV6  

### 5. -list 
```
sudo bash adblock.sh -list
```

List current rules.  
(This may be tricky we use the 'more' command inside the script twice)  

### 6. -reset
```
sudo bash adblock.sh -reset
```
Reset rules to default settings (i.e. accept all).  

### Notes
When visiting sites that are blocked we encounter time out error connection.   
Because our domain names are limited we will unfortunately encounter some ad websites,  
so we can add the name of website to the list to prevent connection in the future.  





