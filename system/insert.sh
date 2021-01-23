#!/bin/bash 
#Variables Declaration

CredStorage="/home/cs1920556/"
User=$1
Service=$2
Payload=$3
Update=""
ServiceFolder=""
ServiceFile=""
bash semaphore_p.sh $User

#Checking if parameter is acceptbale and user already exists

if [ $# -eq 3 ];then
	if [ ! -d "$User" ];then
		echo "Error: User Does not Exist"
	elif [[ $Service == *"/"* ]];then
		ServiceFolder="$(cut -d'/' -f1 <<<"$Service")"
		ServiceFile="$(cut -d'/' -f2 <<<"$Service")"

		#Create the Service Folder if  it does not exists
		[[ -d "$User/$ServiceFolder" ]] || mkdir -p "$User/$ServiceFolder"

			if [ -f "$User/$ServiceFolder/$ServiceFile" ];then
				echo "Error: Service Already Exists"
			else
				echo -e $Payload > "$User/$ServiceFolder/$ServiceFile"
				echo "OK: Service Created"
			fi
	else
			if [ -f "$User/$Service" ];then
				echo "Error: Service Already Exists"
			else  
				echo -e $Payload > "$User/$Service"
				echo "OK: Service Created"
			fi
	fi
			
elif [ $# -eq 4 ];then
	User=$1
	Service=$2
	Payload=$4
	Update=$3

	if [ ! -d "$User" ];then
		echo "Error: User Does not Exist"
	elif [[ $Service == *"/"* ]];then
		ServiceFolder="$(cut -d'/' -f1 <<<"$Service")"
		ServiceFile="$(cut -d'/' -f2 <<<"$Service")"	
	

		if [[ $Update == "" ]];then
			#Create the Service Folder if it does not exists
			[[ -d "$User/$ServiceFolder" ]] || mkdir -p "$User/$ServiceFolder"
			if [ -f "$User/$ServiceFolder/$ServiceFile" ];then
				echo "Error: Service Already Exists"
			else
				echo -e $Payload > "$User/$ServiceFolder/$ServiceFile"
				echo "OK: Service Created"
			fi
		elif [[ $Update == "f" ]];then
			if [ -f "$User/$ServiceFolder/$ServiceFile" ];then
				echo -e $Payload > "$User/$ServiceFolder/$ServiceFile"
				echo "OK: Service Updated"
			else 
				echo -e $Payload > "$User/$ServiceFolder/$ServiceFile"
				echo "OK: Service Created"
			fi
		fi
	else
	 	if [[ $Update == "" ]];then
			if [ -f "$User/$Service" ];then
				echo "Error: Service Already Exists"
			else
				echo -e $Payload > "$User/$Service"
				echo "OK: Service Created"
			fi
		elif [[ $Update == "f" ]];then 
			if [ -f "$User/$Service" ];then
				echo -e $Payload > "$User/$Service"
				echo "service updated"		
			fi
		fi
	fi
fi
bash semaphore_v.sh $User
