#!/bin/bash



while IFS="." read -r IPAddress 
do

#echo $IPAddress

k=$(grep -w "$IPAddress" /opt/simbadr/var/log/simbadr/blocks/00/92)

if test -z $k
then
echo "nao--- $k"
else
echo $IPAddress
fi

done < /opt/simbadr/tmp/list.txt

exit 0
