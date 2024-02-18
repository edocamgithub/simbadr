
#!/bin/bash
# Writer Eduardo M. Araujo (c)2021-2024
while IFS="," read -r hostIPAddress 
do

#
#172.16.255.22,caex255-2,Server
#172.16.0.73,caex73,Desktop
#172.16.250.3,caex,Printer
#172.16.249.1,caex,VoIP
#172.16.251.79,caex,Switch
#172.16.1.203,caex1-203,Notebook
#172.16.0.11,caex11,Workstation
#172.16.255.31,caex255-031,All-in-on


ipaddress_=$hostIPAddress

#ipaddress_="172.16.251.79"

echo "--> "$ipaddress_

done < $1