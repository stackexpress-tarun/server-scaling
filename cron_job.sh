#!/bin/bash

crontab -l > backup_chef
#echo new cron into cron file
echo "*/10 * * * * cd /home/vagrant/ && ./backup_chef.sh" >> backup_chef
#install new cron file
crontab backup_chef
rm backup_chef
