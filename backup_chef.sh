#!/bin/sh

#echo `sudo apt-get update`

#echo `sudp apt-get install vim`

echo "Installing gem"

echo `sudo gem install knife-backup --no-ri --no-rdoc`

echo "Unistalling the gem"

`sudo gem uninstall mixlib-shellout -v  '<1.4.0'`

filename=/home/vagrant/knife.rb

echo "Creating file $filename"
`touch $filename`
cat <<EOF > $filename
log_location             STDOUT
validation_client_name   'chef-validator'
validation_key           '/etc/chef-server/chef-validator.pem'
chef_server_url          'https://192.168.10.38'
EOF


echo "BackingUp the server"
trap 'sudo knife backup export -D /home/vagrant/backups --user admin --key /etc/chef-server/admin.pem -c knife.rb' EXIT
