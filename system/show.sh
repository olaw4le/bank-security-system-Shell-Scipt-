#!/bin/bash

#Variables Declaration
CredStorage="/home/cs1920556/"
User=$1
Service=$2
ServiceFolder=""
ServiceFile=""

#Checking if parameter is acceptbale and user already exists
if [ ! $# -eq 2 ];then
	echo "Error: Parameter Problem"
elif [ ! -d "$User" ];then
	echo "Error: User Does not Exist"
elif [[ $Service == *"/"* ]];then
	ServiceFolder="$(cut -d'/' -f1 <<<"$Service")"
	ServiceFile="$(cut -d'/' -f2 <<<"$Service")"

	if [ ! -f "$User/$ServiceFolder/$ServiceFile" ];then
		echo "Error: Service Does not Exist"
	else
		cat "$User/$ServiceFolder/$ServiceFile"
	fi
else
	 
	if [ ! -f "$User/$Service" ];then
		echo "Error: Service Does not Exist"
	else  
		cat "$User/$Service"
	fi
fi
