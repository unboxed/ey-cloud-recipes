if ['app_master', 'app'].include?(node[:instance_role])

  service "haproxy" do
    supports :restart => true, :status => true, :reload => true
    action [:enable, :start]
  end

  ruby_block "Update timeouts to allow long-running connections" do
    block do
      # http://www.haproxy.org/download/1.4/doc/configuration.txt says:
      #   "it is highly recommended that the client timeout remains equal
      #   to the server timeout in order to avoid complex
      #   situations to debug"
      timeout = 600_000

      # haproxy can lose a small number of packets during a 'haproxy reload'
      # so we only reload if the file is actually going to change:
      # http://serverfault.com/questions/580595/haproxy-graceful-reload-with-zero-packet-loss
      #
      File.open("/etc/haproxy.cfg") do |f|
        unless f.grep(/timeout client #{timeout}$/).size > 0 &&
               f.grep(/timeout server #{timeout}$/).size > 0
          fe = Chef::Util::FileEdit.new("/etc/haproxy.cfg")
          fe.search_file_replace(/timeout client .*$/, "timeout client #{timeout}")
          fe.search_file_replace(/timeout server .*$/, "timeout server #{timeout}")
          fe.write_file
          resources(:service => "haproxy").run_action(:restart)
        end
      end
    end
  end
end
