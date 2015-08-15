#!/bin/bash
killpro(){
	pgrep perl >txt

	while read f
	do 
	kill $f
	done <txt
}
#killpro;
#: ||{

declare -a list=();
declare -a listm=();
curr="$(pwd)";
cd /media/sf_ubuntu/final
for f in *.mp3
	do
		list=("${list[@]}" "/media/sf_ubuntu/final/$f");
done
for fm in *.m4a
	do
		listm=("${listm[@]}" "/media/sf_ubuntu/final/$fm");
done
cd "$curr"
let lenm=${#listm[@]};

for (( im=0; im<$lenm; im=$im+20));
do 
let sm=$im+19
echo "$im $sm"
	
	parallel -j8 ./m4aM.sh ::: ${listm[@]:$im:$sm} &
done
let len=${#list[@]};

for (( i=0; i<$len; i=$i+20));
do 
let s=$i+19
echo "********************$i $s"
	parallel -j8 ./mp3M.sh ::: ${list[@]:$i:$s} &
	
done

echo "$len***** $lenm"
#for s in  {z..a}
#do
#for m in  {0..9}
	#do
	#let s=10*(s+1);
		#
		#-exec bash -c './mp3M.sh "$0" "/media/sf_ubuntu/final1/";' ' {} \;&
		#./mp3M.sh "/media/sf_ubuntu/sophf/$s*" "/media/sf_ubuntu/final/";
		#echo "$m$s";
#done
#done
#}
