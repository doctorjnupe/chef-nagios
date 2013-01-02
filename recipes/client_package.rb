%w{
  nagios-nrpe-server
  nagios-plugins
  nagios-plugins-basic
  nagios-plugins-standard
}.each do |pkg|
  package pkg
end

