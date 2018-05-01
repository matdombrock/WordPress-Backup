#!/bin/bash
name=<TITLE> #used only for file names
#DB CONNECTION INFO
password=<DATABASE USER PASSWORD>
db_name=<DATABASE NAME>
#config options
web_root=/var/www/html/
temp_output=/var/www/html/backup/ #one-time download backup location. Should be on web root.
output=/root/ #main backup location. Should not be avail to webroot.
touch ${temp_output}/index.html
read -p "Do you want to purge the old temporary backups? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    rm -R ${temp_output}/*
fi
t=$(date +%s)
d=$(date)
mkdir ${t}
touch ${t}/"${d}"
mysqldump --password="${password}" ${db_name} >> ${t}/${db_name}.sql
zip -r ${t}/files.zip ${web_root}* -x "${temp_output}*"
zip -r ${name}+${t}.zip ${t}/*
cp ${name}+${t}.zip ${temp_output}
cp ${name}+${t}.zip ${output}
rm -R ${t}
rm ${name}+${t}.zip
