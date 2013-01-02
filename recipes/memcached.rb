include_recipe "perl"
cpan_module "YAML"
cpan_module "Nagios::Plugins::Memcached"

# http://search.cpan.org/~zigorou/Nagios-Plugins-Memcached-0.02/lib/Nagios/Plugins/Memcached.pm
nagios_nrpecheck "check_memcached_response" do
  command "#{node['nagios']['plugin_dir']}/check_memcached"
  warning_condition "3"
  critical_condition "5"
  action :add
end

