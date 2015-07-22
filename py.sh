 #!/bin/bash
echo "1 is $1";
export var="$1"

function jdata() {
PYTHON_ARG="$1" python - <<END

import os
import json
import xml.etree.ElementTree as etree  

name = os.environ["var"]

tree = etree.parse(name) 
root=tree.getroot()  
print len(root)   

for child in root: d=child
root.attrib      
root.findall(d)
END
}


jdata "$1";




