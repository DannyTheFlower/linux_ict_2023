#!/bin/bash

export LANG=en_US.UTF-8

VERTICAL_LINE="│  "
TAB="   "
MID_PATH="├──"
END_PATH="└──"

total_dirs=0
total_files=0

# $1 - directory, $2 - prefix before mid- or end-path
tree() {
	cd $1

    local end_flag=0
    declare -a subdirs=($(ls))

    for i in ${!subdirs[@]}
    do
    	element=${subdirs[$i]}
    	if [[ $i -eq $((${#subdirs[@]} - 1)) ]]
    	then
    		echo "$2$END_PATH $element"
    		end_flag=1
    	else
    		echo "$2$MID_PATH $element"
    	fi

    	if [[ -d $element ]]
    	then
    		let "total_dirs++"
    		if [[ end_flag -eq 1 ]]
    		then
    			tree $element "$2$TAB "
    		else
    			tree $element "$2$VERTICAL_LINE "
    		fi
    	else
    		let "total_files++"
    	fi
    done

    cd ..
}

echo "."
tree $1 ""

printf "\n"
if [[ $total_dirs -eq 1 ]]
then
	printf "$total_dirs directory, "
else
	printf "$total_dirs directories, "
fi
if [[ $total_files -eq 1 ]]
then
	echo "$total_files file"
else
	echo "$total_files files"
fi