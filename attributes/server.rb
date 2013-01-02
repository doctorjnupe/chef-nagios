default['nagios']['pagerduty_key'] = ""

case node['platform']
when "ubuntu","debian"
  set['nagios']['server']['install_method'] = 'package'
  set['nagios']['server']['service_name']   = 'nagios3'
when "redhat","centos","fedora","scientific"
  set['nagios']['server']['install_method'] = 'source'
  set['nagios']['server']['service_name']   = 'nagios'
else
  set['nagios']['server']['install_method'] = 'source'
  set['nagios']['server']['service_name']   = 'nagios'
end

set['nagios']['home']       = "/usr/lib/nagios3"
set['nagios']['conf_dir']   = "/etc/nagios3"
set['nagios']['config_dir'] = "/etc/nagios3/conf.d"
set['nagios']['log_dir']    = "/var/log/nagios3"
set['nagios']['cache_dir']  = "/var/cache/nagios3"
set['nagios']['state_dir']  = "/var/lib/nagios3"
set['nagios']['run_dir']    = "/var/run/nagios3"
set['nagios']['docroot']    = "/usr/share/nagios3/htdocs"
set['nagios']['enable_ssl'] = false
set['nagios']['http_port']  = node['nagios']['enable_ssl'] ? "443" : "80"
set['nagios']['server_name'] = node.has_key?(:domain) ? "nagios.#{domain}" : "nagios"
set['nagios']['ssl_req'] = "/C=US/ST=Several/L=Locality/O=Example/OU=Operations/" +
  "CN=#{node['nagios']['server_name']}/emailAddress=ops@#{node['nagios']['server_name']}"

# for server from source installation
default['nagios']['server']['url']      = 'http://prdownloads.sourceforge.net/sourceforge/nagios'
default['nagios']['server']['version']  = '3.2.3'
default['nagios']['server']['checksum'] = '7ec850a4d1d8d8ee36b06419ac912695e29962641c757cf21301b1befcb23434'

default['nagios']['notifications_enabled']   = 0
default['nagios']['check_external_commands'] = true
default['nagios']['default_contact_groups']  = %w(admins)
default['nagios']['sysadmin_email']          = "root@localhost"
default['nagios']['sysadmin_sms_email']      = "root@localhost"
default['nagios']['server_auth_method']      = "oauth"

# This setting is effectively sets the minimum interval (in seconds) nagios can handle.
# Other interval settings provided in seconds will calculate their actual from this value, since nagios works in 'time units' rather than allowing definitions everywhere in seconds

default['nagios']['templates'] = Mash.new
default['nagios']['interval_length'] = 1

# Provide all interval values in seconds
default['nagios']['default_host']['check_interval']     = 15
default['nagios']['default_host']['retry_interval']     = 15
default['nagios']['default_host']['max_check_attempts'] = 1
default['nagios']['default_host']['notification_interval'] = 300

default['nagios']['default_service']['check_interval']     = 60
default['nagios']['default_service']['retry_interval']     = 15
default['nagios']['default_service']['max_check_attempts'] = 3
default['nagios']['default_service']['notification_interval'] = 1200

default['nagios']['appserver_role']      = "appserver"
default['nagios']['webserver_role']      = "webserver"
default['nagios']['databaseserver_role'] = "postgresql-master"

#just for good measure, keep in client and server files
default['nagios']['multi_environment_monitoring'] = true
