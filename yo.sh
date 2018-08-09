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
mkdir $name
cd $name
printf "\033[41myo $name!\033[0m "
nmap -sC -sV -oA $name $IP
nmap -sU -p1-1000 $IP >> $name
uniscan -u $IP -qweds
nikto -host $IP
dirb $IP
cd ..
