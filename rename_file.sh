#!/bin/sh

for f in $(find . -name *.xml)
do
        file=$(basename $f)
        file_name="${file%.*}"
        f_name=`echo $file_name | sed  "s/MW/PR/g"` ###repace pattern MW with PR
        echo $f_name
        extension="${file##*.}"
        #time=_`date -d "today" +"%Y%m%d_%H%M%S"`
        time=`date -d "today" +"%Y%m%d%H%M%S"`
        #newfilename=$filename$time.$extension
        newfilename=$f_name$time.$extension
        echo "file="$file
        echo "file_name="$file_name
        echo "extension="$extension
        echo "time="$time
        echo "newfilename="$newfilename
done
