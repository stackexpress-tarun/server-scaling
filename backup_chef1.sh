echo "BackingUp the server"
trap 'sudo knife backup export -D /home/vagrant/backups --user admin --key /etc/chef-server/admin.pem -c knife.rb' EXIT
