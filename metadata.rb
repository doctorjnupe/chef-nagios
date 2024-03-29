maintainer        "Jerry A. Higgs"
maintainer_email  "jerry@hybridgroup.com"
license           "Apache 2.0"
description       "Installs and configures nagios"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.2.6"

recipe "nagios", "Includes the client recipe."
recipe "nagios::client", "Installs and configures a nagios client with nrpe"
recipe "nagios::server", "Installs and configures a nagios server"
recipe "nagios::pagerduty", "Integrates contacts w/ PagerDuty API"
recipe "nagios::dashboard", "Installs nagios-dashboard"

%w{ apache2 build-essential php perl }.each do |cb|
  depends cb
end

%w{ debian ubuntu redhat centos fedora scientific}.each do |os|
  supports os
end
