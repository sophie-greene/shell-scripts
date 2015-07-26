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
for s in  {z..a}
do
	#for m in  {a..z}
	#do
		find /home/some/classic/ -iname "$s*.mp3" -a ! -name "$s*mp3.mp3" | parallel -j8 ./mp3M.sh &
		#-exec bash -c './mp3M.sh "$0" "/media/sf_ubuntu/final1/";' ' {} \;&
		#./mp3M.sh "/media/sf_ubuntu/sophf/$s*" "/media/sf_ubuntu/final/";
		echo "$s$m";
	#done
done
#}
