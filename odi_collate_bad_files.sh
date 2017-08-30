#!/bin/sh
file_ext="bad"
bad_count=`find . -mmin -120 -name *.$file_ext|wc -l`
if [ $bad_count -gt 0 ]
then
  ##### remove old bad files ####
  if [ $(find /opt/data/IIT_IPS_IMAGE2/SF_LOGS/BAD_FILES/ -name *.csv|wc -l) -gt 0 ]
  then
          rm /opt/data/IIT_IPS_IMAGE2/SF_LOGS/BAD_FILES/*.csv
  fi

  for f in $(find . -mmin -120 -name *.$file_ext);
  do
        #### assign file name ####
        case $f in
                *CONTRACT*) file_name="CONTRACT" ;;
                *INVOICE*) file_name="INVOICE" ;;
                *PO*) file_name="PO" ;;
                *STUDY*) file_name="STUDY" ;;
        esac
        
        ####collate bad files to BAD_FILES directory ###
        cp $f /opt/data/IIT_IPS_IMAGE2/SF_LOGS/BAD_FILES/BAD_FILE_$file_name.csv
        
        ####archive bad file
        mv $f $(dirname $f)/Archive/$(basename $f .$file_ext)_$file_name_$(date -d "today" +"%Y%m%d_%H%M").$file_ext.csv
  done
  
  #### exit with error to trigger the email
  exit 101
fi
