#!/bin/bash

wget "$1" 2>/dev/null 

 x=$(echo "$1" | cut -d '.' -f 1)
 cat index.html | grep "href" | cut -d ":" -f 2 | cut -d "/" -f 3 | grep "$1" | cut -d '"' -f 1 | sort | uniq >> sub_$x.txt



for i in $(cat sub_$x.txt)
do 
if [[ $(ping -c 1 $i 2> err.txt) ]]
then 
echo Live sub : $i
echo $i >> valid_sub_$x.txt
else 
echo  Die sub : $i
fi 
done


for ip in $(cat valid_sub_$x.txt)
do


host $ip | cut -d " " -f 4  | grep -v "address" | grep -v "alias" | sort | uniq |tee ips_$1.txt
done 



