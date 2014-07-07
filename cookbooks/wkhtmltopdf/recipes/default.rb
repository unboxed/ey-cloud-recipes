if ['app_master', 'app', 'util', 'solo'].include?(node[:instance_role])
  remote_file "/usr/local/bin/wkhtmltopdf" do
    source "wkhtmltopdf-amd64"
    mode 0755
    owner "root"
    group "root"
  end
end
