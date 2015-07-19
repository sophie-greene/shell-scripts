 #!/bin/bash
echo "1 is $1";
export var="$1"

function format_weather_data() {
PYTHON_ARG="$1" python - <<END
import subprocess
import os
import json
PIPE = subprocess.PIPE

json_data = os.environ["var"]
print "#####################"
print json_data;
print "&&&&&&&&&&&&&&&&&&&&&&&&&"
data =json.loads(json_data)
print "*********************"
print data
lookup = {
    '200': 'thunderstorm with light rain',
    '201': 'thunderstorm with rain',
    '202': 'thunderstorm with heavy rain',
    '210': 'light thunderstorm',
    '211': 'thunderstorm',
    '212': 'heavy thunderstorm',
    '221': 'ragged thunderstorm',
    '230': 'thunderstorm with light drizzle',
    '231': 'thunderstorm with drizzle',
    '232': 'thunderstorm with heavy drizzle',
    '300': 'light intensity drizzle',
    '301': 'drizzle',
    '302': 'heavy intensity drizzle',
    '310': 'light intensity drizzle rain',
    '311': 'drizzle rain',
    '312': 'heavy intensity drizzle rain',
    '313': 'shower rain and drizzle',
    '314': 'heavy shower rain and drizzle',
    '321': 'shower drizzle',
    '500': 'light rain',
    '501': 'moderate rain',
    '502': 'heavy intensity rain',
    '503': 'very heavy rain',
    '504': 'extreme rain',
    '511': 'freezing rain',
    '520': 'light intensity shower rain',
    '521': 'shower rain',
    '522': 'heavy intensity shower rain',
    '531': 'ragged shower rain',
    '600': 'light snow',
    '601': 'snow',
    '602': 'heavy snow',
    '611': 'sleet',
    '612': 'shower sleet',
    '615': 'light rain and snow',
    '616': 'rain and snow',
    '620': 'light shower snow',
    '621': 'shower snow',
    '622': 'heavy shower snow',
    '701': 'mist',
    '711': 'smoke',
    '721': 'haze',
    '731': 'sand, dust whirls',
    '741': 'fog',
    '751': 'sand',
    '761': 'dust',
    '762': 'volcanic ash',
    '771': 'squalls',
    '781': 'tornado',
    '800': 'clear sky',
    '801': 'few clouds',
    '802': 'scattered clouds',
    '803': 'broken clouds',
    '804': 'overcast clouds',
    '900': 'tornado',
    '901': 'tropical storm',
    '902': 'hurricane', 
    '903': 'cold',
    '904': 'hot',
    '905': 'windy',
    '906': 'hail',
    '950': 'setting',
    '951': 'calm',
    '952': 'light breeze',
    '953': 'gentle breeze',
    '954': 'moderate breeze',
    '955': 'fresh breeze',
    '956': 'strong breeze',
    '957': 'high wind, near gale',
    '958': 'gale',
    '959': 'severe gale',
    '960': 'storm',
    '961': 'violent storm',
    '962': 'hurricane',
}

print "Current temperature: %g F" % data['main']['temp']
print "Today's high: %g F" % data['main']['temp_max']
print "Today's low: %g F" % data['main']['temp_min']
print "Wind speed: %g mi/hr" % data['wind']['speed']
weather_descs = [lookup.get(str(i['id']), '*error*') for i in data['weather']]
print "Weather: %s" % ', '.join(weather_descs)

END
}

WEATHER_URL="http://api.openweathermap.org/data/2.5/weather?q=Cincinnati,OH&units=imperial"

format_weather_data "$(curl -s $WEATHER_URL)"





##commented out

:||{
 function current_datetime {
python - <<END
import datetime
print datetime.datetime.now()
END
}
 # Call it
current_datetime

# Call it and capture the output
DT=$(current_datetime)
echo Current date and time: $DT


 function line {
PYTHON_ARG="$1" python - <<END
import os
line_len = os.environ['PYTHON_ARG']

print  $line_len
END
}

 
# Do it another way
echo $(line);


metapath="/media/sf_ubuntu/mp3/";

echo "extracting meta data from $1";
path="${1%/*}";
name="${1##*/}";
ext="${1##*.}";

metadata="$metapath${name%.*}.txt";
metanew="$metapath${name%.*}n.txt";
temp="$metapath$name.mp3";
#read metadata in python
#-loglevel panic 
ffmpeg -i "$1"  -y -map 0:0 -codec:a libmp3lame -q:a 2 "$temp";
ffmpeg $(:-loglevel panic ) -i "$temp" -f  ffmetadata "$metadata";

counter=0;
#read tags from metadata file
declare -a val=();
declare -a tag=();
while read x ; 
	do :
	if [ $counter -gt 0 ]; then
		t="${x%=*}";
		val=("${val[@]}" "${x##*=}");
		tag=("${tag[@]}" "$t");
	fi;
		let counter+=1;
	
done < "$metadata";
#create new metadata file with the desired tags only

echo ";FFMETADATA1">"$metanew";
let s=${#tag[@]};
for (( i=0; i<$s; i++ ));
do
   :

case "${tag[$i]}" in
	("title") echo "${tag[$i]}= ${val[$i]}">>"$metanew" && title=$(echo "${val[$i]}" | sed 's/[^a-zA-Z0-9]//g');;
    	("artist") echo "${tag[$i]}= ${val[$i]}">>"$metanew" && artist=$(echo "${val[$i]}" | sed 's/[^a-zA-Z0-9]//g');;
    	("album") echo "${tag[$i]}= ${val[$i]}">>"$metanew" ;;
	("genre") echo "${tag[$i]}= ${val[$i]}">>"$metanew" ;;
	("date") echo "${tag[$i]}= ${val[$i]}">>"$metanew" ;;
    	(*) ;;
  esac
   
done;
out="$metapath$artist-$title.mp3";
echo "out**********************************$out"
ffmpeg -loglevel panic -i "$temp" -i "$metanew" -map_metadata 1 -map 0:0 -c:a copy -id3v2_version 3 -write_id3v1 1 "$out" -y;
rm "$temp";
rm "$metanew";
rm "$metadata";
}
