removespace (){
	FOO="$1"
	FOO_NO_TRAIL_SPACE="$(echo -e "${FOO}" | sed -e 's/[[:space:]]*$//')"
	#echo -e "FOO_NO_TRAIL_SPACE='${FOO_NO_TRAIL_SPACE}'"

	FOO_NO_SPACE="$(echo -e "${FOO_NO_TRAIL_SPACE}" | sed -e 's/^[[:space:]]*//')"
	echo "${FOO_NO_SPACE}"

	#echo -e "length(FOO_NO_TRAIL_SPACE)==$(echo -ne "${FOO_NO_SPACE}" | wc -m)"
	# > length(FOO_NO_TRAIL_SPACE)==15
}
removenonalpha()
{
	non="$(echo  "$1" | sed -e 's/[^a-zA-Z|0-9| |_\-]//g' )";
  	echo "$non";
}
removespace "      jjj      ";
removenonalpha "dhd'   hjd/GJ*c--_KL'ddk\;  ";
