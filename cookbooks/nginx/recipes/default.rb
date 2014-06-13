template "/data/nginx/http-custom.conf" do 
  owner "deploy" 
  group "deploy" 
  mode 0755 
  source "http-custom.conf" 
  backup false 
  action :create 
end
