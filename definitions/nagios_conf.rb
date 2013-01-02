define :nagios_conf, :variables => {}, :config_subdir => true do
  
  conf_dir = params[:config_subdir] ? node['nagios']['config_dir'] : node['nagios']['conf_dir']

  template "#{conf_dir}/#{params[:name]}.cfg" do
    owner "nagios"
    group "nagios"
    source "#{params[:name]}.cfg.erb"
    mode 0644
    variables params[:variables]
    notifies :reload, "service[nagios]"
    backup 0
  end
end
