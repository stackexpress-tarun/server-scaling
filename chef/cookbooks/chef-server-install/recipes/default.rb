chef_gem "knife-backup" do
  action :install
end

chef_gem "mixlib-shellout" do
  action :remove
  version "<1.4.0"
end

template "/home/vagrant/knife.rb" do
  source "knife.erb"
  mode "0777"
  action "create"
end

cron "backup_chef" do
#  action node.tags.include?('backup_chef') ? :create : :delete
  hour "1"
  weekday "0"
  user "vagrant"
  home "/home/vagrant/"
  command 'cd /home/vagrant/ && ./backup_chef1.sh'
end
