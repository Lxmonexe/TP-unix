#!/bin/bash
# Run server with ./nc-server.sh
# Connect client with "nc localhost 12345"
# Enjoy ping-pong.
rm ./fifo
mkfifo ./fifo


function interpret () {

echo "Welcome user." "$(date '+%d/%m/%Y %H:%M:%S')"


read line

mdp=`cat mdp.txt`;
if [ $line == $mdp ];then 
dt=$(date '+%d/%m/%Y %H:%M:%S')
while read $line_2
do
echo "Debug, received == $line ==" "$dt"  >&2 
saisie=$line_2
echo "${saisie}" | bash
done

else 
echo "mauvais mot de passe"
fi
}



function verify() {
mdp=cat `mdp.txt`
read line
if [$line == $mdp];then

interpret ;

else 
echo "mauvais mot de passe"
fi
}




echo "Start."

nc -l localhost 12345 < ./fifo | verify > ./fifo

echo "End."
