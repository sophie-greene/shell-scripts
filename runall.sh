#!/bin/bash
killpro(){
	pgrep find >txt

	while read f
	do 
	kill $f
	done <txt
}
#killpro;
#: ||{
#for s in  {z..a}
#do
	#for m in  {0..9}
	#do
	#let s=10*(s+1);
		find /media/mira/26CA0E3FCA0E0BAD/Music -iname "$m*.m4a" | head -50 | parallel -j8 ./mp3M.sh 
		#-exec bash -c './mp3M.sh "$0" "/media/sf_ubuntu/final1/";' ' {} \;&
		#./mp3M.sh "/media/sf_ubuntu/sophf/$s*" "/media/sf_ubuntu/final/";
		#echo "$m$s";
	#done
#done
#}
