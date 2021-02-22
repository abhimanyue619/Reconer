#!/bin/bash

# version
version=1.0


# banner
echo """

██████╗░███████╗░█████╗░░█████╗░███╗░░██╗███████╗██████╗░
██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║██╔════╝██╔══██╗
██████╔╝█████╗░░██║░░╚═╝██║░░██║██╔██╗██║█████╗░░██████╔╝
██╔══██╗██╔══╝░░██║░░██╗██║░░██║██║╚████║██╔══╝░░██╔══██╗
██║░░██║███████╗╚█████╔╝╚█████╔╝██║░╚███║███████╗██║░░██║
╚═╝░░╚═╝╚══════╝░╚════╝░░╚════╝░╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝
                
                By

  _|_|_  _   .|| _  _  _ |_  _  _|  _  _
   | | |(/_\/|||(_|(_|(/_| |(_|(_|<(/_| 
                    _|                  
          ------------------          
       ~ |Do Hacks to Secure| ~
          ------------------
  https://twitter.com/thevillagehackr
    Hey don't miss this version $version
    """

# spinner
spinner ()
{
    bar="+++++++++++++++++++++++++++++++++++++++++++"
    barlength=${#bar}
    i=0
    while ((i <100)); do
        n=$((i*barlength / 100))
        printf "\033[1;95m\r%-${bar}s\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.01
        printf " "
    done  
    printf "\n"
}

ender()
{
  echo " "
  echo -e "----------------------------------------------------------------------"
  echo " "
}

# Date
printf "\033[1;93m"
now="$(date)"
echo "Date: "$now""
printf "\033[0;37m"

# calling spinner
echo -e "   "
echo -e "\e[41m\033[1;97m Initiating Ping request to all Targets\033[0;37m"
echo -e "   "
spinner
sleep 0.01

# ping
ping -c 1 "$1" > /dev/null
if [ $? -eq 0 ]; then
echo -e "\033[0;92m  [+] node [$1] is \033[0;92m up \033[0;92m "
echo -e "\033[0;37m "
else
echo -e "\033[0;91m  [-] node [$1] is \033[0;91m down \033[0;91m "
echo -e "\033[0;37m "
fi
echo -e "\e[42m\033[1;97m Target ping probe completed \033[0;37m"
ender

# Information Gathering
echo -e "\e[44m\033[1;97m Initiating Passive Information Gathering\033[0;37m"
echo " "

# DNS

# whois scan
echo -e "\e[41m\033[1;97m Whois Information for \e[102m\033[1;97m$1 \033[0;37m"
echo " "
whois $1 
ender

# Name Server Enumeration
echo -e "\e[41m\033[1;97m Nameserver Information for \e[102m\033[1;97m$1 \033[0;37m"
echo " "
dig +short ns $1
ender

# Performing DNS IP Lookup
echo -e "\e[41m\033[1;97m Performing DNS IP Lookup \033[0;37m"
echo " "
dig a $1  
ender

# Perform MX Record Lookup
echo -e "\e[45m\033[1;97mEnter nameserver to check MX record\033[0;37m"
echo " "
read nameserver
echo " "
echo -e "\e[41m\033[1;97m Performing MX Record Lookup for \e[102m\033[1;97m$1 \e[41m\033[1;97m with \e[102m\033[1;97m$nameserver \033[0;37m"
dig mx $1 $nameserver
ender

# Perform Zone Transfer with DIG
echo -e "\e[41m\033[1;97m Performing Zone Transfer with DIG \033[0;37m"
echo " "
dig axfr $1 @$nameserver
echo " "
echo -e "\e[45m\033[1;97m For more info visit \033[0;37m"
echo " "
echo -e "\033[1;97m[+] https://www.acunetix.com/blog/articles/dns-zone-transfers-axfr\033[0;37m"
echo -e "\033[1;97m[+] For more DNS Zone Transfer Vulnerability check create curl request to https://api.hackertarget.com/zonetransfer/?q=target.com\033[0;37m"
ender
echo "test pull request"

# Perform Open Port Scanning with Nmap
echo " "
echo -e "\e[41m\033[1;97m Performing Open Port Scanning with NMAP \033[0;37m"
echo " "
nmap --open $1
echo " "
echo -e "\e[45m\033[1;97m For more info visit https://phoenixnap.com/kb/nmap-scan-open-ports\033[0;37m"
ender
