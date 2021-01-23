#!/bin/bash

#Variables Declaration
CredStorage="/home/cs1920556/"
User=$1
directory=$2
if [ -z "$User" ];then
		echo "Error: Parameter Problem"
      elif [ -n "$User" ] && [ ! -d "$User" ];then		
		echo "Error: User Dont Exists"
      else
		tree $User
		echo "OK: Here are your files"
      fi




