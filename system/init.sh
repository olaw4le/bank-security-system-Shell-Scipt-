#!/bin/bash

#Variables Declaration
CredStorage="/home/cs1920556/"
User=$1

if [ -z "$User" ];then
		echo "Error: Parameter Problem"
elif [ -n "$User" ] && [ -d "$User" ] ;then		
		echo "Error: User Already Exists"
else
		mkdir -p $User
		echo "OK: User Created"
fi
