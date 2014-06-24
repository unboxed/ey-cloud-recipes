#
# Cookbook Name:: whenever
# Recipe:: default
#
 
node[:applications].each do |app_name, _|

  if ! File.exists?("/data/#{app_name}/current")
    Chef::Log.info "Whenever was not configured because the app must be deployed first.  Please deploy it then re-run custom recipes."
    next
  end

  ey_cloud_report "whenever" do
    message "starting whenever recipe"
  end
  
  if ['app_master'].include?(node[:instance_role])
    # be sure to replace "app_name" with the name of your application.
    local_user = node[:users].first
    execute "whenever" do
      cwd "/data/#{app_name}/current"
      user local_user[:username]
      command "bundle exec whenever --set environment=#{node[:environment][:framework_env]} --update-crontab '#{app_name}_#{node[:environment][:framework_env]}'"
      action :run
    end
    
    ey_cloud_report "whenever" do
      message "whenever recipe complete"
    end
  end

end
