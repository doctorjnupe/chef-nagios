mon_host = ['127.0.0.1']

if node.run_list.roles.include?(node['nagios']['server_role'])
  mon_host << node['ipaddress']
else
  search(:node, "role:#{node['nagios']['server_role']} AND chef_environment:#{node.chef_environment}") do |n|
    mon_host << n['ipaddress']
  end
end

include_recipe "nagios::client_#{node['nagios']['client']['install_method']}"

remote_directory node['nagios']['plugin_dir'] do
  source "plugins"
  owner "root"
  group "root"
  mode 0755
  files_mode 0755
end

directory "#{node['nagios']['nrpe']['conf_dir']}/nrpe.d" do
  owner "root"
  group "root"
  mode 0755
end

template "#{node['nagios']['nrpe']['conf_dir']}/nrpe.cfg" do
  source "nrpe.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :mon_host => mon_host,
    :nrpe_directory => "#{node['nagios']['nrpe']['conf_dir']}/nrpe.d"
  )
  notifies :restart, "service[nagios-nrpe-server]"
end

service "nagios-nrpe-server" do
  case node[:platform]
  when "ubuntu"
    provider Chef::Provider::Service::Init::Debian
  end

  action [ :enable, :start ]
  supports :restart => true, :reload => true
end

nagios_nrpecheck "check_load" do
  command "#{node['nagios']['plugin_dir']}/check_load"
  warning_condition node['nagios']['checks']['load']['warning']
  critical_condition node['nagios']['checks']['load']['critical']
  action :add
end

nagios_nrpecheck "check_all_disks" do
  command "#{node['nagios']['plugin_dir']}/check_disk"
  warning_condition "8%"
  critical_condition "5%"
  parameters "-A -x /dev/shm -X nfs -i /boot"
  action :add
end

nagios_nrpecheck "check_users" do
  command "#{node['nagios']['plugin_dir']}/check_users"
  warning_condition "20"
  critical_condition "30"
  action :add
end

unless node[:memcached].nil?
  include_recipe "nagios::memcached"
end

