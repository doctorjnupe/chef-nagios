%w{ 
  nagios3
  nagios-nrpe-plugin
  nagios-images
}.each do |pkg|
  package pkg
end

