echo "Restoring the chef server"
echo -e 'y\n' | sudo knife backup restore -D /home/vagrant/backups --user admin --key /etc/chef-server/admin.pem -c knife.rb
