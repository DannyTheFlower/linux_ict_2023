#!/bin/bash


divide() {
	local n=$1
	local d=$2

	if [[ $d -eq 0 ]]
	then
		echo "#"
		return 1
	fi

	let "int_part = n / d"
	let "dec_part = n % d * 1000 / d"
	if [[ $(($dec_part % 10)) -lt 5 ]]
	then
		let "dec_part = dec_part / 10"
	else
		let "dec_part = dec_part / 10 + 1"
	fi

	echo "$int_part.$dec_part"
}


a=$1
b=$2

let "sum = a + b"
let "diff = a - b"
let "mul = a * b"
div=$(divide $a $b)

echo "$sum $diff $mul $div"