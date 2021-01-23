#!/bin/bash
echo "Server is now running"

mkfifo server.pipe

trap ctrl_c INT
function ctrl_c() {
	rm server.pipe
	echo "Server Shutdown"
	exit 1
	 }

while true; do	
	 read answer  < server.pipe
	mylist=($answer)
	client_id=${mylist[0]}
	option=${mylist[1]}
	username=${mylist[2]}
	payload=${mylist[3]}
	login=${mylist[4]}
	password=${mylist[5]}
	key="f"
	format="login:$login\nPassword:$password"
	case "$option" in
		"init")
		echo $option $username
		 bash init.sh  $username > "$client_id".pipe &
		;;
		"insert")
		echo $option $username $payload $format
		bash insert.sh $username $payload $format > "$client_id".pipe &
		;;
		"update")
		echo $option $username $payload $key $format
		bash insert.sh $username $payload $key $format > "$client_id".pipe &
		;;
		"show")
		echo $option $username $payload
		bash show.sh $username $payload > "$client_id".pipe &
		;;
		"rm")
		echo $option $username $payload $format
		bash rm.sh $username $payload  > "$client_id".pipe &
		;;
		"ls")
		echo $option $username
		bash ls.sh $username > "$client_id".pipe &
		;;
		"shutdown")
		echo $option
		echo "Server shutdown" > "$client_id".pipe &
		ctrl_c
		;;
		*)
		echo "Error: bad request" 
		exit 1
				 
         esac
	done
