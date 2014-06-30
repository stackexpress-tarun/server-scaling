echo "Installing chef server"

trap "wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.1.1-1_amd64.deb" EXIT

if [ -f chef-serv*.deb ]
then
	echo "Moving into selected directory"
	
	`sudo mv chef-serve*.deb /home/vagrant/`
	
	echo "Install the package"
	
	trap "sudo dpkg -i chef-server*.deb" EXIT
	
	echo -e `sudo chef-server-ctl reconfigure`

	echo -e `sudo chef-server-ctl upgrade`
else
	echo "Chef server is not downloaded properly"
fi

echo "complete chef server setup"

filename=/etc/chef-server/chef-server.rb

server_ip=192.168.10.38

`sudo touch /etc/chef-server/chef-server.rb`

echo "Creating file $filename"

`sudo chmod 777 $filename`

sudo cat <<EOF > $filename

topology "standalone"

api_fqdn "https://$server_ip"

chef_server_webui['enable'] = true
bookshelf['vip'] = "https://$server_ip"
nginx['url'] = "https://$server_ip"
nginx['server_name'] = "https://$server_ip"
lb['fqdn'] = "https://$server_ip"
lb['api_fqdn'] = "https://$server_ip"
lb['web_ui_fqdn'] = "https://$server_ip"
erchef['s3_url_ttl'] = 3600

EOF

echo -e "After creating chef server file. Reconfigure the sever"
echo -e  `sudo chef-server-ctl reconfigure`
