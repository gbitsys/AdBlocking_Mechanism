#!/bin/bash
# You are NOT allowed to change the files' names!
domainNames="domainNames.txt"
IPAddresses="IPAddresses.txt"
adblockRules="adblockRules"
adblockRulesIPV6="adblockRulesIPV6"

function adBlock() {
	if [ "$EUID" -ne 0 ]; then      #Cheks if we are root users
		printf "Please run as root.\n" #We should use this program as root user.
		exit 1
	fi
	if [ "$1" = "-domains" ]; then
		# Configure adblock rules based on the domain names of $domainNames file.
		echo "Filling ip file don't close (this may take a while)"
		while read -r line; do
			ip4block=$(host -t A $line | grep address | awk '{print $4}')
			ip6block=$(host $line | grep "IPv6" | awk '{print $5}')
			if [ -z "$ip4block" ]; then                           #checking if ip4 we fetched is empty
				printf "ipv4 not found for this domain\n" >/dev/null #empty ip
			else
				for ip in $ip4block; do
					echo "$ip" >>$IPAddresses #ip exists
					#file format is ip line by line
					iptables -A INPUT -s $ip -j REJECT
				done
			fi

			if [ -z "$ip6block" ]; then
				printf "ipv6 not found for this domain\n" >/dev/null #empty ip
			else
				for ip6 in $ip6block; do
					echo "$ip6" >>$IPAddresses
					ip6tables -A INPUT -s $ip6 -j REJECT
				done
			fi
		done <"$domainNames"

		true

	elif [ "$1" = "-ips" ]; then
		# Configure adblock rules based on the IP addresses of $IPAddresses file.

		true

	elif [ "$1" = "-save" ]; then
		# Save rules to $adblockRules file.
		iptables-save >$adblockRules
		ip6tables-save >$adblockRulesIPV6
		true

	elif [ "$1" = "-load" ]; then
		# Load rules from $adblockRules file.
		iptables-restore <$adblockRules
		ip6tables-restore <$adblockRulesIPV6
		true

	elif [ "$1" = "-reset" ]; then
		# Reset rules to default settings (i.e. accept all).
		iptables -F
		ip6tables -F
		true

	elif [ "$1" = "-list" ]; then
		# List current rules.
		iptables -L -n | more #we use 'more' command for better output printing
		ip6tables -L -n | more
		true

	elif [ "$1" = "-help" ]; then
		printf "This script is responsible for creating a simple adblock mechanism. It rejects connections from specific domain names or IP addresses using iptables.\n\n"
		printf "Usage: $0  [OPTION]\n\n"
		printf "Options:\n\n"
		printf "  -domains\t  Configure adblock rules based on the domain names of '$domainNames' file.\n"
		printf "  -ips\t\t  Configure adblock rules based on the IP addresses of '$IPAddresses' file.\n"
		printf "  -save\t\t  Save rules to '$adblockRules' file.\n"
		printf "  -load\t\t  Load rules from '$adblockRules' file.\n"
		printf "  -list\t\t  List current rules.\n"
		printf "  -reset\t  Reset rules to default settings (i.e. accept all).\n"
		printf "  -help\t\t  Display this help and exit.\n"
		exit 0
	else
		printf "Wrong argument. Exiting...\n"
		exit 1
	fi
}

adBlock $1
exit 0
