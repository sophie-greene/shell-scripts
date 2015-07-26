#!/bin/bash
cur="$(pwd)"
cd $1

j=0
find "$1" -name "*[0-9]).mp3" >files.txt
while read FILE; 
do 
t1="$(stat -c '%s' "$FILE")"; 
t2="$(stat -c '%n' "$FILE")";
let j=$j+1;
echo "$j"
if  [ "$t2" == "*[0-9]*" ] ; then
	echo "$j -$t1- $t2"
fi
temp="$t2";
	orig="${temp%* *[0-9]).mp3}.mp3";
	 echo "$orig $t2";
	if [ -f "$orig" ] ; then
		so="$(stat -c '%s' "$orig")";
		echo "orig size $so currfile size is $t1"
		if [ "$so" == "$t1" -o "$so" -gt "$t1" ] ; then 
			echo "deleting ... $t2"
			rm "$t2"
		elif [ "$so" -lt "$t1" ] ; then
			echo "moving $t2 to $orig";
			mv "$t2" "$orig"
		else
			echo "$orig moving $t1 to $so not recomended";
		fi
	fi	

done <files.txt
#echo "${s[@]} ${n[@]}";
#let m=${#s[@]};
#for (( i=0; i<$m; i++ ));
#do
#	temp="${n[$i]}";
#	orig="${temp%* ([0-9]).mp3}";
#echo "$orig"
#	if [ -f "$orig" ] ; then
#		echo "rm"
#	fi	
#done 
rm files.txt

cd "$cur"
#| awk -F/ '{if ($1 in a)print $2; else a[$1]=1}' | xargs echo rm
