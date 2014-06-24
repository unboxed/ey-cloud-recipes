if ['app_master', 'app', 'util', 'solo'].include?(node[:instance_role])

  directory "/data/nginx" do
    owner "root"
    group "root"
    mode 0755
    action :create
  end

  template "/data/nginx/http-custom.conf" do 
    owner "deploy" 
    group "deploy" 
    mode 0755 
    source "http-custom.conf" 
    backup false 
    action :create 
  end

end
