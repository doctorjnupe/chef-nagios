case node['platform']
when "ubuntu","debian"
  set['nagios']['client']['install_method'] = 'package'
  set['nagios']['nrpe']['pidfile'] = '/var/run/nagios/nrpe.pid'
when "redhat","centos","fedora","scientific"
  set['nagios']['client']['install_method'] = 'source'
  set['nagios']['nrpe']['pidfile'] = '/var/run/nrpe.pid'
else
  set['nagios']['client']['install_method'] = 'source'
  set['nagios']['nrpe']['pidfile'] = '/var/run/nrpe.pid'
end

set['nagios']['nrpe']['home']       = "/usr/lib/nagios"
set['nagios']['nrpe']['conf_dir']   = "/etc/nagios"
set['nagios']['nrpe']['dont_blame_nrpe']   = "0"
set['nagios']['nrpe']['command_timeout']   = "60"

# for plugin from source installation
default['nagios']['plugins']['url']      = 'http://prdownloads.sourceforge.net/sourceforge/nagiosplug'
default['nagios']['plugins']['version']  = '1.4.15'
default['nagios']['plugins']['checksum'] = '51136e5210e3664e1351550de3aff4a766d9d9fea9a24d09e37b3428ef96fa5b'

# for nrpe from source installation
default['nagios']['nrpe']['url']      = 'http://prdownloads.sourceforge.net/sourceforge/nagios'
default['nagios']['nrpe']['version']  = '2.12'
default['nagios']['nrpe']['checksum'] = '7e8d093abef7d7ffc7219ad334823bdb612121df40de2dbaec9c6d0adeb04cfc'

default['nagios']['checks']['memory']['critical'] = 150
default['nagios']['checks']['memory']['warning']  = 250
default['nagios']['checks']['load']['critical']   = "30,20,10"
default['nagios']['checks']['load']['warning']    = "15,10,5"
default['nagios']['checks']['smtp_host'] = String.new

default['nagios']['server_role'] = "monitoring"
default['nagios']['multi_environment_monitoring'] = true
