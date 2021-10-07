#!/bin/bash

# [Arguments]
# $1: the folder path name to save to
#     ex) /var/backup/
# $2: the folder path name that you want to backup
#     ex) /var/www/html/
# $3: the number of folders that can exist
#
# [How to use]
# ./make_backup.sh /var/backup/ /var/www/html/
#
# [Notes]
# * add "/" to the end of the argument folder path names
# * use full path names for argument path names

# backup
datestr=`date +%Y_%m_%d_%H_%M_%S`
eval "tar -czf $1${datestr}.tgz $2"
if [ $? -ne 0 ]
then
    echo "[ERROR] tar error."
    exit 1
fi

# delete old files
CNT=0
for file in `ls -1t ${1}*`
do
    CNT=$((CNT+1))
    if [ ${CNT} -le $3 ]
    then
        continue
    fi

    eval "rm ${file}"
    if [ $? -ne 0 ]
    then
        echo "[ERROR] rm error."
        exit 1
    fi
done

exit 0

