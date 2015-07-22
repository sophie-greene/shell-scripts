#!/bin/bash
cur="$(pwd)"
cd $1
declare -a s=();
declare -a n=();
j=0
for FILE in *; 
do 
t1="$(stat -c '%s' "$FILE")"; 
t2="$(stat -c '%n' "$FILE")";
let j=$j+1;
echo "$j"
if  [ "$t2" == "*[0-9]*" ] ; then
	echo "$j -$t1- $t2"
fi

s=("${s[@]}" "$t1"); 
n=("${n[@]}" "$t2");
done 
#echo "${s[@]} ${n[@]}";
let m=${#s[@]};
for (( i=0; i<$m; i++ ));
do

#echo "-------------------$i ${n[$i]}"
	if [ "${s[$i]}" == "${s[116]}" ] ; then
		echo "$i file equal in size to ${s[116]} ${n[116]}  is ${n[$i]}"
	fi	
done

cd "$cur"
#| awk -F/ '{if ($1 in a)print $2; else a[$1]=1}' | xargs echo rm
