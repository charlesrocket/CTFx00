#!/bin/bash
cat << "EOF"
___ ___ _______
|   Y   |   _   |
|   1   |.  |   |
\_   _/|.  |   |
 |:  | |:  1   |
 |::.| |::.. . |
 `---' `-------'
EOF
read -p "target name:"  name
read -p "target IP:"  IP
echo "target set to $IP!"
mkdir -p $name/recon
cd $name
printf "\033[41myo $name!\033[0m \n"
nmap -sC -sV -oN recon/initial_nmap.txt -e tun0 -v -Pn $IP
sudo masscan -p1-65535 -e tun0 -oL recon/allports.txt --rate=1000 -vv -Pn $IP
gobuster dir -u http://$IP -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -o recon/dirscan.txt
ffuf -w /usr/share/wordlists/dirb/big.txt -u http://$IP/FUZZ | tee recon/ffuf.txt
