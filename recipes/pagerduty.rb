package "libwww-perl" do
  case node[:platform]
  when "redhat","centos","scientific","fedora","suse"
    package_name "perl-libwww-perl"
  when "debian","ubuntu"
    package_name "libwww-perl"
  when "arch"
    package_name "libwww-perl"
  end
  action :install
end

package "libcrypt-ssleay-perl" do
  case node[:platform]
  when "redhat","centos","scientific","fedora","suse"
    package_name "perl-Crypt-SSLeay"
  when "debian","ubuntu"
    package_name "libcrypt-ssleay-perl"
  when "arch"
    package_name "libcrypt-ssleay-perl"
  end
  action :install
end

template "#{node['nagios']['config_dir']}/pagerduty_nagios.cfg" do
  owner "nagios"
  group "nagios"
  mode 0644
  source "pagerduty_nagios.cfg.erb"
end

remote_file "#{node['nagios']['plugin_dir']}/pagerduty_nagios.pl" do
  owner "root"
  group "root"
  mode 0755
  source "http://www.pagerduty.com/configs/pagerduty_nagios.pl"
  action :create_if_missing
end

cron "Flush Pagerduty" do
  user "nagios"
  mailto "root@localhost"
  command "#{node['nagios']['plugin_dir']}/pagerduty_nagios.pl flush"
end

