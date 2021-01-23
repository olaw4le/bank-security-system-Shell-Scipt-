#!/bin/bash

if [ ! -p "server.pipe" ]; then
echo "Server Currently not available try again later"
exit 0
fi

if [ $# -eq 2 ] && [ $2 = "init" ]; then
client_id=$1
req=$2

elif [ $# -eq 4 ] && [ $2 = "insert" ]; then
client_id=$1
req=$2
username1=$3
service=$4

elif [ $# -eq 4 ] && [ $2 = "update" ]; then
client_id=$1
req=$2
username1=$3
service=$4


elif [ $# -eq 3 ] && [ $2 = "ls" ]; then
client_id=$1
req=$2
username1=$3

elif [ $# -eq 4 ] && [ $2 = "rm" ]; then
client_id=$1
req=$2
username1=$3
service=$4

elif [ $# -eq 4 ] && [ $2 = "show" ]; then
client_id=$1
req=$2
username1=$3
service=$4

elif [ $# -eq 2 ] && [ $2 = "shutdown" ]; then
client_id=$1
req=$2

else 
echo "Error: parameter problem"
exit 1
fi

mkfifo "$client_id".pipe
echo "welcome user $client_id"

trap ctrl_c INT
function ctrl_c(){
rm "$client_id".pipe
exit 1
} 



while true; do
	case "$2" in
	"init")
	echo "PLease enter username"
	read username
	echo "$client_id"  "$req" "$username" > server.pipe
	read message < "$client_id".pipe
	echo $message
	exit 0
	
	;;

	"insert")
	echo "please enter login"
	read login
	echo "Do you want a generated password?"
	read answer
	if [ $answer == "y" ]; then
	password=$(openssl rand -base64 10)
	echo $password
	else
	echo "please enter password"
	read password
	fi
	echo "$client_id" "$req" "$username1" "$service" "$login" "$password" > server.pipe
	read message < "$client_id".pipe
	echo $message
	rm "$client_id".pipe
	exit 0
	;; 

	"show")
	echo "$client_id" "$req" "$username1" "$service" > server.pipe
	
	#read message < "$client_id".pipe
	while read -r input; do
	echo $input
	done < "$client_id".pipe
	#echo $message
	rm "$client_id".pipe
	exit 0
	;;

	"ls")
	echo "$client_id" "$req" "$username1" > server.pipe
	cat  "$client_id".pipe	
	rm "$client_id".pipe
	exit 0
	;;

	"rm")
	echo "$client_id" "$req" "$username1" "$service" > server.pipe
	read message < "$client_id".pipe
	echo $message
	rm "$client_id".pipe
	exit 0
	;;
	"update")
	echo "New login"
	read x
	echo "Do you want a genrated password y/n?"
	read y
	if [ $y == "y" ]; then
	y=$(openssl rand -base64 10)
	echo $y
	else
	echo "New password"
	read y
	fi
	echo "$client_id" "$req" "$username1" "$service" "$x" "$y"  > server.pipe
	read message <"$client_id".pipe
	echo $message
	rm "$client_id".pipe
	exit 0
	;;
	"shutdown")
	echo "$client_id" "$req" > server.pipe
	read message < "$client_id".pipe
	echo $message
	rm "$client_id".pipe
	exit 1
      esac

done



